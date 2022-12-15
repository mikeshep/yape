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
}

struct RecipeCategoriesViewModelOutput {
    let items = PassthroughSubject<[Category], Error>()
}

class RecipeCategoriesViewModel {
    private let getCategoriesUseCase: GetCategoriesUseCaseProtocol
    private let output: RecipeCategoriesViewModelOutput
    private var subscriptions = Set<AnyCancellable>()
    
    init(getCategoriesUseCase: GetCategoriesUseCaseProtocol, output: RecipeCategoriesViewModelOutput) {
        self.getCategoriesUseCase = getCategoriesUseCase
        self.output = output
    }
    
    func bind(input: RecipeCategoriesViewModelInput) -> RecipeCategoriesViewModelOutput {
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
