//
//   ImageCacheRouteHandler.swift
//  MEMBaseExample
//
//  Created by Miller Mosquera on 6/03/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import MEMBase

class ImageCacheRouteHandler: MEMBaseRouteHandlerProtocol {
    
    var manager: MEMBaseDeeplinkManager = MEMBaseDeeplinkManager.shared
    
    func add() {
        manager.register(endPoint: "images", viewController: ImageCacheViewController.self)
    }
    
    
}
