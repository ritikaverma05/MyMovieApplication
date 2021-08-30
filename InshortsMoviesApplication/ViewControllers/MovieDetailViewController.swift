//
//  MovieDetailViewController.swift
//  InshortsMoviesApplication
//
//  Created by RITIKA VERMA on 15/08/21.
//

import UIKit
import CoreData
import SDWebImage

class MovieDetailViewController: UIViewController{
    
    
    @IBOutlet weak var detailMovieImgView: UIImageView!
    @IBOutlet weak var dMovieTitle: UILabel!
    @IBOutlet weak var releaseDateTF: UITextField!
    @IBOutlet weak var ratingTF: UITextField!
    @IBOutlet weak var popularityTF: UITextField!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var savedMovieBtn: UIButton!
    @IBOutlet weak var shareMovieBtn: UIButton!
    
    var detailMovie = [MovieDetailsModel]()
    var detailMovieID = 0
    var detailMovieTitle = ""
    var detailReleaseDateTF = ""
    var detailRatingTF = ""
    var detailPopularityTF = ""
    var detailMovieOverview = ""
    var detailMovieImg = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        // Do any additional setup after loading the view.
    }
    
    func setup(){
        
        if(detailMovieTitle != ""){
            dMovieTitle.text = detailMovieTitle
        }
        releaseDateTF.text = detailReleaseDateTF
        ratingTF.text = detailRatingTF
        popularityTF.text = detailPopularityTF
        movieOverview.text = detailMovieOverview
        
        if ((detailMovieImg) != "") {
            let fileUrl = URL(string: detailMovieImg)
            detailMovieImgView.sd_setImage(with: fileUrl, placeholderImage: UIImage(named: "movieIcon"))
        }
        
        if(DatabaseHelper.sharedInstance.checkMovie(name: detailMovieTitle).0){
            savedMovieBtn.isSelected = true
        }else{
            savedMovieBtn.isSelected = false
        }
        
    }
    
    @IBAction func isSavedBtnTapped(_ sender: UIButton) {
        
        if(DatabaseHelper.sharedInstance.checkMovie(name: detailMovieTitle).0){
            
            print("unsaved movie \(detailMovieTitle)")
            sender.isSelected = false
            DatabaseHelper.sharedInstance.deleteMovie(index: DatabaseHelper.sharedInstance.checkMovie(name: detailMovieTitle).1)
        }else{
            let dict = ["posterPath":detailMovieImg, "release_date":detailReleaseDateTF, "title":detailMovieTitle]
            DatabaseHelper.sharedInstance.saved(object: dict as! [String:String])
            print("saved movie \(detailMovieTitle)")
            sender.isSelected = true
        }
        
    }
    
    @IBAction func shareMovieBtnTapped(_ sender: UIButton) {
        
        let string1 = ["InshortsMoviesApplication:PleaseWatch\(detailMovieTitle)whichreleasedon\(detailReleaseDateTF)"]
        let ac = UIActivityViewController(activityItems: string1, applicationActivities: nil)
        present(ac, animated: true)
    }
    
    
    @IBAction func dragDownVCBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
