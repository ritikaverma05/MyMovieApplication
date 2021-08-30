//
//  Extension+RemoveSpaceFromString.swift
//  InshortsMoviesApplication
//
//  Created by RITIKA VERMA on 16/08/21.
//

import Foundation

extension String {
    func replace(string:String, replacement:String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }

    func removeWhitespace() -> String {
        return self.replace(string: " ", replacement: "")
    }
  }
