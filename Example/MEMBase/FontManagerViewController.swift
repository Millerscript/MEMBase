//
//  FontManagerViewController.swift
//  MCBaseExample
//
//  Created by Miller Mosquera on 2/03/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import MEMBase

class FontManagerViewController: MEMBaseViewController {
    
    let lblRegular: UILabel = {
        
        let style = MEMBaseFontStylesManager()
        
        let lbl = UILabel(frame: .zero)
        lbl.font = style.regular(size: MEMBaseFontSizes.titleXL)
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "This is regular"
        lbl.textColor = .white
        return lbl
    }()
    
    let lblMedium: UILabel = {
        
        let style = MEMBaseFontStylesManager()
        
        let lbl = UILabel(frame: .zero)
        lbl.font = style.medium(size: MEMBaseFontSizes.titleXL)
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "This is medium"
        lbl.textColor = .white
        return lbl
    }()
    
    let lblItalic: UILabel = {
        
        let style = MEMBaseFontStylesManager()
        
        let lbl = UILabel(frame: .zero)
        lbl.font = style.italic(size: MEMBaseFontSizes.titleXL)
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "This is italic"
        lbl.textColor = .white
        return lbl
    }()
    
    let lblSemibold: UILabel = {
        
        let style = MEMBaseFontStylesManager()
        
        let lbl = UILabel(frame: .zero)
        lbl.font = style.semibold(size: MEMBaseFontSizes.titleXL)
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "This is semibold"
        lbl.textColor = .white
        return lbl
    }()
    
    let lblBold: UILabel = {
        
        let style = MEMBaseFontStylesManager()
        
        let lbl = UILabel(frame: .zero)
        lbl.font = style.bold(size: MEMBaseFontSizes.titleXL)
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "This is bold"
        lbl.textColor = .white
        return lbl
    }()
    
    let lblThin: UILabel = {
        
        let style = MEMBaseFontStylesManager()
        
        let lbl = UILabel(frame: .zero)
        lbl.font = style.thin(size: MEMBaseFontSizes.titleXL)
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "This is thin"
        lbl.textColor = .white
        return lbl
    }()
    
    lazy var fontList: UIStackView = {
        let fontList = UIStackView(frame: .zero)
        fontList.axis = .vertical
        fontList.alignment = .center
        fontList.distribution = .fillProportionally
        fontList.spacing = 2
        fontList.addArrangedSubview(lblRegular)
        fontList.addArrangedSubview(lblMedium)
        fontList.addArrangedSubview(lblItalic)
        fontList.addArrangedSubview(lblThin)
        fontList.addArrangedSubview(lblSemibold)
        fontList.addArrangedSubview(lblBold)
        fontList.translatesAutoresizingMaskIntoConstraints = false
        return fontList
    }()
    
    required init(data: [String : Any]) {
        print("view controller data from font manager \(data)")
        
        super.init(data: data)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        
        setFontList()
        
        showNavigationBar()
    }
    
    private func setFontList() {
        self.view.addSubview(fontList)
        
        NSLayoutConstraint.activate([
            fontList.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            fontList.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            fontList.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            fontList.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
}
