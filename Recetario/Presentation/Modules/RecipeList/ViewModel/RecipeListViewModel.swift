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
    private let searchUseCase: SearchUseCaseProtocol?
    private let feedUseCase: GetFeedUseCaseProtocol?
    private let output: RecipeListViewModelOutput
    private var subscriptions = Set<AnyCancellable>()
    
    init(searchUseCase: SearchUseCaseProtocol?, feedUseCase: GetFeedUseCaseProtocol?, output: RecipeListViewModelOutput) {
        self.searchUseCase = searchUseCase
        self.feedUseCase = feedUseCase
        self.output = output
    }
    
    func bind(input: RecipeListViewModelInput) -> RecipeListViewModelOutput {
        if searchUseCase != nil {
            input.viewDidLoadPublisher
                .sink(receiveValue: search)
                .store(in: &subscriptions)
        } else {
            input.viewDidLoadPublisher
                .sink(receiveValue: feed)
                .store(in: &subscriptions)
        }
        
        return output
    }
    
    func search() {
        Task {
            do {
                guard let shortRecipes = try await self.searchUseCase?.execute() else {
                    self.output.items.send(completion: .failure(RecipeServiceError.unknown))
                    return
                }
                self.output.items.send(shortRecipes.payload)
            } catch {
                self.output.items.send(completion: .failure(error))
            }
        }
    }

    func feed() {
        Task {
            do {
                guard let shortRecipes = try await self.feedUseCase?.execute() else {
                    self.output.items.send(completion: .failure(RecipeServiceError.unknown))
                    return
                }
                self.output.items.send(shortRecipes.payload)
            } catch {
                self.output.items.send(completion: .failure(error))
            }
        }
    }
}
