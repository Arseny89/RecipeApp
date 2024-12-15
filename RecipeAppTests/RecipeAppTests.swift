//
//  RecipeAppTests.swift
//  RecipeAppTests
//
//  Created by Арсений Корниенко on 12/10/24.
//

import XCTest
@testable import RecipeApp

final class RecipeAppTests: XCTestCase {
    var dataProvider: DataProvider!
    var imageCache: DataCacheManager!
    var image: UIImage!
    var imageKey: String!
    
    override func setUpWithError() throws {
        dataProvider = DataProvider()
        imageCache = DataCacheManager.cache
        image = UIImage.checkmark
        imageKey = "qwerty123"
    }

    override func tearDownWithError() throws {
        dataProvider = nil
        imageCache = nil
        image = nil
        imageKey = nil
    }

    func testDataFetching() throws {
        var result: Recipes?
        let expectation = expectation(description: #function)
        let isEmpty = true
        Task {
            do {
                result = try await dataProvider.fetchData(.recipesWorking)
                expectation.fulfill()
            }
            catch {
            }
        }
        
        waitForExpectations(timeout: 2) { error in
            if error != nil {
                XCTFail()
            }
            XCTAssertNotNil(result)
            XCTAssertNotEqual(result?.recipes.isEmpty, isEmpty)
        }
    }
    
    func testImageCacheSaving() throws {
        var uiImage: UIImage?

        imageCache.setImage(image: image, for: imageKey)
        uiImage = imageCache.getImage(for: imageKey)
        
        XCTAssertEqual(uiImage, image)
    }
    
    func testImageCacheOverwriting() {
        var cachedImage: UIImage?
        let secondImage = UIImage.remove
        
        imageCache.setImage(image: image, for: imageKey)
        imageCache.setImage(image: secondImage, for: imageKey)
        
        cachedImage = imageCache.getImage(for: imageKey)
        
        XCTAssertEqual(cachedImage, secondImage)        
    }
    

    func testPerformanceExample() throws {
        self.measure {
        }
    }

}
