//
//  Ingredients.swift
//  Bagel5
//
//  Created by Alexander Washington on 2/2/24.
//

import Foundation
import SwiftData

@Model
class Ingredients {
    var name: String
    
    init(name: String = "") {
        self.name = name
    }
}
