//
//  MovieResponseModel.swift
//  InshortsMoviesApplication
//
//  Created by RITIKA VERMA on 14/08/21.
//

import Foundation

struct MovieResponseModel:Codable {
    let page: Int?
    let results: [MovieDetailsModel]?
    let totalPages, totalResults: Int?
}
