//
//  RecipeViewModel.swift
//  Recetario
//
//  Created by Miguel Angel Olmedo Perez on 14/12/22.
//

import Foundation
import Combine

struct RecipeViewModelInput {
    let viewDidLoadPublisher = PassthroughSubject<Void, Never>()
}

struct RecipeViewModelOutput {
    let item = PassthroughSubject<Recipe, Error>()
}

class RecipeViewModel {
    private let output: RecipeViewModelOutput
    private var subscriptions = Set<AnyCancellable>()
    private let getRecipeUseCase: GetRecipeUseCaseProtocol
    
    init(getRecipeUseCase: GetRecipeUseCaseProtocol, output: RecipeViewModelOutput) {
        self.output = output
        self.getRecipeUseCase = getRecipeUseCase
    }
    
    func bind(input: RecipeViewModelInput) -> RecipeViewModelOutput {
        input.viewDidLoadPublisher
            .sink(receiveValue: fetch)
            .store(in: &subscriptions)
        
        return output
    }
    
    func fetch() {
        Task {
            do {
                let recipe = try await self.getRecipeUseCase.execute()
                self.output.item.send(recipe)
            } catch {
                self.output.item.send(completion: .failure(error))
            }
        }
    }
}
