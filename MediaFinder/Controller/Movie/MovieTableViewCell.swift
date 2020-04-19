//
//  MovieTableViewCell.swift
//  MovieFinder
//
//  Created by Yousef Arafa on 3/28/20.
//  Copyright © 2020 Yousef Arafa. All rights reserved.
//

import UIKit
import SDWebImage

class MovieTableViewCell: UITableViewCell {


    @IBOutlet weak var mediaImage: UIImageView!
    @IBOutlet weak var mediaTitleLbl: UILabel!
    @IBOutlet weak var mediaLongDescLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(media: Media) {
        let mediaType = media.getType()
        if mediaType == MediaType.tvShow {
            mediaTitleLbl.text = media.artistName ?? ""
        }else{
            mediaTitleLbl.text = media.trackName ?? ""
        }
        if mediaType == MediaType.music {
            mediaLongDescLbl.text = media.artistName ?? ""
        }else{
            mediaLongDescLbl.text = media.longDescription ?? ""
        }
        if let image = URL(string: media.artworkUrl100){
            mediaImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
            mediaImage.sd_setImage(with: image, placeholderImage: UIImage(named: "placeholderImg.jpg"))
        }
    }
}
