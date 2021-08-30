//
//  MovieDetailsModel.swift
//  InshortsMoviesApplication
//
//  Created by RITIKA VERMA on 15/08/21.
//

import Foundation


struct MovieDetailsModel: Codable {

    let originalTitle: String?
    let poster_path: String?
    let video: Bool?
    let vote_average: Double?
    let overview: String?
    let release_date: String?
    let voteCount: Int?
    let title: String?
    let adult: Bool?
    let backdropPath: String?
    let id: Int?
    let genreIDS: [Int]?
    let popularity: Double?
    let firstAirDate, name, originalName: String?
    let originCountry: [String]?
}
