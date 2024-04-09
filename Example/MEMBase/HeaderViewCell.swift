//
//  HeaderViewCell.swift
//  MEMBaseExample
//
//  Created by Miller Mosquera on 4/03/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import MEMBase

class HeaderViewCell: UIView {
    
    let titleLbl: UILabel = {
        let label = UILabel.newSet()
        label.text = "MCBase App"
        label.textColor = .black
        label.font = UIFont(name: "Poppins-Light", size: 28.0)
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setTitle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTitle() {
        self.addSubview(titleLbl)
        titleLbl.hook(.left, to: .left, of: self)
        titleLbl.hook(.right, to: .right, of: self)
        titleLbl.hook(.top, to: .top, of: self)
        titleLbl.hook(.bottom, to: .bottom, of: self)
    }
}
