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
    
    @IBOutlet weak var profileView: UIView!
    
    var profileData = [Profile]()
    var receivedUser: User!
    let db = DB()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileView.roundedCorner(radius: 17)
        setupProfileTableView()
        setdata()
        setNavigationBar()
        setupRightBarBtn()
        setProfileImage()
        DB.setupDB()
    } 
}
extension ProfileViewController {
    
    func setdata(){
        
        receivedUser = db.selectAllUsers()
//        receivedUser = UserDefaultsManager.shared().getSavedData()
        
        guard let name = receivedUser.name else {return}
        guard let email = receivedUser.email else {return}
        guard let phone = receivedUser.phone else {return}
        guard let address = receivedUser.address else {return}
//        let password = String(receivedUser.password.map { _ in return "•" })
        guard let password = receivedUser.password else {return}
//        let gender = receivedUser.gender.rawValue

        profileData += [
            Profile(name: "Name", detail: name, itemImg: "name"),
            Profile(name: "Mail", detail: email, itemImg: "mail"),
            Profile(name: "Address", detail: address, itemImg: "address"),
            Profile(name: "Phone", detail: phone, itemImg: "phone"),
            Profile(name: "Password", detail: password, itemImg: "pw"),
            ]
    }
    private func setProfileImage(){
       let roundedImage = profileImage.frame.height/2
        profileImage.roundedCorner(radius: roundedImage)
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
        
//        receivedUser.isLoggedIn = false
//        UserDefaultsManager.shared().saveDataFor(user: receivedUser)
        db.user(isLoggedIn: false)
        let signinVC = UIStoryboard(name: Storyboard.registration, bundle: nil).instantiateViewController(identifier: StoryboardID.signIn) as! SigninViewController
        navigationController?.pushViewController(signinVC, animated: true)
    }
}

extension ProfileViewController : UITableViewDelegate , UITableViewDataSource {

//    func numberOfSections(in tableView: UITableView) -> Int {
//        return self.profileData.count
//    }
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return self.profileData[section].item
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell") as! ProfileTableViewCell
        cell.passwordBtn.isHidden = true
//        if self.profileData[indexPath.section].item == "Password" {
//            cell.passwordBtn.isHidden = false
//        }
        cell.setupCell(self.profileData[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 95
       }
}
