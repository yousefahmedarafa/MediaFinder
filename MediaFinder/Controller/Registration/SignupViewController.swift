//
//  ViewController.swift
//  Registration App
//
//  Created by Yousef Arafa on 2/12/20.
//  Copyright © 2020 Yousef Arafa. All rights reserved.
//

import UIKit

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
    
    let mapVC = UIStoryboard(name: Storyboard.appleMaps, bundle: nil).instantiateViewController(identifier: StoryboardID.appleMap) as! AppleMapViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        mapVC.delegate = self
        addressLabel.roundedCorner(radius: 5)
        signupBtn.roundedCorner(radius: 12)
        setProfileImage()
        textfieldDelegate()
        setNavigationBar()
    }

    private func setProfileImage(){
       let circle = profileImg.frame.height/2
        profileImg.roundedCorner(radius: circle)
    }
    
    private func setNavigationBar(){
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.mainHavavnColor]
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        self.navigationItem.title = "Sign Up"
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    private func isValidatePassword (_ pass: String) -> Bool {
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
                           address: mapVC.location,
                           phone: phonetxtField.text!,
                           gender: genderSwitch.isOn ? .Male : .Female,
                           isLoggedIn: false)
        print(newUser.email!)
        UserDefaultsManager.shared().saveDataFor(user: newUser)
        let db = DBManager()
        db.insertUser(user: newUser)
//        let db = DatabaseManager()
//        db.insertUser(user: newUser)
        
        let signinVC = UIStoryboard(name: Storyboard.registration, bundle: nil).instantiateViewController(identifier: StoryboardID.signIn) as! SigninViewController
        navigationController?.pushViewController(signinVC, animated: true)
    }
    
    @IBAction func genderSwitchValueChanged(_ sender: UISwitch) {
        genderLbl.text = sender.isOn ? Gender.Male.rawValue : Gender.Female.rawValue
        
    }
    
    @IBAction func addressBtnPressded(_ sender: UIButton) {
        let mapVC = UIStoryboard(name: Storyboard.appleMaps, bundle: nil).instantiateViewController(identifier: StoryboardID.appleMap) as! AppleMapViewController
        mapVC.modalPresentationStyle = .fullScreen
        present(mapVC, animated: true, completion: nil)
//        navigationController?.pushViewController(mapVC, animated: true)
    }
    
    private func alertControllerSetupFor(msg: String){
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        let doneAction = UIAlertAction(title: "Done", style: .default, handler:{ _ in})
        alert.addAction(doneAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func signinBtnPressed(_ sender: UIButton) {
        if isValidData() {
            if isValidEmail(mailTxtField.text!){
                if isValidatePassword(passwordTxtField.text!) {
                    goToSignInScreen()
                }else {
                    alertControllerSetupFor(msg: "Wrong Password Formating")
                }
            } else{
                alertControllerSetupFor(msg: "Wrong Mail Formating")
            }
        }else {
            alertControllerSetupFor(msg: "Please Fill The Data Fields")
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
