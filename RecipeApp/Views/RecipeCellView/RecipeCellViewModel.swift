//
//  RecipeCellViewModel.swift
//  RecipeApp
//
//  Created by Арсений Корниенко on 12/14/24.
//

import SwiftUI

class RecipeCellViewModel: ObservableObject {
    @Published var uiImage: UIImage?
    init(for recipe: Recipe) {
        Task {
            await loadImage(recipe: recipe)
        }
    }
    func loadImage(recipe: Recipe) async {
        Task { @MainActor in
            do {
                if let image = DataCacheManager.cache.getImage(for: recipe.id) {
                    uiImage = image
                } else {
                    uiImage = try await DataProvider().getImage(from: recipe.smallPhotoURL)
                    if let uiImage {
                        DataCacheManager.cache.setImage(image: uiImage, for: recipe.id)
                    }
                }
            }
            catch {
                uiImage = UIImage(systemName: "xmark")
            }
        }
    }
}
