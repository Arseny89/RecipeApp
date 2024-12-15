//
//  URL+Identifiable.swift
//  RecipeApp
//
//  Created by Арсений Корниенко on 12/13/24.
//

import Foundation

extension URL: @retroactive Identifiable {
    public var id: Self { self }    
}
