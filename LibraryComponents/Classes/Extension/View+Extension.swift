//
//  View+Extension.swift
//  MEMBase
//
//  Created by Miller Mosquera on 2/03/24.
//

import Foundation
import UIKit

extension UIView {
    
    public func newSet() -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.frame = .zero
        return self
    }
    
    @available(*, deprecated, renamed: "hook()", message: "use 'hook' instead")
    public func set(contraints collection: [NSLayoutConstraint]) {
        NSLayoutConstraint.activate(collection)
    }
    
    public func hook(_ edge: HBound, to: HBound, of: UIView, valueInset: CGFloat? = 0.0) {
        setAnchor(edge, to: to, of: of, valueInset: valueInset)
    }
    
    public func hookSafeArea(_ edge: HBound, to: HBound, of: UIView, valueInset: CGFloat? = 0.0) {
        setAnchor(edge, to: to, of: of, valueInset: valueInset, isSafe: true)
    }
    
    public func hookParentView(toSafeArea: HBound, valueInset: CGFloat? = 0.0) {
        guard let superview = self.superview else {return}
        
        setAnchor(toSafeArea, to: toSafeArea, of: superview, isSafe: true)
    }
    
    public func hookingToParentView() {
        guard let superview = self.superview else {return}
        
        self.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
    }
    
    public func hookingToSafeParentView() {
        guard let superview = self.superview else {return}
        
        self.topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    public func hookAxis(_ axis: HAxis, sameOf: UIView) {
        switch axis {
        case .vertical:
            self.centerYAnchor.constraint(equalTo: sameOf.centerYAnchor).isActive = true
        case .horizontal:
            self.centerXAnchor.constraint(equalTo: sameOf.centerXAnchor).isActive = true
        }
    }
    
    private func setAnchor(_ edge: HBound, to: HBound, of: UIView, valueInset: CGFloat? = 0.0, isSafe: Bool? = false) {
        if edge == .top || edge == .bottom {
            getYViewAnchor(from: self, bound: edge, isSafe: isSafe).constraint(equalTo: getYViewAnchor(from: of, bound: to, isSafe: isSafe), constant: valueInset ?? 0.0).isActive = true
        } else if edge == .left || edge == .right {
            getXViewAnchor(from: self, bound: edge, isSafe: isSafe).constraint(equalTo: getXViewAnchor(from: of, bound: to, isSafe: isSafe), constant: valueInset ?? 0.0).isActive = true
        }
    }
    
    public func setDimension(dimension: HDimension, value: CGFloat) {
        switch dimension {
        case .width:
            self.widthAnchor.constraint(equalToConstant: value).isActive = true
        case .height:
            self.heightAnchor.constraint(equalToConstant: value).isActive = true
        }
    }
    
    private func getYViewAnchor(from: UIView, bound: HBound, isSafe: Bool? = false) -> NSLayoutYAxisAnchor {
        if bound == .top {
            return (isSafe!) ? from.safeAreaLayoutGuide.topAnchor : from.topAnchor
        } else {
            return (isSafe!) ? from.safeAreaLayoutGuide.bottomAnchor : from.bottomAnchor
        }
    }
    
    private func getXViewAnchor(from: UIView, bound: HBound, isSafe: Bool? = false) -> NSLayoutXAxisAnchor {
        if bound == .left {
            return (isSafe!) ? from.safeAreaLayoutGuide.leadingAnchor : from.leadingAnchor
        } else {
            return (isSafe!) ? from.safeAreaLayoutGuide.trailingAnchor : from.trailingAnchor
        }
    }
    
}

public enum HBound {
    case top
    case bottom
    case left
    case right
}

public enum HDimension {
    case width
    case height
}

public enum HAxis {
    case vertical
    case horizontal
}

public class CustomUIView: UIView {
    var index: Int = 0
}
