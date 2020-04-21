//
//  APIFetcher.swift
//  CLEARExam
//
//  Created by John Lester Celis on 4/21/20.
//  Copyright © 2020 John Lester Celis. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

enum NetworkError: Error {
    case failure
    case success
}

class APIFetcher {
    func fetchMovies(completionHandler: @escaping ([JSON]?, NetworkError) -> ()) {
       let url = "https://itunes.apple.com/search?term=star&country=au&media=movie"
        Alamofire.request(url).responseJSON() { response in
             if response.result.error == nil {
                if let swiftyJsonVar = response.value {
                    let swiftyJsonVar2 = JSON(swiftyJsonVar)["results"]
                    if let results = swiftyJsonVar2.array {
                        completionHandler(results, .success)
                    }
                }
            }
        }
        
    }
}
