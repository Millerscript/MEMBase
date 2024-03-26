//
//  HeaderViewCell.swift
//  MEMBaseExample
//
//  Created by Miller Mosquera on 4/03/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class HeaderViewCell: UIView {
    
    let titleLbl: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "MCBase App"
        label.textColor = .black
        label.font = UIFont(name: "Poppins-Light", size: 28.0)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
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
        
        NSLayoutConstraint.activate([
            titleLbl.topAnchor.constraint(equalTo: self.topAnchor),
            titleLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLbl.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
