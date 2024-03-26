//
//  FontStyleDeeplinkManager.swift
//  MEMBaseExample
//
//  Created by Miller Mosquera on 4/03/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import MEMBase

class FontStyleRouteHandler: MEMBaseRouteHandlerProtocol {
    
    let manager: MEMBaseDeeplinkManager = MEMBaseDeeplinkManager.shared
 
    func add() {
        manager.register(endPoint: "fontstyle", viewController: FontManagerViewController.self)
    }
}
