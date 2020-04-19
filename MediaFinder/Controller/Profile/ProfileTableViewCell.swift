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
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var passwordBtn: UIButton!
    
    var hiddenPassword = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        shadowView.dropShadow()
        passwordBtn.imageView?.contentMode = .scaleAspectFit
        passwordBtn.setImage(UIImage(named: "hidepass"), for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(_ data : Profile){
        
        if data.item == "Password" {
            if hiddenPassword == true {
                dataLabel.text = String(data.detail.map { _ in return "*" })
            }
        }else{
            dataLabel.text = "\(data.detail)"
        }
    }

    @IBAction func editBtnPressed(_ sender: UIButton) {
        print("Edit HERE!!!")
    }
    
    @IBAction func passwordBtnPressed(_ sender: UIButton) {
        passwordBtn.imageView?.contentMode = .scaleAspectFit
        hiddenPassword = !hiddenPassword
        if hiddenPassword {
            passwordBtn.setImage(UIImage(named: "hidepass"), for: .normal)
        }else{
            passwordBtn.setImage(UIImage(named: "showpass"), for: .normal)
        }
    }
}
