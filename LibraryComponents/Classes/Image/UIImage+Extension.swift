//
//  UIImage+Extension.swift
//  MEMBase
//
//  Created by Miller Mosquera on 4/03/24.
//

import Foundation
import UIKit.UIImage

extension UIImage {

    /**
     This function consumes a regular UIImage and returns a decompressed and rendered version.
     It makes sense to have a cache of decompressed images.
     This should improve drawing performance, but with the cost of extra storage.
     */
    public func decodedImage() -> UIImage {
        guard let cgImage = cgImage else { return self }
        
        let size = CGSize(width: cgImage.width, height: cgImage.height)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: 8, bytesPerRow: cgImage.bytesPerRow, space: colorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
        
        context?.draw(cgImage, in: CGRect(origin: .zero, size: size))
        
        guard let decodedImage = context?.makeImage() else { return self }
        
        return UIImage(cgImage: decodedImage)
    }
    
    // Rough estimation of how much memory image uses in bytes
    var diskSize: Int {
        guard let cgImage = cgImage else { return 0 }
        return cgImage.bytesPerRow * cgImage.height
    }
}
