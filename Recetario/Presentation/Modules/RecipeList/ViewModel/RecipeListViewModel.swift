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
    let items = PassthroughSubject<[ShortRecipe], Error>()
}

class RecipeListViewModel {
    private let searchUseCase: SearchUseCaseProtocol
    private let output: RecipeListViewModelOutput
    private var subscriptions = Set<AnyCancellable>()
    
    init(q: String, searchUseCase: SearchUseCaseProtocol, output: RecipeListViewModelOutput) {
        self.searchUseCase = searchUseCase
        self.output = output
    }
    
    func bind(input: RecipeListViewModelInput) -> RecipeListViewModelOutput {
        input.viewDidLoadPublisher
            .sink(receiveValue: search)
            .store(in: &subscriptions)
        return output
    }
    
    func search(){
        Task {
            do {
                let shortRecipes = try await self.searchUseCase.execute()
                self.output.items.send(shortRecipes.payload)
            } catch {
                self.output.items.send(completion: .failure(error))
            }
        }
    }
}
