//
//  EndpointProvider.swift
//  RecipeApp
//
//  Created by Арсений Корниенко on 12/10/24.
//

import Foundation

extension EndpointProvider {
    
    enum Config {
        case config
        
        var configName: String {
            switch self {
            case .config: return "Config"
            }
        }
    }
    
    enum Endpoint {
        case recipesWorking
        case recipesMalformed
        case recipesEmpty
        
        var pathComponent: String {
            switch self {
            case .recipesWorking:
                "recipes.json"
            case .recipesMalformed:
                "recipes-malformed.json"
            case .recipesEmpty:
                "recipes-empty.json"
            }
        }
    }
}

final class EndpointProvider {
    
    let baseUrl: URL
    
    init(for config: Config) {
        var format = PropertyListSerialization.PropertyListFormat.xml
        guard let path = Bundle.main.path(forResource: config.configName, ofType: "plist"),
              let file = FileManager.default.contents(atPath: path),
              let configuration = try? PropertyListSerialization.propertyList(
                from: file,
                options: .mutableContainersAndLeaves,
                format: &format
              ) as? [String: Any] else {
            fatalError("\(config.configName).plist not found")
        }
        
        guard let recipeAPI = configuration["recipeAPI"] as? [String: Any],
              let scheme = recipeAPI["scheme"] as? String,
              let host = recipeAPI["host"] as? String
        else {
            fatalError()
        }
        
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        baseUrl = urlComponents.url!
    }
    
    func getURL(for endpoint: Endpoint) -> URL {
        let url = baseUrl.appendingPathComponent(endpoint.pathComponent)
        
        return url
    }
}
