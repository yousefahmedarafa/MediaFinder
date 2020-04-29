//
//  UITableView.swift
//  MediaFinder
//
//  Created by Yousef Arafa on 4/29/20.
//  Copyright © 2020 Yousef Arafa. All rights reserved.
//

import Foundation
import UIKit

extension UITableView{
    
    func scrollToTop(){
        
        for index in 0...numberOfSections - 1 {
            if numberOfSections > 0 && numberOfRows(inSection: index) > 0 {
                scrollToRow(at: IndexPath(row: 0, section: index), at: .top, animated: true)
                break
            }
            if index == numberOfSections - 1 {
                setContentOffset(.zero, animated: true)
                break
            }
        }
    }
}
