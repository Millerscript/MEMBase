//
//  MEMBaseFontStyles.swift
//  MEMBase
//
//  Created by Miller Mosquera on 2/03/24.
//

import Foundation
import UIKit

public struct MEMBaseFontSizes {
    public static var titleS: CGFloat = 18
    public static var titleM: CGFloat = 22
    public static var titleXL: CGFloat = 26
    
    public static var bodyS: CGFloat = 12
    public static var bodyM: CGFloat = 16
    public static var bodyXL: CGFloat = 20
}

public protocol MEMBaseFontStyles {
    func regular(size: CGFloat) -> UIFont?
    func medium(size: CGFloat) -> UIFont?
    func thin(size: CGFloat) -> UIFont?
    func light(size: CGFloat) -> UIFont?
    func italic(size: CGFloat) -> UIFont?
    func semibold(size: CGFloat) -> UIFont?
    func bold(size: CGFloat) -> UIFont?
}

/*public enum BaseColors: String {
    case primary
    case secondary
}

extension UIColor {

    public func AppColor(_ name: BaseColors) -> UIColor {
        
        switch name {
        case .primary:
            return UIColor(red: 034, green: 024, blue: 055, alpha: 1)
        case .secondary:
            return UIColor(red: 44, green: 147, blue: 255, alpha: 1)
        }
    }
}*/
