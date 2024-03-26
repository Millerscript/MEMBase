//
//  MEMBaseRouteHandlerProtocol.swift
//  MEMBase
//
//  Created by Miller Mosquera on 2/03/24.
//

import Foundation

public protocol MEMBaseRouteHandlerProtocol: AnyObject {
    var manager: MEMBaseDeeplinkManager { get }
    func add()
}
