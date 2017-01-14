//
//  ItemMovieTableViewCell.swift
//  Zup Movies
//
//  Created by Adolfho Athyla on 14/01/17.
//  Copyright © 2017 a7hyla. All rights reserved.
//

import UIKit

class ItemMovieTableViewCell: UITableViewCell {

    @IBOutlet var movieBanner: UIImageView!
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var movieYear: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        movieTitle.adjustsFontSizeToFitWidth = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
