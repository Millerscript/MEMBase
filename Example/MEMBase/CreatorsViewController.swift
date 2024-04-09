//
//  CreatorsViewController.swift
//  MCBase_Example
//
//  Created by Miller Mosquera on 2/03/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import MEMBase

class CreatorsViewController: MEMBaseViewController {
    
    let label: UILabel = {
        let label = UILabel.newSet()
        label.textColor = .black
        label.numberOfLines = 1
        label.text = "Creators"
        return label
    }()
    
    let nextView: UIButton = {
        let button = UIButton.newSet()
        button.setTitle("Next view", for: .normal)
        button.backgroundColor = .green
        button.tintColor = .white
        return button
    }()
    
    required init(data: [String : Any]) {
        print("view controller data from creators \(data)")
        let name = data["next_deeplink"] ?? ""
        print(name)
        super.init(data: data)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray.withAlphaComponent(0.8)
        setLabel()
        setButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showNavigationBar()
    }
    
    func setLabel() {
        self.view.addSubview(label)
        label.hookAxis(.horizontal, sameOf: self.view)
        label.hookAxis(.vertical, sameOf: self.view)
    }
    
    func setButton() {
        self.view.addSubview(nextView)
        
        nextView.hook(.top, to: .bottom, of: label, valueInset: 20)
        nextView.hookAxis(.horizontal, sameOf: label)
        nextView.setDimension(dimension: .width, value: 100)
        
        nextView.addTarget(self, action: #selector(nextViewAction), for: .touchDown)
    }
    
    @objc func nextViewAction() {
        open(deeplink: "mcbase://questions")
    }
}
