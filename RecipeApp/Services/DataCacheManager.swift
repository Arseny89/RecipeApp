//
//  DataCacheManager.swift
//  RecipeApp
//
//  Created by Арсений Корниенко on 12/14/24.
//

import SwiftUI

class DataCacheManager {
    static let cache = DataCacheManager()
    private let imageCache = NSCache<NSString, UIImage>()
        
    func getImage(for key: String) -> UIImage? {
        return imageCache.object(forKey: NSString(string: key))
    }
    
    func setImage(image: UIImage,for key: String) {
        imageCache.setObject(image, forKey: NSString(string: key))
    }
}
