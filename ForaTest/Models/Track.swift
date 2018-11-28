//
//  Track.swift
//  ForaTest
//
//  Created by Konstantin Fomin on 28/11/2018.
//  Copyright © 2018 Konstantin Fomin. All rights reserved.
//

import UIKit
import SwiftyJSON

class Track: NSObject {
    
    var number : String?
    var name : String?
    
    init(track: JSON) {
        self.number = track["trackNumber"].stringValue
        self.name = track["trackName"].stringValue
    }

}
