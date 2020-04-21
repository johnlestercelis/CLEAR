//
//  Movies.swift
//  CLEARExam
//
//  Created by John Lester Celis on 4/21/20.
//  Copyright © 2020 John Lester Celis. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Movies {
    var artworkUrl100: String
    var trackName: String
    var primaryGenreName: String
    var trackPrice: Double
    var longDescription: String
    
    init(_ response: JSON) {
        self.artworkUrl100 = response["artworkUrl100"].string ?? ""
        self.trackName = response["trackName"].string ?? ""
        self.primaryGenreName = response["primaryGenreName"].string ?? ""
        self.trackPrice = response["trackPrice"].double ?? 0.0
        self.longDescription = response["longDescription"].string ?? ""
    }
}

