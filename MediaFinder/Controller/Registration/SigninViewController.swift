//
//  SigninViewController.swift
//  Registration App
//
//  Created by Yousef Arafa on 2/12/20.
//  Copyright © 2020 Yousef Arafa. All rights reserved.
//

import UIKit

class SigninViewController: UIViewController {
    
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var logInBtn: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logInBtn.roundedCorner(radius: 12)
        textfieldDelegate()
        DB.setupDB()
    }
    
    private func setNavigationBar(){
        navigationController?.navigationBar.prefersLargeTitles = true
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.mainBlueColor]
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        self.navigationItem.title = "Sign In"
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    private func alertControllerSetup(){
        let alert = UIAlertController(title: "Error", message: "Invalid Credentials!", preferredStyle: .alert)
        let doneAction = UIAlertAction(title: "Done", style: .default, handler:{ _ in
            self.emailTxtField.becomeFirstResponder()})
        alert.addAction(doneAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func logInBtnPressed(_ sender: UIButton) {
//        var savedUser = UserDefaultsManager.shared().getSavedData()
//        savedUser.isLoggedIn = true
//        UserDefaultsManager.shared().saveDataFor(user:savedUser)
        
        let database = DB()
        let user = database.selectAllUsers()
        database.user(isLoggedIn: true)

            if (emailTxtField.text == user.email) && (passwordTxtField.text == user.password){
                let profileVC = UIStoryboard(name: Storyboard.profile, bundle: nil).instantiateViewController(withIdentifier: StoryboardID.profile) as! ProfileViewController
                profileVC.receivedUser = user
                let moviesVC = UIStoryboard(name: Storyboard.main, bundle: nil).instantiateViewController(withIdentifier: StoryboardID.movies) as! MovieViewController
                navigationController?.pushViewController(moviesVC, animated: true)
            }else {
                alertControllerSetup()
                emailTxtField.text = ""
                passwordTxtField.text = ""
            }
        
        
//        if (emailTxtField.text == savedUser.email) && (passwordTxtField.text == savedUser.password){
//            let profileVC = UIStoryboard(name: Storyboard.profile, bundle: nil).instantiateViewController(withIdentifier: StoryboardID.profile) as! ProfileViewController
//            profileVC.receivedUser = savedUser
//            let moviesVC = UIStoryboard(name: Storyboard.main, bundle: nil).instantiateViewController(withIdentifier: StoryboardID.movies) as! MovieViewController
//            navigationController?.pushViewController(moviesVC, animated: true)
//        }
//        else {
//            alertControllerSetup()
//            emailTxtField.text = ""
//            passwordTxtField.text = ""
//        }
    }
    
    @IBAction func dontHaveAccountBtnPressed(_ sender: UIButton) {
        let signupVC = UIStoryboard(name: Storyboard.registration, bundle: nil).instantiateViewController(identifier: StoryboardID.signup) as! SignupViewController
        signupVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(signupVC, animated: true)
    }
}
extension SigninViewController : UITextFieldDelegate {
    
    private func textfieldDelegate(){
        emailTxtField.delegate = self
        passwordTxtField.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}
