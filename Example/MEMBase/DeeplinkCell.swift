//
//  DeeplinkCell.swift
//  MEMBaseExample
//
//  Created by Miller Mosquera on 2/03/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import MEMBase

class DeeplinkCell: UITableViewCell {
    
    let titleLbl: UILabel = {
        let label = UILabel.newSet()
        label.textColor = .darkGray
        label.font = UIFont(name: "Poppins-Light", size: 24.0)
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViews() {
        self.backgroundColor = .lightGray.withAlphaComponent(0.2)
        self.selectionStyle = .none
        contentView.addSubview(titleLbl)
        
        titleLbl.hook(.left, to: .left, of: contentView)
        titleLbl.hook(.right, to: .right, of: contentView)
        titleLbl.hook(.top, to: .top, of: contentView)
        titleLbl.hook(.bottom, to: .bottom, of: contentView)
    }
    
    func set(data: DeeplinkModel) {
        titleLbl.text = data.title
    }
    
}
