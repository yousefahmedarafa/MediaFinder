//
//  ProfileTableViewCell.swift
//  MediaFinder
//
//  Created by Yousef Arafa on 4/14/20.
//  Copyright © 2020 Yousef Arafa. All rights reserved.
//

import UIKit
import SQLite

class ProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var itemImg: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemDetails: UILabel!
    @IBOutlet weak var passwordBtn: UIButton!
    
    var hiddenPassword = true
    var password = ""
    var profileData : Profile?
    let db = UserDB()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        shadowView.dropShadow()
        passwordBtn.isHidden = true
        passwordBtn.imageView?.contentMode = .scaleAspectFit
        UserDB.setupDB()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(_ data : Profile){
        
        profileData = data
        if data.name == "Password" && hiddenPassword == true {
            passwordBtn.isHidden = false
            password = data.detail
            itemDetails.text = String(data.detail.map { _ in return "*" })
        }else{
            itemDetails.text = "\(data.detail)"
        }
        itemImg.image = UIImage(named: data.itemImg)
        itemName.text = data.name
    }
    
    @IBAction func editBtnPressed(_ sender: UIButton) {
        print("Edit HERE!!!")
        guard let name = profileData?.name else {return}
        
        if name == "Address" {
            let mapVC = UIStoryboard(name: Storyboard.appleMaps, bundle: nil).instantiateViewController(identifier: StoryboardID.appleMap) as! AppleMapViewController
            mapVC.delegate = self
            mapVC.modalPresentationStyle = .fullScreen
            self.window?.rootViewController?.present(mapVC, animated: true, completion: nil)
        }else {
            alertControllerSetupFor(title: name)
        }
    }
    private func alertControllerSetupFor(title: String){
        
        guard let name = profileData?.name else {return}
        guard let detail = profileData?.detail else {return}
        
        let fieldMsg = "your current \(title) is \(detail)"
        let alert = UIAlertController(title: "Update \(title)", message: fieldMsg, preferredStyle: .alert)
        alert.addTextField { (textfield) in textfield.placeholder = "New \(title)" }
        let updateAction = UIAlertAction(title: "Update", style: .default) { (_) in
            
            var field : Expression<String>
            
            switch name
            {
            case "Name":
                field = UserDB.name
                
            case "Mail":
                field = UserDB.mail
                
            case "Address":
                field = UserDB.address
                
            case "Phone":
                field = UserDB.phone
                
            case "Password":
                field = UserDB.password
                
            default:
                field = UserDB.name
            }
            
            guard let newValue = alert.textFields?.first?.text else { return }
            
            UserDB.updateField(fieldName: field, newFieldValue: newValue)
            print("\(self.itemName.text ?? "") updated")
            if newValue.isEmpty == false {
                self.itemDetails.text = newValue
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler:{ _ in})
        alert.addAction(cancelAction)
        alert.addAction(updateAction)
        
        self.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func passwordBtnPressed(_ sender: UIButton) {
        
        passwordBtn.imageView?.contentMode = .scaleAspectFit
        hiddenPassword = !hiddenPassword
        if hiddenPassword {
            itemDetails.text = String(password.map { _ in return "*" })
            passwordBtn.setImage(UIImage(named: "pwEye"), for: .normal)
        }else{
            itemDetails.text = password
            passwordBtn.setImage(UIImage(named: "hidePassword"), for: .normal)
        }
    }
}
extension ProfileTableViewCell : SendingAddressDelegate {
    func getLocation(address: String) {
        itemDetails.text = address
        UserDB.updateField(fieldName: UserDB.address, newFieldValue: address)
    }
}
