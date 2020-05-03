//
//  SignupViewController+Validation.swift
//  MediaFinder
//
//  Created by Yousef Arafa on 5/2/20.
//  Copyright © 2020 Yousef Arafa. All rights reserved.
//

import Foundation

extension SignupViewController {
    
     func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
     func isValidatePassword (_ pass: String) -> Bool {
        /*
         ^                         Start anchor
         (?=.*[A-Z])               Ensure string has one uppercase letters.
         (?=.*[!@#$&*])            Ensure string has one special case letter.
         (?=.*[0-9].*[0-9])        Ensure string has two digits.
         (?=.*[a-z].*[a-z].*[a-z]) Ensure string has three lowercase letters.
         .{8}                      Ensure string is of length 8.
         $
         */
        let passRegEx = "^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9].*[0-9])(?=.*[a-z].*[a-z].*[a-z]).{8}$"
        let passPred = NSPredicate(format:"SELF MATCHES %@", passRegEx)
        return passPred.evaluate(with: pass)
    }
}
