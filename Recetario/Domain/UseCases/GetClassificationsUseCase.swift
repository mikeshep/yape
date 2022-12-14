//
//  GetClassificationsUseCase.swift
//  Recetario
//
//  Created by Miguel Angel Olmedo Perez on 14/12/22.
//

import Foundation

protocol GetCategoriesUseCaseProtocol {
    func execute() async throws -> [Category]
}

final class GetCategoriesUseCase: GetCategoriesUseCaseProtocol {

    typealias RequestValue = Void

    typealias ResultValue = [Category]

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
    func fetchClassifications() async throws -> [Category]
}

class RecipeService: RecipeRepository {
    func fetchClassifications() async throws -> [Category] {
        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<[Category], Error>) in
            loadJSONData { (data: [Category]?, error: Error?) in
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
