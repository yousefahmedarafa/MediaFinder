//
//  ProfileViewController.swift
//  MediaFinder
//
//  Created by Yousef Arafa on 4/14/20.
//  Copyright © 2020 Yousef Arafa. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var profileTableView: UITableView!
    
    var profileData = [Profile]()
    var receivedUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProfileTableView()
        setdata()
        setNavigationBar()
        setupRightBarBtn()
    } 
}
extension ProfileViewController {
    
    func setdata(){
        
        receivedUser = UserDefaultsManager.shared().getSavedData()
        
        guard let name = receivedUser.name else {return}
        guard let email = receivedUser.email else {return}
        guard let phone = receivedUser.phone else {return}
        guard let address = receivedUser.address else {return}
        let password = String(receivedUser.password.map { _ in return "•" })
        let gender = receivedUser.gender.rawValue
        profileData += [
            Profile(item: "Name", detail: name),
            Profile(item: "Mail", detail: email),
            Profile(item: "Phone", detail: phone),
            Profile(item: "Address", detail: address),
            Profile(item: "Gender", detail: gender),
            Profile(item: "Password", detail: password)]
    }
    
    private func setupProfileTableView(){
        profileTableView.delegate = self
        profileTableView.dataSource = self
    }
    
    private func setNavigationBar(){
        navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.title = "Profile"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.mainBlueColor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    private func setupRightBarBtn(){
        let menuButton = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(ProfileViewController.logout))
        self.navigationItem.rightBarButtonItem  = menuButton
    }
    
    @objc func logout(){
        receivedUser.isLoggedIn = false
        UserDefaultsManager.shared().saveDataFor(user: receivedUser)
        
        let signinVC = UIStoryboard(name: Storyboard.registration, bundle: nil).instantiateViewController(identifier: StoryboardID.signIn) as! SigninViewController
        navigationController?.pushViewController(signinVC, animated: true)
    }
}

extension ProfileViewController : UITableViewDelegate , UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.profileData.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.profileData[section].item
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell") as! ProfileTableViewCell
        cell.passwordBtn.isHidden = true
        if self.profileData[indexPath.section].item == "Password" {
            cell.passwordBtn.isHidden = false
        }
        cell.setupCell(self.profileData[indexPath.section])
        return cell
    }
}
