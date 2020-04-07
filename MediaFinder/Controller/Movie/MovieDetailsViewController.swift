//
//  MovieDetailsViewController.swift
//  Registration App
//
//  Created by Yousef Arafa on 2/13/20.
//  Copyright © 2020 Yousef Arafa. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var movieDesc: UILabel!
    
    var receviedMovie: Movie!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.title = receviedMovie.title
        movieImg.image = UIImage(named: receviedMovie.image)
        movieDesc.text = receviedMovie.desc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
