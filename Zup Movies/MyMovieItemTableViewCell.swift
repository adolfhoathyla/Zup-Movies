//
//  MyMovieItemTableViewCell.swift
//  Zup Movies
//
//  Created by Adolfho Athyla on 15/01/17.
//  Copyright © 2017 a7hyla. All rights reserved.
//

import UIKit

class MyMovieItemTableViewCell: UITableViewCell {

    @IBOutlet var moviePoster: UIImageView!
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var movieRating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        movieTitle.adjustsFontSizeToFitWidth = true
        movieRating.adjustsFontSizeToFitWidth = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
