//
//  SavedTableViewCell.swift
//  InshortsMoviesApplication
//
//  Created by RITIKA VERMA on 14/08/21.
//

import UIKit
import SDWebImage

class SavedTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var savedMovieIcon: UIImageView!
    @IBOutlet weak var savedMovieYear: UILabel!
    @IBOutlet weak var savedMovieName: UILabel!
    @IBOutlet weak var swipeDeleteIcon: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    var savedMovies:SavedMovies!{
        didSet{
            if ((savedMovies.posterPath) != nil) {
                let fileUrl = URL(string: savedMovies.posterPath!)
                savedMovieIcon.sd_setImage(with: fileUrl, placeholderImage: UIImage(named: "movieIcon"))
            }
            savedMovieName.text = savedMovies.title as! String
            savedMovieYear.text = savedMovies.release_date
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.containerView.clipsToBounds = true
        self.containerView.layer.cornerRadius = 5
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
