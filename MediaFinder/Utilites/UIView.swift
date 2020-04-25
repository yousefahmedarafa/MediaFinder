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
