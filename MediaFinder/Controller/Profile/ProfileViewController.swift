//
//  ProfileViewController.swift
//  MediaFinder
//
//  Created by Yousef Arafa on 4/14/20.
//  Copyright © 2020 Yousef Arafa. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController{
    
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var profileTableView: UITableView!
    
    @IBOutlet weak var profileView: UIView!
    
    @IBOutlet weak var deleteUserBtn: UIButton!
    
    var profileData = [Profile]()
    var receivedUser: User!
    var imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileView.roundedCorner(radius: 17)
        setupProfileTableView()
        setdata()
        setNavigationBar()
        setupRightBarBtn()
        setProfileImage()
        UserDB.setupDB()
        imagePicker.delegate = self
    }
    
    @IBAction func deleteProfileBtnPressed(_ sender: UIButton) {
        
        UserDB.deleteUserTable()
        let signinVC = UIStoryboard(name: Storyboard.registration, bundle: nil).instantiateViewController(identifier: StoryboardID.signIn) as! SigninViewController
        navigationController?.pushViewController(signinVC, animated: true)
    }
    
    @IBAction func updateProfileBtnPressed(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    
}
extension ProfileViewController {

    private func setdata(){
        
        receivedUser = UserDB.selectAllUsers()
        guard let name = receivedUser.name else {return}
        guard let email = receivedUser.email else {return}
        guard let phone = receivedUser.phone else {return}
        guard let address = receivedUser.address else {return}
        guard let password = receivedUser.password else {return}
        let gender = receivedUser.gender.rawValue

        if gender == Gender.Male.rawValue {
            deleteUserBtn.setImage(UIImage(named: Images.deleteMaleUser), for: .normal)
        }else{
            deleteUserBtn.setImage(UIImage(named: Images.deleteFemaleUser), for: .normal)
        }
        
        profileData += [
            Profile(name: "Name", detail: name, itemImg: Images.name),
            Profile(name: "Mail", detail: email, itemImg: Images.mail),
            Profile(name: "Address", detail: address, itemImg: Images.address),
            Profile(name: "Phone", detail: phone, itemImg: Images.phone),
            Profile(name: "Password", detail: password, itemImg: Images.pw),
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
//        navigationController?.navigationBar.barTintColor = UIColor.mainBlueColor
        navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.title = "Profile"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.mainHavavnColor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    private func setupRightBarBtn(){
        let menuButton = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(ProfileViewController.logout))
        self.navigationItem.rightBarButtonItem  = menuButton
    }
    
    @objc func logout(){

        UserDB.user(isLoggedIn: false)
        let signinVC = UIStoryboard(name: Storyboard.registration, bundle: nil).instantiateViewController(identifier: StoryboardID.signIn) as! SigninViewController
        navigationController?.pushViewController(signinVC, animated: true)
    }
}

extension ProfileViewController : UITableViewDelegate , UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell") as! ProfileTableViewCell
        cell.passwordBtn.isHidden = true
        cell.setupCell(self.profileData[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 95
       }
}
extension ProfileViewController: UIImagePickerControllerDelegate , UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            profileImage.image = image
            backgroundImage.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}
