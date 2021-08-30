//
//  SearchMovieViewController.swift
//  InshortsMoviesApplication
//
//  Created by RITIKA VERMA on 16/08/21.
//

import UIKit
import SDWebImage


class SearchMovieViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    

    @IBOutlet weak var movieSearchBar: UISearchBar!
    @IBOutlet weak var movieSearchTableView: UITableView!
    
    var searchMovieList = [MovieDetailsModel]() {
        didSet {
            DispatchQueue.main.async {
                self.movieSearchTableView.reloadData()

            }
        }
    }
    
    var searchPage = 1
    var noMoreDataInSearch = false
    var searchMovie = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // this is verma
        setup()
        // Do any additional setup after loading the view.
    }
    
    func setup(){
        movieSearchBar.delegate = self
        movieSearchTableView.delegate = self
        movieSearchTableView.dataSource = self
        movieSearchTableView.register(UINib(nibName: Constants.SavedTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.SavedTableViewCell)
        searchPage = 1
    }
    
    func getSearchMovies(page: Int, stringSearchTxt: String){
        
        if page == 1 {
            print("Getting Search Movies")
        }
        self.searchMovie = stringSearchTxt
        let finalStr = stringSearchTxt.removeWhitespace()
        
        let url = URL(string: Constants.searchMovieUrl + "\(finalStr)&page=\(page)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            if error == nil{
                if let data = data{
                    do{
                        let userResponse = try JSONDecoder().decode(MovieResponseModel.self, from: data)
                            if userResponse.results?.count == 0 {
                                if page == 1 {
                                    self.searchMovieList = userResponse.results!
                                }
                                self.noMoreDataInSearch = true
                                self.movieSearchTableView.reloadData()
                            }
                            else {
                                if page == 1 {
                                    self.searchMovieList = userResponse.results!
                                }
                                else {
                                    self.searchMovieList.append(contentsOf: userResponse.results!)
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

    //MARK:- UISearchbar delegate
        
       func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 1 {
            self.movieSearchTableView.isHidden = false
            searchPage = 1
            getSearchMovies(page: searchPage, stringSearchTxt: searchText)
        }else{
            self.movieSearchTableView.isHidden = true
            print("please enter movie name")
            
        }
        self.movieSearchTableView.reloadData()
       }

    
    
    //MARK:- table view
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return searchMovieList.count == 0 ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return searchMovieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = movieSearchTableView.dequeueReusableCell(withIdentifier: Constants.SavedTableViewCell, for: indexPath) as! SavedTableViewCell
        cell.swipeDeleteIcon.isHidden  = true
        
        if(searchMovieList.count > 0){
            if ((searchMovieList[indexPath.item].poster_path) != nil) {
                let fileUrl = URL(string: Constants.moviePosterUrl + searchMovieList[indexPath.item].poster_path!)
                cell.savedMovieIcon.sd_setImage(with: fileUrl, placeholderImage: UIImage(named: "movieIcon"))
                cell.savedMovieName.text = searchMovieList[indexPath.item].title
            }
        }
        
        
        if indexPath.item == (searchMovieList.count - 1) {
            if !noMoreDataInSearch {
                searchPage = searchPage + 1
                getSearchMovies(page: searchPage, stringSearchTxt: searchMovie)
            }
        }

        
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }


}
