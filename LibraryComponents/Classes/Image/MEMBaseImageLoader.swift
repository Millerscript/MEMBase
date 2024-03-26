//
//  MEMBaseImageLoader.swift
//  MEMBase
//
//  Created by Miller Mosquera on 4/03/24.
//

import Foundation
import UIKit.UIImage
import Combine

open class MEMBaseImageLoader {
    
    public static let shared = MEMBaseImageLoader()

    private let cache: MEMCacheProtocol

    private lazy var backgroundQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 5
        return queue
    }()

    public init(cache: MEMCacheProtocol = MEMBaseCache()) {
        self.cache = cache
    }

    /**
     * Download the image using Combine
     * - parameters url: Path to the original image
     * - returns:
     */
    public func downloadImage(from url: URL) -> AnyPublisher<UIImage?, Never> {
     
        if let image = cache[url] {
            return Just(image).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
                .map { (data, response) -> UIImage? in return UIImage(data: data) }
                .catch { error in return Just(nil) }
                .handleEvents(receiveOutput: {[unowned self] image in
                  
                    guard let image = image else { return }
                    self.cache[url] = image
                })
                .print("Downloading image...")
                .subscribe(on: backgroundQueue)
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
    }
    
    /**
     * Download the image using async/await
     * - parameters url:
     * - returns: The image downloaded
     */
    public func downloadImage(from url: URL) async throws -> UIImage? {
        
        if let image = cache[url] {
            return image
        }
        
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        
        guard let imageR = UIImage(data: data) else { return nil }
        cache[url] = imageR
        
        return imageR
    }
    
    /**
     * Download the image with Grand Central Dispatch
     * - parameters url:
     * - parameters completion(_ data:):
     * 
     */
    public func downloadImage(url: URL, completion: @escaping(_ data: UIImage?) -> ()?) {
        
        if let image = cache[url] {
            completion(image)
        } else {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.cache[url] = image
                            completion(image)
                        }

                    }
                }
            }
        }
    }
    
    /**
     * Check if the passed url already exist in the cache
     * - parameters url: path to the web image
     * - returns: true if the url is already in the cache and the opposite if doesn't
     */
    public func gotCache(usign url: URL) -> Bool {
        guard let _ = cache[url] else { return false }
        return true
    }
}
