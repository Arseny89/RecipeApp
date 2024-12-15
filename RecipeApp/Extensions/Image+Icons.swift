//
//  Image+Icons.swift
//  RecipeApp
//
//  Created by Арсений Корниенко on 12/13/24.
//

import SwiftUI

extension Image {
    init(icon: Icons) {
        self.init(systemName: icon.rawValue)
    }
    
    enum Icons: String {
        case book = "book"
        case xmark = "xmark"
        case tvPlay = "play.tv"
    }
}
