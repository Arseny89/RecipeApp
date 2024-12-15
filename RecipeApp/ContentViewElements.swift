//
//  ContentViewElements.swift
//  RecipeApp
//
//  Created by Арсений Корниенко on 12/14/24.
//

enum ContentViewElements {
    case emptyError
    case malformedError
    
    var title: String {
        switch self {
        case .emptyError:
            "There are no recipes to display"
        case .malformedError:
            "Something went wrong"
        }
    }
    
    var subtitle: String {
        switch self {
        case .emptyError:
            "Try again later"
        case .malformedError:
            "Pull down to refresh"
        }
    }
}
