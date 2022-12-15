//
//  GetClassificationsUseCase.swift
//  RecetarioTests
//
//  Created by Miguel Angel Olmedo Perez on 15/12/22.
//

import XCTest
import SDWebImage
@testable import Recetario

final class GetCategoriesUseCaseTest: XCTestCase {
    func test_getCategoriesUSeCsae_fetchCategories() async throws {
        let repository = RecipeServiceMock()
        let sut = GetCategoriesUseCase(requestValue: (), recipeRepository: repository)

        XCTAssertFalse(repository.fetchCategoriesCalled)

        _ = try await sut.execute()

        XCTAssertTrue(repository.fetchCategoriesCalled)
    }

    func test_searchUseCase_fetchSerch() async throws {
        let repository = RecipeServiceMock()
        let sut = SearchUseCase(requestValue: "", recipeRepository: repository)

        XCTAssertFalse(repository.fetchSearchCalled)

        _ = try await sut.execute()

        XCTAssertTrue(repository.fetchSearchCalled)
    }

    func test_getFeedUseCase_fetchFeed() async throws {
        let repository = RecipeServiceMock()
        let sut = GetFeedUseCase(requestValue: 0, recipeRepository: repository)

        XCTAssertFalse(repository.fetchFeedCalled)

        _ = try await sut.execute()

        XCTAssertTrue(repository.fetchFeedCalled)
    }

    func test_getRecipeUseCase_fetchRecipe() async throws {
        let repository = RecipeServiceMock()
        let sut = GetRecipeUseCase(requestValue: 0, recipeRepository: repository)

        XCTAssertFalse(repository.fetchRecipeCalled)

        _ = try await sut.execute()

        XCTAssertTrue(repository.fetchRecipeCalled)
    }
}

class RecipeServiceMock: RecipeRepository {

    var fetchCategoriesCalled = false
    var fetchSuggestionsCalled = false
    var fetchSearchCalled = false
    var fetchFeedCalled = false
    var fetchRecipeCalled = false
    
    func fetchCategories() async throws -> [Recetario.Category] {
        fetchCategoriesCalled = true
        return []
    }
    
    func fetchSuggestions(string: String) async throws -> [Recetario.Suggestion] {
        fetchSuggestionsCalled = true
        return []
    }
    
    func fetchSearch(q: String) async throws -> ShortsRecipe {
        fetchSearchCalled = true
        return mockShortsRecipe()
    }
    
    func fetchFeed(id: Int) async throws -> ShortsRecipe {
        fetchFeedCalled = true
        return mockShortsRecipe()
    }
    
    func fetchRecipe(key: Int) async throws -> Recetario.Recipe {
        fetchRecipeCalled = true
        return mockRecipe()
    }

    func mockShortsRecipe() -> ShortsRecipe {
        ShortsRecipe(payload: [])
    }

    func mockRecipe() -> Recipe {
        let video  = Video(videoDescription: "", duration: 0, name: "", player: "", thumb: "", videoid: "", vkey: 0)
        let clientData = RecipeClientdata(avatar: "", ckey: 0, firstname: "", lastname: "", path: "")
        return Recipe(bc: [], calories: nil, classification: 0, classificationname: "", classificationpath: "", client: 0, clientdata: clientData, cooked: 0, cooktime: 0, cooktimestr: "", cuisinename: "", recipeDescription: "", device: "", difficulty: 0, favorites: 0, htmltitle: "", image: "", images: [], ingredients: [], key: 0, language: "", level: 0, link: "", metadescription: "", name: "", nutrients: [], path: "", portions: 0, prating: "", presentation: "", published: "", rating: 0, revised: 0, status: 0, steps: [], tecuida: true, time: 0, timestr: "", tips: "", titleh1: "", totaltime: 0, totaltimestr: "", video: video, videos: [], view: 0)
    }
}
