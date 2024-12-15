//
//  ContentView.swift
//  RecipeApp
//
//  Created by Арсений Корниенко on 12/10/24.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: ContentViewModel
    init() {
        viewModel = ContentViewModel()
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                if viewModel.recipes != nil {
                    if !viewModel.recipes!.recipes.isEmpty {
                        LazyVGrid(columns: viewModel.columns) {
                            ForEach(viewModel.recipes!.recipes, id: \.id) { recipe in
                                RecipeCellView(viewModel: RecipeCellViewModel(for: recipe),
                                               recipe: recipe,
                                               sourceUrl: viewModel.sourceUrl,
                                               youtubeUrl: viewModel.youtubeUrl)
                                .padding(.top, 1)
                            }
                            
                        }
                        .padding(20)
                    } else {
                        errorView(title: ContentViewElements.emptyError.title,
                                  subtitle: ContentViewElements.emptyError.subtitle)
                        .frame(width: geometry.size.width)
                        .frame(minHeight: geometry.size.height)
                    }
                } else {
                    errorView(title: ContentViewElements.malformedError.title,
                              subtitle: ContentViewElements.malformedError.subtitle)
                    .frame(width: geometry.size.width)
                    .frame(minHeight: geometry.size.height)
                }
            }
            .refreshable {
                await viewModel.getRecipes(for: .recipesWorking)
            }
        }
    }
}

struct errorView: View {
    var title: String
    var subtitle: String
    
    var body: some View {
        VStack(alignment: .center) {
            Text(title)
                .font(.headline)
            Text(subtitle)
                .font(.subheadline)
        }
    }
}

#Preview {
    ContentView()
}
