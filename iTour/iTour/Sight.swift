//
//  Sight.swift
//  iTour
//
//  Created by Jingjing Mao on 2/16/24.
//

import Foundation
import SwiftData

@Model
class Sight {
    var name: String
    
    init(name: String = "") {
        self.name = name
    }
}
