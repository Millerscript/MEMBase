//
//  LocalDatabaseRouteHandler.swift
//  MEMBaseExample
//
//  Created by Miller Mosquera on 5/03/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import MEMBase

class LocalDatabaseRouteHandler: MEMBaseRouteHandlerProtocol {
    let manager: MEMBaseDeeplinkManager = MEMBaseDeeplinkManager.shared
 
    func add() {
        manager.register(endPoint: "localdatabase", viewController: LocalDatabaseViewController.self)
    }
}
