//
//  AlertManager.swift
//  MediaFinder
//
//  Created by Yousef Arafa on 5/3/20.
//  Copyright © 2020 Yousef Arafa. All rights reserved.
//

import Foundation
import UIKit

struct AlertManager {
    
    static func alertFor(title: String ,msg: String ,VC : UIViewController){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let doneAction = UIAlertAction(title: "Done", style: .default, handler:{ _ in})
        alert.addAction(doneAction)
        VC.present(alert, animated: true, completion: nil)
    }
}
