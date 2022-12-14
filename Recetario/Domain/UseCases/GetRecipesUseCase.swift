//
//  GetRecipesUseCase.swift
//  Recetario
//
//  Created by Miguel Angel Olmedo Perez on 14/12/22.
//

import Foundation

protocol GetClassificationsUseCaseProtocol {
    func execute() async throws -> [Classification]
}

final class GetClassificationsUseCase: GetClassificationsUseCaseProtocol {

    typealias RequestValue = Void

    typealias ResultValue = [Classification]

    private let requestValue: RequestValue
    private let recipeRepository: RecipeRepository

    init(requestValue: RequestValue,
         recipeRepository: RecipeRepository) {
        self.requestValue = requestValue
        self.recipeRepository = recipeRepository
    }

    func execute() async throws -> ResultValue {
        return try await recipeRepository.fetchClassifications()
    }
}

protocol RecipeRepository {
    func fetchClassifications() async throws -> [Classification]
}

class RecipeService: RecipeRepository {
    func fetchClassifications() async throws -> [Classification] {
        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<[Classification], Error>) in
            loadJSONData { (data: [Classification]?, error: Error?) in
                if let error {
                    continuation.resume(throwing: error)
                }
                if let data {
                    continuation.resume(returning: data)
                }
            }
        })
    }

    func loadJSONData<T: Codable>(completion: @escaping (_ data: T?, _ error: Error?) -> ())  {
        DispatchQueue.global(qos: .background).async {
            let path = Bundle.main.path(forResource: "classifications_response_200", ofType: "json")!
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let object = try JSONDecoder().decode(T.self, from: data)
                completion(object, nil)
            } catch {
                completion(nil, error)
            }
        }
    }
}


enum RecipeServiceError: Error {
case failLoadJSON
case unknow
}
