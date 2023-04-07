//
//  UIView+Constraints.swift
//  HolidayApp
//
//  Created by Anderson Oliveira on 07/04/23.
//

import UIKit

extension UIView {
    func setAnchorsEqual(to reference: UIView, isSafeArea: Bool = false, padding: UIEdgeInsets? = .init(top: 0,
                                                                                                        left: 0,
                                                                                                        bottom: 0,
                                                                                                        right: 0)) {
        
        self.anchors(topReference: isSafeArea ? reference.safeAreaLayoutGuide.topAnchor : reference.topAnchor,
                     leadingReference: isSafeArea ? reference.safeAreaLayoutGuide.leadingAnchor : reference.leadingAnchor,
                     trailingReference: isSafeArea ? reference.safeAreaLayoutGuide.trailingAnchor :reference.trailingAnchor,
                     bottomReference: isSafeArea ? reference.safeAreaLayoutGuide.bottomAnchor : reference.bottomAnchor,
                     topPadding: padding?.top,
                     leftPadding: padding?.left,
                     rightPadding: padding?.right,
                     bottomPadding: padding?.bottom)
    }
    
    
    func anchors(topReference: NSLayoutYAxisAnchor? = nil,
                 leadingReference: NSLayoutXAxisAnchor? = nil,
                 trailingReference: NSLayoutXAxisAnchor? = nil,
                 bottomReference: NSLayoutYAxisAnchor? = nil,
                 topPadding: CGFloat? = 0,
                 leftPadding: CGFloat? = 0,
                 rightPadding: CGFloat? = 0,
                 bottomPadding: CGFloat? = 0) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let topReference = topReference, let topPadding = topPadding { self.topAnchor.constraint(equalTo: topReference, constant: topPadding).isActive = true }
        if let leadingReference = leadingReference, let leftPadding = leftPadding { self.leadingAnchor.constraint(equalTo: leadingReference, constant: leftPadding).isActive = true }
        if let trailingReference = trailingReference, let rightPadding = rightPadding { self.trailingAnchor.constraint(equalTo: trailingReference, constant: -rightPadding).isActive = true }
        if let bottomReference = bottomReference, let bottomPadding = bottomPadding { self.bottomAnchor.constraint(equalTo: bottomReference, constant: -bottomPadding).isActive = true }
    }
    
    
    
    // MARK: Height and Width functions
    func size(height: CGFloat? = nil, width: CGFloat? = nil) {
        if let height = height { self.heightAnchor.constraint(equalToConstant: height).isActive = true }
        if let width = width { self.heightAnchor.constraint(equalToConstant: width).isActive = true }
    }
    
    func equalWidth(to reference: UIView) {
        self.widthAnchor.constraint(equalTo: reference.widthAnchor).isActive = true
    }
    
    func equalHeight(to reference: UIView) {
        self.heightAnchor.constraint(equalTo: reference.heightAnchor).isActive = true
    }
    
    func setHeightGreaterThan(to reference: UIView) {
        self.heightAnchor.constraint(greaterThanOrEqualTo: reference.heightAnchor).isActive = true
    }
    
    func setHeightToScreenSize() {
        self.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height).isActive = true
    }
    
    func setWidthToScreenSize() {
        self.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
    }
    
    // MARK: Center X and Y functions
    func centerXEqualTo(_ reference: UIView) {
        self.centerXAnchor.constraint(equalTo: reference.centerXAnchor).isActive = true
    }
    
    func centerYEqualTo(_ reference: UIView) {
        self.centerYAnchor.constraint(equalTo: reference.centerYAnchor).isActive = true
    }
    
    func centerXYEqualTo(_ reference: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: reference.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: reference.centerYAnchor).isActive = true
    }
}
