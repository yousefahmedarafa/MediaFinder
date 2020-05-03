//
//  MovieViewController.swift
//  MovieFinder
//
//  Created by Yousef Arafa on 3/28/20.
//  Copyright © 2020 Yousef Arafa. All rights reserved.
//

import UIKit
import Lottie

class MovieViewController: UIViewController {
    
    var mediaArr = [Media]()
    var segmentValue = "music"
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var loadingwheel: UIActivityIndicatorView!
    @IBOutlet weak var mediaTypeSegment: UISegmentedControl!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var lottieContainerView: UIView!
    @IBOutlet weak var lottieView: AnimationView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let retrievedData = MediaDB.selectAllMedia()
        if retrievedData.count == 0 {
            lottieContainerView.isHidden = false
            lottieView.play()
            lottieView.loopMode = .loop
            lottieView.animationSpeed = 1.0
        }
        mediaArr = retrievedData
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setNavigationBar()
        setupRightBarBtn()
        moviesTableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        setupLoadingView()
        MediaDB.setupMediaDB()
        MediaDB.createMedia()
        lottieContainerView.isHidden = true
       
    }
    
    private func setupLoadingView(){
        loadingView.isHidden = true
        loadingView.layer.borderWidth = 1.5
        loadingView.layer.borderColor = UIColor.black.cgColor
    }
    
    @IBAction func clearHistorybtnPressed(_ sender: UIButton) {
        MediaDB.deleteMediaTable()
        mediaArr.removeAll()
        moviesTableView.reloadData()
    }
    
    
    @IBAction func mediaTypeSegmentVlaueCanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex
        {
        case 0:
            segmentValue = "music"
            print("songs")
        case 1:
            segmentValue = "movie"
            print("movies")
        case 2:
            segmentValue = "tvShow"
            print("series")
        default:
            segmentValue = "music"
        }
    }
    
    private func fetchData(){
        guard let searchField = searchTextField.text else {return}
        APIManager.loadMyMovies(mediaType: segmentValue, criteria: searchField) { (error, media) in
            if let error = error {
                print(error.localizedDescription)
            } else if let media = media {
                self.mediaArr = media
                MediaDB.insertMedia(mediaArr: media)
                self.hideLoadingView()
                if self.mediaArr.count == 0 {
                    AlertManager.alertFor(title: "Sorry", msg: "No Result Found", VC: self)
                }
                self.moviesTableView.reloadData()
            }
        }
    }
    
    private func startloadingView(){
        self.loadingView.isHidden = false
        loadingView.roundedCorner(radius: 15)
        loadingwheel.isHidden = false
        loadingwheel.startAnimating()
    }
    
    private func hideLoadingView(){
        self.loadingView.isHidden = true
        self.loadingwheel.stopAnimating()
        self.loadingwheel.isHidden = true
    }
    
    @IBAction func searchBtnPressed(_ sender: UIButton) {
        lottieContainerView.isHidden = true
        startloadingView()
        fetchData()
        moviesTableView.scrollToTop()
    }
}

extension MovieViewController : UITableViewDelegate , UITableViewDataSource {
    
    private func setupTableView(){
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        cell.configureCell(media: mediaArr[indexPath.item])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let mediaIndex = mediaArr[indexPath.item]
        let mediaPlayer = MediaDetailedViewController()
        mediaPlayer.media = mediaIndex
        present(mediaPlayer, animated: true, completion: nil)
        
    }
}

extension MovieViewController {
    
    //    private func openSafariVC(withURL link: String){
    //        guard let url = URL(string: link) else { return }
    //        let safariVC = SFSafariViewController(url: url)
    //        present(safariVC, animated: true, completion: nil)
    //    }
    
    private func setNavigationBar(){
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = "Media Finder"
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.mainBlueColor
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.mainBlueColor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    private func setupRightBarBtn(){
        let menuButton = UIBarButtonItem(title: "Profile", style: .done, target: self, action: #selector(MovieViewController.goToProfile))
        menuButton.tintColor = UIColor.mainBlueColor
        self.navigationItem.rightBarButtonItem = menuButton
    }
    
    @objc func goToProfile(){
        let profileVC = UIStoryboard(name: Storyboard.profile, bundle: nil).instantiateViewController(identifier: StoryboardID.profile) as! ProfileViewController
        navigationController?.pushViewController(profileVC, animated: true)
    }
}



