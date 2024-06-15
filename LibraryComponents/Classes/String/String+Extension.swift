//
//  String+Extension.swift
//  MEMBase
//
//  Created by Miller Mosquera on 4/03/24.
//

import Foundation
import UIKit

extension String {
    
    static var empty = ""
    
    // calculate label size to show
    public func size(for label: UILabel) -> CGSize {
        let alabel = UILabel(frame: .zero)
        alabel.text = self
        alabel.sizeToFit()
            
        return alabel.bounds.size
    }
}
