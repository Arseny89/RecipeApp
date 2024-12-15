//
//  DataProvider.swift
//  RecipeApp
//
//  Created by Арсений Корниенко on 12/10/24.
//

import UIKit
import Foundation

final class DataProvider {
    
    private let endpointProvider = EndpointProvider(for: .config)
    
    private func getData(_ endpoint: EndpointProvider.Endpoint) async throws -> Data {
        let url = endpointProvider.getURL(for: endpoint)
        let request = URLRequest(url: url)
        let (data,_) = try await URLSession.shared.data(for: request)
        return data
    }
    
    func getImage(from url: URL) async throws -> UIImage? {
        let request = URLRequest(url: url)
        let (data,_) = try await URLSession.shared.data(for: request)
        return UIImage(data: data)
    }
    
    func fetchData(_ endpoint: EndpointProvider.Endpoint) async throws -> Recipes {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let data = try await getData(endpoint)
        let recipes = try decoder.decode(Recipes.self, from: data)
        return recipes
    }
}
