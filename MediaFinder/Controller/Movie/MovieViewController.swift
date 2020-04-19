//
//  MovieViewController.swift
//  MovieFinder
//
//  Created by Yousef Arafa on 3/28/20.
//  Copyright © 2020 Yousef Arafa. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {
    
    var mediaArr = [Media]()
    var segmentValue = "music"
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var loadingwheel: UIActivityIndicatorView!
    @IBOutlet weak var mediaTypeSegment: UISegmentedControl!
    @IBOutlet weak var loadingView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setNavigationBar()
        setupRightBarBtn()
        moviesTableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        loadingView.isHidden = true
        loadingView.layer.borderWidth = 1.7
        loadingView.layer.borderColor = UIColor.black.cgColor
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
    
    func fetchData(){
        guard let searchField = searchTextField.text else {return}
        APIManager.loadMyMovies(mediaType: segmentValue, criteria: searchField) { (error, movies) in
            if let error = error {
                print(error.localizedDescription)
            } else if let movies = movies {
                self.mediaArr = movies
                self.hideLoadingView()
                if self.mediaArr.count == 0 {
                    self.alertControllerSetupFor(msg: "No Result Found")
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
    
    private func alertControllerSetupFor(msg: String){
        let alert = UIAlertController(title: "Sorry", message: msg, preferredStyle: .alert)
        let doneAction = UIAlertAction(title: "Done", style: .default, handler:{ _ in})
        alert.addAction(doneAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func searchBtnPressed(_ sender: UIButton) {
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
//        guard let previewLink = mediaArr[indexPath.item].previewUrl else {return}
        
        let mediaIndex = mediaArr[indexPath.item]
        let player = UIStoryboard(name: Storyboard.main, bundle: nil).instantiateViewController(identifier: StoryboardID.detailed) as! MediaDetailedViewController
        player.media = mediaIndex
        present(player, animated: true, completion: nil)
//        navigationController?.pushViewController(player, animated: true)
        
        
//        let videoURL = URL(string: previewLink)
//        let player = AVPlayer(url: videoURL!)
//        let playerViewController = AVPlayerViewController()
//        playerViewController.player = player
//        self.present(playerViewController, animated: true) {
//            playerViewController.player!.play()
//        }
//        guard let image = URL(string: mediaArr[indexPath.item].artworkUrl100) else {return}
//        let imageView = UIImageView()
//        imageView.contentMode = UIView.ContentMode.scaleAspectFit
//        if mediaArr[indexPath.item].getType() != MediaType.music {
//            imageView.isHidden = true
//        }
//
//        let width = view.safeAreaLayoutGuide.layoutFrame.width
//        let height = view.safeAreaLayoutGuide.layoutFrame.height
//        imageView.frame = CGRect(x: 0, y: 0, width: width, height: height)
//        imageView.sd_setImage(with: image)
//        playerViewController.contentOverlayView?.addSubview(imageView)

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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
extension UITableView{
    
    func scrollToTop(){
        
        for index in 0...numberOfSections - 1 {
            if numberOfSections > 0 && numberOfRows(inSection: index) > 0 {
                scrollToRow(at: IndexPath(row: 0, section: index), at: .top, animated: true)
                break
            }
            if index == numberOfSections - 1 {
                setContentOffset(.zero, animated: true)
                break
            }
        }
    }
}



