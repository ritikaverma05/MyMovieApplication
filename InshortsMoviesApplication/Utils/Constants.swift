//
//  Constants.swift
//  InshortsMoviesApplication
//
//  Created by RITIKA VERMA on 16/08/21.
//

import Foundation

struct Constants {
    

    static var baseUrl = "https://api.themoviedb.org/3"
    static var apiKey = "bec08b1dea904cad93e73a9a91f1eecb"
    static let getNowPlayingMoviesUrl = baseUrl + "/movie/now_playing?api_key=" + apiKey + "&language=en-US&page="
    static let getTrendingMoviesUrl = baseUrl + "/trending/all/week?api_key=" + apiKey + "&page="
    static let searchMovieUrl = baseUrl + "/search/movie?api_key=" + apiKey + "&query="
    static let moviePosterUrl = "https://image.tmdb.org/t/p/w500"
    
    static var SavedTableViewCell = "SavedTableViewCell"
    static var HomeMovieCollectionViewCell = "HomeMovieCollectionViewCell"

    
}
