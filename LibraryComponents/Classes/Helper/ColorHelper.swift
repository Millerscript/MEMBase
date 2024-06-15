//
//  ColorHelper.swift
//  MEMBase
//
//  Created by Miller Mosquera on 14/06/24.
//

import Foundation

public class ColorHelper {
    
    static func colorFrom(hex: String) -> UIColor? {
        let red, green, blue, alpha: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            var hexNumber: UInt64 = 0
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)

                if scanner.scanHexInt64(&hexNumber) {
                    red = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    green = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    blue = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    alpha = CGFloat(hexNumber & 0x000000ff) / 255

                    return UIColor(red: red, green: green, blue: blue, alpha: alpha)
                }
            }
            
            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                if scanner.scanHexInt64(&hexNumber) {
                    red = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    green = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    blue = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255

                    return UIColor(red: red, green: green, blue: blue, alpha: 1)
                }
            }
            
        }
        
        return .clear
    }
    
    static func colorRGB(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor? {
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    static func colorResources(name: String) -> UIColor? {
        return UIColor(named: name) ?? .clear
    }
}
