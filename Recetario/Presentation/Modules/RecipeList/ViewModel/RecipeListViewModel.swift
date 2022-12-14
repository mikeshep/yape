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
    
}

class RecipeListViewModel {
    private let getClassificationsUseCase: GetCategoriesUseCaseProtocol
    private let output: RecipeListViewModelOutput
    private var subscriptions = Set<AnyCancellable>()

    init(getClassificationsUseCase: GetCategoriesUseCaseProtocol, output: RecipeListViewModelOutput) {
        self.getClassificationsUseCase = getClassificationsUseCase
        self.output = output
    }

    func bind(input: RecipeListViewModelInput) -> RecipeListViewModelOutput {
        input.viewDidLoadPublisher
            .sink { _ in
                Task {
                    do {
                        let classifications = try await self.getClassificationsUseCase.execute()
                        debugPrint(classifications)
                    } catch {
                        debugPrint("Error \(error)")
                    }
                }
            }
            .store(in: &subscriptions)
        return output
    }
}
