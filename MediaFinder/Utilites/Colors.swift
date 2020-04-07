//
//  Colors.swift
//  Registration App
//
//  Created by Yousef Arafa on 2/13/20.
//  Copyright © 2020 Yousef Arafa. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {
    
    static var mainHavavnColor: UIColor {
        return UIColor(red: 174/255, green: 159/255, blue: 122/255, alpha: 1)
    }
    static var mainBlueColor: UIColor {
        return UIColor(red: 24/255, green: 37/255, blue: 79/255, alpha: 1)
    }
    static var secondaryBlueColor: UIColor {
        return UIColor(red: 139/255, green: 172/255, blue: 234/255, alpha: 1)
    }
    static func RGBValue(red: CGFloat , green: CGFloat , blue : CGFloat , alpha : CGFloat ) -> UIColor {
         return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
}

