//
//  RecipeListViewModel.swift
//  Recetario
//
//  Created by Miguel Angel Olmedo Perez on 14/12/22.
//

import Foundation
import Combine

struct RecipeListViewModelInput {
    let viewDidLoadPublisher = PassthroughSubject<Void, Never>()
}

struct RecipeListViewModelOutput {
    let items = PassthroughSubject<[Category], Error>()
}

class RecipeListViewModel {
    private let getCategoriesUseCase: GetCategoriesUseCaseProtocol
    private let output: RecipeListViewModelOutput
    private var subscriptions = Set<AnyCancellable>()
    
    init(getCategoriesUseCase: GetCategoriesUseCaseProtocol, output: RecipeListViewModelOutput) {
        self.getCategoriesUseCase = getCategoriesUseCase
        self.output = output
    }
    
    func bind(input: RecipeListViewModelInput) -> RecipeListViewModelOutput {
        input.viewDidLoadPublisher
            .sink(receiveValue: getCategories)
            .store(in: &subscriptions)
        return output
    }
    
    func getCategories(){
        Task {
            do {
                let categories = try await self.getCategoriesUseCase.execute()
                self.output.items.send(categories)
            } catch {
                self.output.items.send(completion: .failure(error))
            }
        }
    }
}
