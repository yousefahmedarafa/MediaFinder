//
//  MediaDetailedViewController.swift
//  MediaFinder
//
//  Created by Yousef Arafa on 4/10/20.
//  Copyright © 2020 Yousef Arafa. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import SDWebImage

class MediaDetailedViewController: AVPlayerViewController {
    
    var media: Media!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupImage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupImage(){
        guard let previewLink = media.previewUrl else {return}
        let videoURL = URL(string: previewLink)
        let player = AVPlayer(url: videoURL!)
        self.player = player
        self.player!.play()
        let imageView = UIImageView()
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        guard let image = URL(string: media.artworkUrl100) else {return}
        if media.getType() != MediaType.music {
            imageView.isHidden = true
        }
        let width = view.safeAreaLayoutGuide.layoutFrame.width
        let height = view.safeAreaLayoutGuide.layoutFrame.height
        imageView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        imageView.sd_setImage(with: image)
        self.contentOverlayView?.addSubview(imageView)
        imageView.shakeAnimation()
    }
}
