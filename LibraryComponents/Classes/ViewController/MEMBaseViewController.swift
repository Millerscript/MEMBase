//
//  MEMBaseViewController.swift
//  MEMBase
//
//  Created by Miller Mosquera on 1/03/24.
//

import Foundation
import UIKit

open class MEMBaseViewController: UIViewController {
    
    var data: [String: Any]
    
    required public init(data: [String: Any]) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        return nil
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func hideNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    public func showNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    public func open(deeplink: String) {
        MEMBaseDeeplinkManager.shared.open(deepLink: deeplink)
    }
    
    public func close() {
        self.navigationController?.popViewController(animated: true)
    }
}
