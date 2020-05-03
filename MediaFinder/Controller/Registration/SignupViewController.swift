//
//  ViewController.swift
//  Registration App
//
//  Created by Yousef Arafa on 2/12/20.
//  Copyright © 2020 Yousef Arafa. All rights reserved.
//

import UIKit
import SQLite

class SignupViewController: UIViewController {
    
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var mailTxtField: UITextField!
    @IBOutlet weak var phonetxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var genderSwitch: UISwitch!
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    
    var imagePicker = UIImagePickerController()
    var selectedLocation = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        addressLabel.roundedCorner(radius: 5)
        signupBtn.roundedCorner(radius: 12)
        setProfileImage()
        textfieldDelegate()
        setNavigationBar()
        UserDB.setupDB()
        UserDB.create()
    }
    
    private func setProfileImage(){
        let roundedImage = profileImg.frame.height/2
        profileImg.roundedCorner(radius: roundedImage)
    }
    
    private func setNavigationBar(){
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.mainHavavnColor]
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        self.navigationItem.title = "Sign Up"
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    private func isValidData() -> Bool {
        if let name = nameTxtField.text, !name.isEmpty,
            let email = mailTxtField.text, !email.isEmpty,
            let password = passwordTxtField.text, !password.isEmpty,
            let phoneNum = phonetxtField.text, !phoneNum.isEmpty {
            return true
        }
        return false
    }
    
    private func goToSignInScreen() {    
        let newUser = User(name: nameTxtField.text!,
                           email: mailTxtField.text!,
                           password: passwordTxtField.text!,
                           address: selectedLocation,
                           phone: phonetxtField.text!,
                           gender: genderSwitch.isOn ? .Male : .Female,
                           isLoggedIn: false)
        print(newUser.email!)
        
        UserDB.insertUser(user: newUser)
        
        let signinVC = UIStoryboard(name: Storyboard.registration, bundle: nil).instantiateViewController(identifier: StoryboardID.signIn) as! SigninViewController
        navigationController?.pushViewController(signinVC, animated: true)
    }
    
    @IBAction func genderSwitchValueChanged(_ sender: UISwitch) {
        genderLbl.text = sender.isOn ? Gender.Male.rawValue : Gender.Female.rawValue
    }
    
    @IBAction func addressBtnPressded(_ sender: UIButton) {
        let mapVC = UIStoryboard(name: Storyboard.appleMaps, bundle: nil).instantiateViewController(identifier: StoryboardID.appleMap) as! AppleMapViewController
        mapVC.delegate = self
        mapVC.modalPresentationStyle = .fullScreen
        present(mapVC, animated: true, completion: nil)
    }
    
    @IBAction func signinBtnPressed(_ sender: UIButton) {
        if isValidData() {
            if isValidEmail(mailTxtField.text!){
                if isValidatePassword(passwordTxtField.text!) {
                    goToSignInScreen()
                }else {
                    AlertManager.alertFor(title: "Error", msg: "Wrong Password Formating" , VC : self)
                }
            } else{
                AlertManager.alertFor(title: "Error", msg: "Wrong Mail Formating" , VC : self)
            }
        }else {
            AlertManager.alertFor(title: "Error", msg: "Please Fill The Data Fields" , VC : self)
        }
    }
    
    @IBAction func chooseProfilePicPressed(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
}
extension SignupViewController : UITextFieldDelegate {
    
    private func textfieldDelegate(){
        nameTxtField.delegate = self
        mailTxtField.delegate = self
        passwordTxtField.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}
extension SignupViewController: SendingAddressDelegate {
    func getLocation(address: String) {
        addressLabel.text = " \(address)"
        selectedLocation = " \(address)"
    }
}
extension SignupViewController: UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            profileImg.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}
