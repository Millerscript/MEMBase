//
//  ImageCache.swift
//  MEMBase
//
//  Created by Miller Mosquera on 4/03/24.
//

import Foundation
import UIKit.UIImage

// How to create cache
// https://www.hackingwithswift.com/example-code/system/how-to-cache-data-using-nscache

// Example
// https://medium.com/@mshcheglov/reusable-image-cache-in-swift-9b90eb338e8d
/*@available(*, deprecated, renamed: "MCBaseCache", message: "Use MCBaseCache class instead")
public class ImageCache {
    private let lock = NSLock()
    private let config: Config
    
    // 1st level cache, that contains encoded images
    private lazy var imageCache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.countLimit = config.countLimit
        return cache
    }()
    
    // 2nd level cache, that contains decoded images
    private lazy var decodedImageCache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.totalCostLimit = config.memoryLimit
        return cache
    }()
    
    public struct Config {
        let countLimit: Int
        let memoryLimit: Int
        public static let defaultConfig = Config(countLimit: 100, memoryLimit: 1024 * 1024 * 100) // 100 MB
    }

    public init(config: Config = Config.defaultConfig) {
        self.config = config
    }
}

extension ImageCache {
    
    public func image(for url: URL) -> UIImage? {
        
        lock.lock(); defer { lock.unlock() }
       
        // the best case scenario -> there is a decoded image
        if let decodedImage = decodedImageCache.object(forKey: url as AnyObject) as? UIImage {
            return decodedImage
        }
        
        // search for image data
        if let image = imageCache.object(forKey: url as AnyObject) as? UIImage {
            let decodedImage = image.decodedImage()
            decodedImageCache.setObject(image as AnyObject, forKey: url as AnyObject, cost: decodedImage.diskSize)
            return decodedImage
        }
        
        return nil
    }
    
}

extension ImageCache {
    public subscript(_ key: URL) -> UIImage? {
        get {
            return image(for: key)
        }
        set {
            return insertImage(newValue, for: key)
        }
    }
}

extension ImageCache: ImageCacheType {
    
    public func removeAllImages() {
        imageCache.removeAllObjects()
    }
    
    public func insertImage(_ image: UIImage?, for url: URL) {
        guard let image = image else { return removeImage(for: url) }
        let decodedImage = image.decodedImage()

        lock.lock(); defer { lock.unlock() }
        imageCache.setObject(decodedImage, forKey: url as AnyObject)
        decodedImageCache.setObject(image as AnyObject, forKey: url as AnyObject, cost: decodedImage.diskSize)
    }

    public func removeImage(for url: URL) {
        lock.lock(); defer { lock.unlock() }
        imageCache.removeObject(forKey: url as AnyObject)
        decodedImageCache.removeObject(forKey: url as AnyObject)
    }
}
*/
