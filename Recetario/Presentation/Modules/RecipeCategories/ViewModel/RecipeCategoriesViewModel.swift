//
//  RecipeCategoriesViewModel.swift
//  Recetario
//
//  Created by Miguel Angel Olmedo Perez on 14/12/22.
//

import Foundation
import Combine

struct RecipeCategoriesViewModelInput {
    let viewDidLoadPublisher = PassthroughSubject<Void, Never>()
    let didSelectItemPublisher = PassthroughSubject<(Int,Int), Never>()
}

struct RecipeCategoriesViewModelOutput {
    let items = PassthroughSubject<[Category], Error>()
}

class RecipeCategoriesViewModel {
    private let getCategoriesUseCase: GetCategoriesUseCaseProtocol
    private let output: RecipeCategoriesViewModelOutput
    private var subscriptions = Set<AnyCancellable>()
    private var items = [Category]()
    private weak var coordinator: Coordinator?
    
    init(getCategoriesUseCase: GetCategoriesUseCaseProtocol, output: RecipeCategoriesViewModelOutput, coordinator: Coordinator) {
        self.getCategoriesUseCase = getCategoriesUseCase
        self.output = output
        self.coordinator = coordinator
    }
    
    func bind(input: RecipeCategoriesViewModelInput) -> RecipeCategoriesViewModelOutput {
        input.viewDidLoadPublisher
            .sink(receiveValue: getCategories)
            .store(in: &subscriptions)
    
        input.didSelectItemPublisher
            .sink(receiveValue: routeToRecipeList)
            .store(in: &subscriptions)
        return output
    }
    
    func getCategories() {
        Task {
            do {
                let categories = try await self.getCategoriesUseCase.execute()
                self.items = categories
                self.output.items.send(categories)
            } catch {
                self.output.items.send(completion: .failure(error))
            }
        }
    }

    func routeToRecipeList(indexPath: (Int, Int)) {
        let item = items[indexPath.0].classifications[indexPath.1]
        coordinator?.goToRecipeList(key: item.key)
    }
}
