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
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 1
        label.text = "Creators"
        return label
    }()
    
    
    let nextView: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Next view", for: .normal)
        button.backgroundColor = .green
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
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
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    func setButton() {
        self.view.addSubview(nextView)
        NSLayoutConstraint.activate([
            nextView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            nextView.centerXAnchor.constraint(equalTo: label.centerXAnchor),
            nextView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        nextView.addTarget(self, action: #selector(nextViewAction), for: .touchDown)
    }
    
    @objc func nextViewAction() {
        open(deeplink: "mcbase://questions")
    }
}
