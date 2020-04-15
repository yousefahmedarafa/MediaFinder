//
//  Profile2ViewController.swift
//  MediaFinder
//
//  Created by Yousef Arafa on 4/14/20.
//  Copyright © 2020 Yousef Arafa. All rights reserved.
//

import UIKit

class Profile2ViewController: UIViewController {
    
    
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
    }
}

extension Profile2ViewController {
    
    func setdata(){
        
        receivedUser = UserDefaultsManager.shared().getSavedData()
        
        guard let name = receivedUser.name else {return}
        guard let email = receivedUser.email else {return}
        guard let phone = receivedUser.phone else {return}
        guard let address = receivedUser.address else {return}
        guard let pass = receivedUser.password else {return}
        let gender = receivedUser.gender.rawValue
        profileData += [
            Profile(item: "Name", detail: name),
            Profile(item: "Mail", detail: email),
            Profile(item: "Phone", detail: phone),
            Profile(item: "Address", detail: address),
            Profile(item: "Gender", detail: gender),
            Profile(item: "Password", detail: pass)]
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
}

extension Profile2ViewController : UITableViewDelegate , UITableViewDataSource {

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
        cell.setupCell(self.profileData[indexPath.section].detail)
        return cell
    }
}
