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
    let didSelectItemPublisher = PassthroughSubject<Int, Never>()
}

struct RecipeListViewModelOutput {
    let items = PassthroughSubject<[ShortRecipe], Error>()
}

class RecipeListViewModel {
    private let searchUseCase: SearchUseCaseProtocol?
    private let feedUseCase: GetFeedUseCaseProtocol?
    private let output: RecipeListViewModelOutput
    private var subscriptions = Set<AnyCancellable>()
    private var items = [ShortRecipe]()
    private weak var coordinator: Coordinator?
    
    init(searchUseCase: SearchUseCaseProtocol?,
         feedUseCase: GetFeedUseCaseProtocol?,
         output: RecipeListViewModelOutput, coordinator: Coordinator) {
        self.searchUseCase = searchUseCase
        self.feedUseCase = feedUseCase
        self.output = output
        self.coordinator = coordinator
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
    
        input.didSelectItemPublisher
            .sink(receiveValue: didSelectItem)
            .store(in: &subscriptions)

        return output
    }

    func didSelectItem(index: Int) {
        let item = items[index]
        switch item.k {
        case .string(let string):
            coordinator?.goToRecipe(key: Int(string) ?? 0)
        case .integer(let int):
            coordinator?.goToRecipe(key: int)
        }
    }
    
    func search() {
        Task {
            do {
                guard let shortRecipes = try await self.searchUseCase?.execute() else {
                    self.output.items.send(completion: .failure(RecipeServiceError.unknown))
                    return
                }
                self.output.items.send(shortRecipes.payload)
                self.items = shortRecipes.payload
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
                self.items = shortRecipes.payload
            } catch {
                self.output.items.send(completion: .failure(error))
            }
        }
    }
}
