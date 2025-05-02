//
//  LoadCategoryGroupsUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 02/11/2024.
//

import Factory

final class LoadCategoryGroupsUseCase: Sendable {
    let source: LoadCategoryGroupsSource = Container.shared.loadCategoryGroupsSource()
    let mapper: EditCategoriesMapper = Container.shared.editCategoriesMapper()
    
    private let (categoryGroupsStream, continuation) = AsyncStream.makeStream(of: [EditableCategoryGroup].self, bufferingPolicy: .bufferingNewest(1))
    
    init() {
        Task {
            for await categoryGroups in await source.categoryGroupsStream() {
                continuation.yield(mapper.map(categoryGroupsPlain: categoryGroups))
            }
            
            continuation.onTermination = { reason in
                // Cleanup if necessary
                print("use case stream terminated for reason: ", reason)
            }
        }
    }
    
    func load() async -> [EditableCategoryGroup] {
        return mapper.map(categoryGroupsPlain: await source.loadCategoryGroups())
    }
    
    func subscribe() async -> AsyncStream<[EditableCategoryGroup]> {
        return categoryGroupsStream
    }
}
