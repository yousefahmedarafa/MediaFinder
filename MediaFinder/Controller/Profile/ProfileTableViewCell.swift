//
//  ProfileTableViewCell.swift
//  MediaFinder
//
//  Created by Yousef Arafa on 4/14/20.
//  Copyright © 2020 Yousef Arafa. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {


    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var itemImg: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemDetails: UILabel!
    @IBOutlet weak var passwordBtn: UIButton!
    
    var hiddenPassword = true
    var pass = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        shadowView.dropShadow()
        passwordBtn.isHidden = true
        passwordBtn.imageView?.contentMode = .scaleAspectFit
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(_ data : Profile){
        
        if data.name == "Password" && hiddenPassword == true {
            passwordBtn.isHidden = false
            pass = data.detail
            itemDetails.text = String(data.detail.map { _ in return "*" })
        }else{
            itemDetails.text = "\(data.detail)"
        }
        itemImg.image = UIImage(named: data.itemImg)
        itemName.text = data.name
    }

    @IBAction func editBtnPressed(_ sender: UIButton) {
        print("Edit HERE!!!")
    }
    
    @IBAction func passwordBtnPressed(_ sender: UIButton) {
        print("Show Password Btn pressed")
        
        passwordBtn.imageView?.contentMode = .scaleAspectFit
        hiddenPassword = !hiddenPassword
        if hiddenPassword {
            itemDetails.text = String(pass.map { _ in return "*" })
            passwordBtn.setImage(UIImage(named: "hidePassword"), for: .normal)
        }else{
            itemDetails.text = pass
            passwordBtn.setImage(UIImage(named: "pwEye"), for: .normal)
            
        }
    }
}
