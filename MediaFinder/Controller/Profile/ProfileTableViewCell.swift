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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        shadowView.dropShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(_ data : String){
        dataLabel.text = "\(data)"
    }

    @IBAction func editBtnPressed(_ sender: UIButton) {
        print("Edit HERE!!!")
    }
}
