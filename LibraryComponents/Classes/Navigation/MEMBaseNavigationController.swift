//
//  MEMBaseNavigationController.swift
//  MCBase
//
//  Created by Miller Mosquera on 2/03/24.
//

import Foundation
import UIKit

/// #Important: Think in another name for this class
open class MEMBaseNavigationController {
    
    public static let shared = MEMBaseNavigationController()
    
    private init(){}
    
    /**
     * For new iOS versions only
     *
     */
    public func getUIWindow(scene: UIScene,
                            connectionOptions: UIScene.ConnectionOptions,
                            rooViewController: UIViewController,
                            completion: ( _ urlContext: Set<UIOpenURLContext>) -> Void  ) -> UIWindow? {
        
        guard let windowScene = (scene as? UIWindowScene) else {return nil}
        
        let window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window.windowScene = windowScene
        window.rootViewController = UINavigationController(rootViewController: rooViewController)
        window.makeKeyAndVisible()
                
        completion(connectionOptions.urlContexts)
        
        return window
    }
    
    /**
     * For old iOS versions only
     *
     */
    public func getWindow(viewController: MEMBaseViewController) -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UINavigationController(rootViewController: viewController)
        window.makeKeyAndVisible()
        window.overrideUserInterfaceStyle = .light
        return window
    }
    
    public func presentViewControllerWithTop(viewController: UIViewController) {
        viewController.modalPresentationStyle = .fullScreen
        
        if let topViewController = UIApplication.getTopViewController() {
            topViewController.modalPresentationStyle = .fullScreen
            topViewController.navigationController?.pushViewController(viewController, animated: false)
        }
    }
    
    /**
     * Open the view controller
     * - parameters path: class name or file name to open
     * - parameters viewControllerData: 
     * open the view controller using the presentViewController, the viewController base class must be MCBaseViewController,
     * this because we need to pass the data to the .init() function
     */
    /// #Important: If the target name has an special sign in its name, it won't work, for instance: MCBase-Example
    public func open(path: String, viewControllerData: [String: Any]) {
        if let viewControllerType = NSClassFromString(path) as? MEMBaseViewController.Type {
            let viewController = viewControllerType.init(data: viewControllerData)
            presentViewControllerWithTop(viewController: viewController)
        }
    }
    
}
