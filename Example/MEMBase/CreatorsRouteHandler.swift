//
//  CreatorsDeeplinkManager.swift
//  MEMBaseExample
//
//  Created by Miller Mosquera on 2/03/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import MEMBase

class CreatorsRouteHandler: MEMBaseRouteHandlerProtocol {
    var manager: MEMBaseDeeplinkManager = MEMBaseDeeplinkManager.shared
    
    func add() {
        manager.register(endPoint: "profile", viewController: CreatorsViewController.self)
    }
    
    
}
