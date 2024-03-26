//
//  BaseCache.swift
//  MEMBase
//
//  Created by Miller Mosquera on 7/03/24.
//

import Foundation
import UIKit


/**
 * Class for caching images
 * - authors: https://medium.com/@mshcheglov/reusable-image-cache-in-swift-9b90eb338e8d
 */

public protocol MEMCacheProtocol: AnyObject {
    func get(for url: URL) -> UIImage?
    func insert(_ data: UIImage?, for url: URL)
    func remove(for url: URL)
    func removeAll()
    subscript(_ url: URL) -> UIImage? { get set }
}

public class MEMBaseCache: MEMCacheProtocol {
    
    public struct Constants {
        public static let countLimit = 100
        public static let memoryLimit = 1024 * 1024 * 100 // 100 MB
    }
    
    // Soft data
    public struct Configuration {
        let countLimit: Int
        let memoryLimit: Int
        
        public init(countLimit: Int, memoryLimit: Int) {
            self.countLimit = countLimit
            self.memoryLimit = memoryLimit
        }
    }
    
    
    private var lock = NSLock()
    private var configuration: Configuration
    
    //
    private lazy var imagesCache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.countLimit = Constants.countLimit
        return cache
    }()
    
    // 
    private lazy var decodedImagesCache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.totalCostLimit = Constants.memoryLimit
        return cache
    }()
    
    public init(configuration: Configuration = Configuration(countLimit: Constants.countLimit, memoryLimit: Constants.memoryLimit)) {
        self.configuration = configuration
    }
    
    public func get(for url: URL) -> UIImage? {
        lock.lock() 
        defer { lock.unlock() }
        print("This image already exist")
        // the best case scenario -> there is a decoded image
        if let decodedImage = decodedImagesCache.object(forKey: url as AnyObject) as? UIImage {
            print("Is decoded")
            return decodedImage
        }
        
        // search for image data
        if let image = imagesCache.object(forKey: url as AnyObject) as? UIImage {
            let decodedImage = image.decodedImage()
            decodedImagesCache.setObject(image as AnyObject, forKey: url as AnyObject, cost: decodedImage.diskSize)
            print("Had to be decoded")
            return decodedImage
        }
        
        return nil
    }
    
    public func insert(_ data: UIImage?, for url: URL) {
        guard let image = data else { return remove(for: url) }
        let decodedImage = image.decodedImage()

        lock.lock()
        defer { lock.unlock() }
        imagesCache.setObject(decodedImage, forKey: url as AnyObject)
        decodedImagesCache.setObject(image as AnyObject, forKey: url as AnyObject, cost: decodedImage.diskSize)
    }
    
    public func remove(for url: URL) {
        lock.lock()
        defer { lock.unlock() }
        imagesCache.removeObject(forKey: url as AnyObject)
        decodedImagesCache.removeObject(forKey: url as AnyObject)
    }
    
    public func removeAll() {
        imagesCache.removeAllObjects()
    }
    
    /**
     * subscription
     * - parameters url: image's path from web
     */
    public subscript(url: URL) -> UIImage? {
        get {
            return get(for: url)
        }
        set {
            return insert(newValue, for: url)
        }
    }
}
