//
//  Application+Extension.swift
//  MCBase
//
//  Created by Miller Mosquera on 2/03/24.
//

import Foundation
@available(iOS 15.0, *)
extension UIApplication {

    class func getTopViewController(base: UIViewController? = UIApplication
        .shared
        .connectedScenes
        .compactMap { ($0 as? UIWindowScene)?.keyWindow }
        .first?
        .rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)

        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)

        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        
        return base
    }
}
