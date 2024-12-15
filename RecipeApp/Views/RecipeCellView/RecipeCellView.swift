//
//  RecipeCellView.swift
//  RecipeApp
//
//  Created by Арсений Корниенко on 12/13/24.
//

import SwiftUI

struct RecipeCellView: View {
    @ObservedObject var viewModel: RecipeCellViewModel
    var recipe: Recipe
    @State var sourceUrl: URL?
    @State var youtubeUrl: URL?
    
    var body: some View {
        HStack(alignment: .top) {
            
            if let uiImage = viewModel.uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
            }
            
            VStack(alignment: .leading) {
                let name = recipe.name
                Text(name)
                    .font(.headline)
                let cuisine = recipe.cuisine
                Text(cuisine)
                    .font(.subheadline)
                
            }
            .padding(10)
            
            Spacer()
            
            VStack {
                Group {
                    if recipe.sourceURL != nil {
                        Button {
                            sourceUrl = recipe.sourceURL
                        } label: {
                            Image(icon: .book)
                                .padding(10)
                                .imageScale(.large)
                        }
                        .fullScreenCover(item: $sourceUrl) {url in
                            RecipeWebView(url: url)
                                .padding(40)
                                .presentationBackground(Color.black.opacity(0.4))
                        }
                        
                    } else {
                        Spacer()
                    }
                    
                    if recipe.youtubeURL != nil {
                        Button {
                            youtubeUrl = recipe.youtubeURL
                            
                        } label: {
                            Image(icon: .tvPlay)
                                .padding(10)
                                .imageScale(.large)
                        }
                        .fullScreenCover(item: $youtubeUrl) {url in
                            RecipeWebView(url: url)
                                .padding(40)
                                .presentationBackground(Color.black.opacity(0.4))
                        }
                    } else {
                        Spacer()
                    }
                }
                .foregroundColor(.black)
            }
        }
        .clipShape(.rect(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.gray, lineWidth: 1)
        )
    }
}
