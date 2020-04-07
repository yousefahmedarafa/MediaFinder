//
//  UIView.swift
//  Registration App
//
//  Created by Yousef Arafa on 2/12/20.
//  Copyright © 2020 Yousef Arafa. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func roundedCorner(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func dropShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 2.0
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 4.0, height: 7.0)
        self.layer.shadowOpacity = 0.25
        self.clipsToBounds = false
    }
}
extension UIView {
    func shake(_ duration: Double? = 0.4) {
        self.transform = CGAffineTransform(translationX: 20, y: 0)
        UIView.animate(withDuration: duration ?? 0.4, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}
