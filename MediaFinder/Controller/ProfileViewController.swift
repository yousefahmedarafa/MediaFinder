//
//  ProfileViewController.swift
//  Registration App
//
//  Created by Yousef Arafa on 2/12/20.
//  Copyright © 2020 Yousef Arafa. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var userTextView: UITextView!
    
    var receivedUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        fillUserTxtView()
        setupRightBarBtn()
    }
    
    private func setNavigationBar(){
        navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.title = "Profile"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.mainBlueColor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    private func fillUserTxtView(){
        receivedUser = UserDefaultsManager.shared().getSavedData()
        
        guard let name = receivedUser.name else {return}
        guard let email = receivedUser.email else {return}
        guard let phone = receivedUser.phone else {return}
        guard let address = receivedUser.address else {return}
        
        userTextView.text = "Name : \(name)\n\n\nE-Mail : \(email)\n\n\nAddress: \(address)\n\n\nPhone : \(phone)\n\n\nGender : \(receivedUser.gender.rawValue)"
    }

    private func setupRightBarBtn(){
        let menuButton = UIBarButtonItem(title: "LogOut", style: .done, target: self, action: #selector(ProfileViewController.logout))
        self.navigationItem.rightBarButtonItem  = menuButton
    }
    
    @objc func logout(){
        receivedUser.isLoggedIn = false
        UserDefaultsManager.shared().saveDataFor(user: receivedUser)
        
        let signinVC = UIStoryboard(name: Storyboard.registration, bundle: nil).instantiateViewController(identifier: StoryboardID.signIn) as! SigninViewController
        navigationController?.pushViewController(signinVC, animated: true)
    }
}
