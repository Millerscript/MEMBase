//
//  DeeplinkCell.swift
//  MEMBaseExample
//
//  Created by Miller Mosquera on 2/03/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import UIKit


class DeeplinkCell: UITableViewCell {
    
    let titleLbl: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .darkGray
        label.font = UIFont(name: "Poppins-Light", size: 24.0)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
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
        
        NSLayoutConstraint.activate([
            titleLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLbl.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func set(data: DeeplinkModel) {
        titleLbl.text = data.title
    }
    
}
