//
//  ContentViewModel.swift
//  RecipeApp
//
//  Created by Арсений Корниенко on 12/14/24.
//

import SwiftUI

final class ContentViewModel: ObservableObject {
    @Published var recipes: Recipes?
    @Published var youtubeUrl: URL?
    @Published var sourceUrl: URL?
    @Published var columns = [
        GridItem(.flexible(minimum: 100))
    ]
    
    init() {
        Task {
            await getRecipes(for: .recipesWorking)
        }
    }
    
    func getRecipes(for endpoint: EndpointProvider.Endpoint) async {
        Task { @MainActor in
            do {
                recipes = try await DataProvider().fetchData(endpoint)                
            }
            catch {
                recipes = nil
            }
        }
    }
}
