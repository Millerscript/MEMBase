//
//  View+Extension.swift
//  MEMBase
//
//  Created by Miller Mosquera on 2/03/24.
//

import Foundation
import UIKit

extension UIView {
    
    public func prepareForHooks() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.frame = .zero
    }
    
    @discardableResult
    public static func newSet() -> Self {
        let view = Self()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame = .zero
        return view
    }

    @available(*, deprecated, renamed: "hook()", message: "use 'hook' instead")
    public func set(contraints collection: [NSLayoutConstraint]) {
        NSLayoutConstraint.activate(collection)
    }
    
    /**
     * Update the hook for the view
     * - parameters dimesion: Height or Width
     * - parameters value: value to update
     */
    public func updateHookFor(dimension: HDimension, value: CGFloat = 0.0) {
        self.constraints.forEach { constraint in
            if dimension == .height {
                if constraint.identifier == "height" {
                    constraint.constant = value
                }
                self.layoutIfNeeded()
            }
        }
    }
    
    public func hook(_ edge: HBound, to: HBound, of: UIView, valueInset: CGFloat? = 0.0) {
        setAnchor(edge, to: to, of: of, valueInset: valueInset)
    }
    
    public func hookSafeArea(_ edge: HBound, to: HBound, of: UIView, valueInset: CGFloat? = 0.0) {
        setAnchor(edge, to: to, of: of, valueInset: valueInset, isSafe: true)
    }
    
    public func hookParentView(toSafeArea: HBound, valueInset: CGFloat? = 0.0) {
        guard let superview = self.superview else {return}
        
        setAnchor(toSafeArea, to: toSafeArea, of: superview, valueInset: valueInset, isSafe: true)
    }
    
    public func hookingToParentView(valueInset: CGFloat? = 0.0) {
        guard let superview = self.superview else {return}
        
        if let valueInset = valueInset, valueInset != 0 {
            self.topAnchor.constraint(equalTo: superview.topAnchor, constant: valueInset).isActive = true
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: valueInset).isActive = true
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: valueInset).isActive = true
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: valueInset).isActive = true
        } else {
            self.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        }
    }
    
    public func hookingToSafeParentView(valueInset: CGFloat? = 0.0) {
        guard let superview = self.superview else {return}
        
        if let valueInset = valueInset, valueInset != 0 {
            self.topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: valueInset).isActive = true
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: valueInset).isActive = true
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: valueInset).isActive = true
            self.bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: valueInset).isActive = true
        } else {
            self.topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor).isActive = true
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
            self.bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor).isActive = true
        }
    }
    
    /**
     * Set the Horizontal or Vertical centering in the parent view
     * - parameters axis:
     * - parameters sameOf:
     */
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
            let yAnchorParent = getYViewAnchor(from: self, bound: edge, isSafe: isSafe)
            let yAnchorChild = getYViewAnchor(from: of, bound: to, isSafe: isSafe)
            var defaultValue = 1.0 // If the value is zero, the bound is placed out of the safeArea, occurred the opposite if the value is set to one. ¬¬
            
            if let valueInset = valueInset, valueInset != 0 {
                defaultValue = valueInset
            }
            
            yAnchorParent.constraint(equalTo: yAnchorChild, constant: defaultValue).isActive = true
            
        } else if edge == .left || edge == .right {
            getXViewAnchor(from: self, bound: edge, isSafe: isSafe).constraint(equalTo: getXViewAnchor(from: of, bound: to, isSafe: isSafe), constant: valueInset ?? 0.0).isActive = true
        }
    }
    
    /**
     * Set the Heigh or Width dimetion for the view
     * - parameters dimension:
     * - parameters value:
     */
    public func setDimension(dimension: HDimension, value: CGFloat) {
        switch dimension {
        case .width:
            self.widthAnchor.constraint(equalToConstant: value).isActive = true
        case .height:
            let heightConstraint = self.heightAnchor.constraint(equalToConstant: value)
            heightConstraint.identifier = "height"
            NSLayoutConstraint.activate([heightConstraint])
            //self.heightAnchor.constraint(equalToConstant: value).isActive = true
        }
    }
    
    /**
     * Get the Top or Bottom anchor
     * - parameters from: The view to take the anchor
     * - parameters bound: The bound which is required (Top or Bottom)
     * - parameters isSafe: If you you want to hook up the view from safeArea
     */
    private func getYViewAnchor(from: UIView, bound: HBound, isSafe: Bool? = false) -> NSLayoutYAxisAnchor {
        if bound == .top {
            return (isSafe!) ? from.safeAreaLayoutGuide.topAnchor : from.topAnchor
        } else {
            return (isSafe!) ? from.safeAreaLayoutGuide.bottomAnchor : from.bottomAnchor
        }
    }
    
    /**
     * Get the Leading or Trailing anchor
     * - parameters from: The view to take the anchor
     * - parameters bound: The bound which is required (Leading or Trailing)
     * - parameters isSafe: If you you want to hook up the view from safeArea
     */
    private func getXViewAnchor(from: UIView, bound: HBound, isSafe: Bool? = false) -> NSLayoutXAxisAnchor {
        if bound == .left {
            return (isSafe!) ? from.safeAreaLayoutGuide.leadingAnchor : from.leadingAnchor
        } else {
            return (isSafe!) ? from.safeAreaLayoutGuide.trailingAnchor : from.trailingAnchor
        }
    }
    
}

extension UIView {
    public func hookToParentView(valueInset: CGFloat? = 0.0) {
        guard let superview = self.superview else {return}
        
        if let valueInset = valueInset, valueInset != 0 {
            self.topAnchor.constraint(equalTo: superview.topAnchor, constant: valueInset).isActive = true
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: valueInset).isActive = true
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: valueInset).isActive = true
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: valueInset).isActive = true
        } else {
            self.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        }
    }
    
    public func hookToSafeAreaParentView(valueInset: CGFloat? = 0.0) {
        guard let superview = self.superview else {return}
        
        if let valueInset = valueInset, valueInset != 0 {
            self.topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: valueInset).isActive = true
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: valueInset).isActive = true
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: valueInset).isActive = true
            self.bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: valueInset).isActive = true
        } else {
            self.topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor).isActive = true
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
            self.bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor).isActive = true
        }
    }
}

// MARK: - Set an action to an uiview from anywhere
// - Link: https://medium.com/@sdrzn/adding-gesture-recognizers-with-closures-instead-of-selectors-9fb3e09a8f0b
// - authors: Saoud M. Rizwan
extension UIView {
    
    // In order to create computed properties for extensions, we need a key to
    // store and access the stored property
    fileprivate struct AssociatedObjectKeys {
        //static var tapGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer"
        static var tapGestureRecognizer: UInt8 = 0
    }
    
    fileprivate typealias Action = (() -> Void)?
    
    // Set our computed property type to a closure
    fileprivate var tapGestureRecognizerAction: Action? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let tapGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer) as? Action
            return tapGestureRecognizerActionInstance
        }
    }
    
    // This is the meat of the sauce, here we create the tap gesture recognizer and
    // store the closure the user passed to us in the associated object we declared above
    public func addTapGestureRecognizer(action: (() -> Void)?) {
        self.isUserInteractionEnabled = true
        self.tapGestureRecognizerAction = action
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // Every time the user taps on the UIImageView, this function gets called,
    // which triggers the closure we stored
    @objc fileprivate func handleTapGesture(sender: UITapGestureRecognizer) {
        if let action = self.tapGestureRecognizerAction {
            action?()
        } else {
            print("no action")
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
