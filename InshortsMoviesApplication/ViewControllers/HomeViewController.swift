//
//  HomeViewController.swift
//  InshortsMoviesApplication
//
//  Created by RITIKA VERMA on 15/08/21.
//

import UIKit
import SDWebImage


class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {

    @IBOutlet weak var trendingMovieCollectionView: UICollectionView!
    @IBOutlet weak var nowPlayingMovieCollectionView: UICollectionView!
    
    var nowPlayingMovieList = [MovieDetailsModel]() {
        didSet {
            DispatchQueue.main.async {
                self.nowPlayingMovieCollectionView.reloadData()
            }
        }
    }
    
    var trendingMovieList = [MovieDetailsModel]() {
        didSet {
            DispatchQueue.main.async {
                self.trendingMovieCollectionView.reloadData()
            }
        }
    }
    
    var nowPlayingPage = 1
    var noMoreDataInNowPlaying = false
    
    var trendingPage = 1
    var noMoreDataInTrending = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("testing")
        print("test2")
        setup()
    }
    
    
    func setup(){
        
        trendingMovieCollectionView.dataSource = self
        nowPlayingMovieCollectionView.dataSource = self
        trendingMovieCollectionView.delegate = self
        nowPlayingMovieCollectionView.delegate = self
                
        trendingMovieCollectionView.register(UINib(nibName: Constants.HomeMovieCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Constants.HomeMovieCollectionViewCell)
        nowPlayingMovieCollectionView.register(UINib(nibName: Constants.HomeMovieCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Constants.HomeMovieCollectionViewCell)
        
        nowPlayingPage = 1
        trendingPage = 1
        getNowPlayingMovies(page: nowPlayingPage)
        getTendingMovies(page: trendingPage)
        
    }
    
    func getNowPlayingMovies(page: Int){
        
        if page == 1 {
            print("Getting Now Playing Movies")
        }
        let url = URL(string: Constants.getNowPlayingMoviesUrl + "\(page)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            if error == nil{
                if let data = data{
                    do{
                        let userResponse = try JSONDecoder().decode(MovieResponseModel.self, from: data)
                            if userResponse.results?.count == 0 {
                                if page == 1 {
                                    self.nowPlayingMovieList = userResponse.results!
                                }
                                self.noMoreDataInNowPlaying = true
                                self.nowPlayingMovieCollectionView.reloadData()
                            }
                            else {
                                if page == 1 {
                                    self.nowPlayingMovieList = userResponse.results!
                                }
                                else {
                                    self.nowPlayingMovieList.append(contentsOf: userResponse.results!)
                                }
                            }
                    }catch let err{
                        print(err.localizedDescription)
                    }
                }
            }else{
                print(error?.localizedDescription)
            }
        })
        task.resume()
        
    }
    
    
    func getTendingMovies(page: Int){
        
        if page == 1 {
            
            print("Getting Trending Movies")
        }
        let url = URL(string: Constants.getTrendingMoviesUrl + "\(page)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            if error == nil{
                if let data = data{
                    do{
                        let userResponse = try JSONDecoder().decode(MovieResponseModel.self, from: data)
                            if userResponse.results?.count == 0 {
                                if page == 1 {
                                    self.trendingMovieList = userResponse.results!
                                }
                                self.noMoreDataInTrending = true
                                self.trendingMovieCollectionView.reloadData()
                            }
                            else {
                                if page == 1 {
                                    self.trendingMovieList = userResponse.results!
                                }
                                else {
                                    self.trendingMovieList.append(contentsOf: userResponse.results!)
                                }
                            }
                    }catch let err{
                        print(err.localizedDescription)
                    }
                }
            }else{
                print(error?.localizedDescription)
            }
        })
        task.resume()
        
    }
    
    
    
    
    //MARK:- collectionView setup
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        if(collectionView == self.trendingMovieCollectionView){
            return trendingMovieList.count == 0 ? 0 : 1
        }
        if(collectionView == self.nowPlayingMovieCollectionView){
            return nowPlayingMovieList.count == 0 ? 0 : 1
        }
        
        return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if(collectionView == self.trendingMovieCollectionView){
            if trendingMovieList != nil {
                return trendingMovieList.count
            }
            return 5
        }
        if(collectionView == self.nowPlayingMovieCollectionView){
            
            if nowPlayingMovieList != nil {
                return nowPlayingMovieList.count
            }
            return 5
        }
        
        return 5
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.HomeMovieCollectionViewCell, for: indexPath) as! HomeMovieCollectionViewCell

        if(collectionView == self.trendingMovieCollectionView){
            if ((trendingMovieList[indexPath.item].poster_path) != nil) {
                let fileUrl = URL(string: Constants.moviePosterUrl + trendingMovieList[indexPath.item].poster_path!)
                cell.homeMovieImageView.sd_setImage(with: fileUrl, placeholderImage: UIImage(named: "movieIcon"))
                cell.homeMovieTitle.text = trendingMovieList[indexPath.item].title
            }
            
            if indexPath.item == (trendingMovieList.count - 1) {
                if !noMoreDataInTrending {
                    trendingPage = trendingPage + 1
                    getTendingMovies(page: trendingPage)
                }
            }
        }
        
        
        if(collectionView == self.nowPlayingMovieCollectionView){
            if ((nowPlayingMovieList[indexPath.item].poster_path) != nil) {
                let fileUrl = URL(string: Constants.moviePosterUrl + nowPlayingMovieList[indexPath.item].poster_path!)
                cell.homeMovieImageView.sd_setImage(with: fileUrl, placeholderImage: UIImage(named: "movieIcon"))
                cell.homeMovieTitle.text = nowPlayingMovieList[indexPath.item].title

            }
            
            if indexPath.item == (nowPlayingMovieList.count - 1) {
                if !noMoreDataInNowPlaying {
                    nowPlayingPage = nowPlayingPage + 1
                    getNowPlayingMovies(page: nowPlayingPage)
                }
            }
        }
        
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width/2, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if(collectionView == self.trendingMovieCollectionView){
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
            vc.detailMovie = nowPlayingMovieList
            vc.detailMovieTitle = trendingMovieList[indexPath.item].title ?? ""
            vc.detailReleaseDateTF = trendingMovieList[indexPath.item].release_date ?? ""
            vc.detailRatingTF = "\(trendingMovieList[indexPath.item].vote_average!)"
            vc.detailPopularityTF = "\(trendingMovieList[indexPath.item].popularity!)"
            
            vc.detailMovieOverview = trendingMovieList[indexPath.item].overview!
            vc.detailMovieImg = Constants.moviePosterUrl + trendingMovieList[indexPath.item].poster_path!
            
            self.present(vc, animated: true, completion: nil)
    
        }
        if(collectionView == self.nowPlayingMovieCollectionView){
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
            vc.detailMovie = nowPlayingMovieList
            vc.detailMovieID = nowPlayingMovieList[indexPath.item].id ?? 0
            vc.detailMovieTitle = nowPlayingMovieList[indexPath.item].title! 
            vc.detailReleaseDateTF = nowPlayingMovieList[indexPath.item].release_date! 
            vc.detailRatingTF = "\(nowPlayingMovieList[indexPath.item].vote_average!)"
            vc.detailPopularityTF = "\(nowPlayingMovieList[indexPath.item].popularity!)"
            vc.detailMovieOverview = nowPlayingMovieList[indexPath.item].overview! 
            vc.detailMovieImg = Constants.moviePosterUrl + nowPlayingMovieList[indexPath.item].poster_path!
            self.present(vc, animated: true, completion: nil)
        }
        
    }

}
