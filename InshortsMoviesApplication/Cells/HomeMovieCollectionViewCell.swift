//
//  HomeMovieCollectionViewCell.swift
//  InshortsMoviesApplication
//
//  Created by RITIKA VERMA on 14/08/21.
//

import UIKit

class HomeMovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var homeMovieImageView: UIImageView!
    @IBOutlet weak var homeMovieTitle: UILabel!
    @IBOutlet weak var homeMovieContainerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.homeMovieContainerView.clipsToBounds = true
        self.homeMovieContainerView.layer.cornerRadius = 10
    }

}
