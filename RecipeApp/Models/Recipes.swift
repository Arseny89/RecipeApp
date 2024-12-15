//
//  Recipes.swift
//  RecipeApp
//
//  Created by Арсений Корниенко on 12/10/24.
//

import SwiftUI
import SwiftData

struct Recipes: Decodable {
    var recipes: [Recipe]
}

struct Recipe: Decodable, Identifiable {
    let id: String
    let name: String
    let cuisine: String
    let largePhotoURL: URL
    let smallPhotoURL: URL
    var sourceURL: URL?
    var youtubeURL: URL?
    
    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case name
        case cuisine
        case photoUrlLarge
        case photoUrlSmall
        case sourceUrl
        case youtubeUrl
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.cuisine = try container.decode(String.self, forKey: .cuisine)
        let photoUrlLarge = try container.decode(String.self, forKey: .photoUrlLarge)
        self.largePhotoURL = URL(string: "\(photoUrlLarge)") ?? URL.homeDirectory
        let photoUrlSmall = try container.decode(String.self, forKey: .photoUrlSmall)
        self.smallPhotoURL = URL(string: "\(photoUrlSmall)") ?? URL.homeDirectory
        let sourceUrl = try container.decodeIfPresent(String.self, forKey: .sourceUrl)
        self.sourceURL = URL(string: "\(sourceUrl ?? "")")
        let youtubeUrl = try container.decodeIfPresent(String.self, forKey: .youtubeUrl)
        self.youtubeURL = URL(string: "\(youtubeUrl ?? "")")
    }
}
