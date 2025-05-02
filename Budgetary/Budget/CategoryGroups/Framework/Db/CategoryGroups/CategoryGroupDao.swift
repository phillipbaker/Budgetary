//
//  CategoryGroupsDao.swift
//  Budgetary
//
//  Created by Phillip Baker on 05/11/2024.
//

import Factory
import Foundation
import SwiftData

class CategoryGroupDao {
    private let container: ModelContainer
    let mapper: CategoryGroupsMapperPlain = Container.shared.categoryGroupsMapperPlain()
    
    private let (stream, continuation) = AsyncStream.makeStream(of: [CategoryGroupPlain].self)
    
    init(container: ModelContainer) {
        self.container = container
        startStreaming()
    }
    
    func allCategoryGroups() -> [CategoryGroupDb] {
        return mock
    }
    
    func startStreaming() {
        continuation.yield(mapper.mapDbToPlain(categoryGroupsDb: mock))
    }
    
    func streamCategoryGroups() -> AsyncStream<[CategoryGroupPlain]> {
        return stream
    }
    
    func findCategoryGroup(by id: String) -> CategoryGroupDb? {
        return mock.first(where: { $0.id == id })
    }
    
    func findCategoryGroup(containing categoryId: String) -> CategoryGroupDb? {
        return mock.first(where: { $0.categories.contains(where: { $0.id == categoryId })})
    }
    
    func create(categoryGroup: CategoryGroupDb) {
        mock.insert(categoryGroup, at: 0)
        continuation.yield(mapper.mapDbToPlain(categoryGroupsDb: mock))
    }
    
    func update(categoryGroup: CategoryGroupDb) {
        let newMock = mock.map { $0.id == categoryGroup.id ? categoryGroup : $0 }
        mock = newMock
        continuation.yield(mapper.mapDbToPlain(categoryGroupsDb: mock))
    }
    
    func update(categoryGroups: [CategoryGroupDb]) {
        mock = categoryGroups
        continuation.yield(mapper.mapDbToPlain(categoryGroupsDb: mock))
    }
    
    func delete(categoryGroup: CategoryGroupDb) {
        // Is this necessary or does removeAll simply skip/fail silently if no groups match?
        guard mock.contains(where: { $0.id == categoryGroup.id }) else {
            // throw error?
            print("could not locate category group to delete")
            return
        }
        mock.removeAll(where: { $0.id == categoryGroup.id })
        continuation.yield(mapper.mapDbToPlain(categoryGroupsDb: mock))
    }
    
    private var mock: [CategoryGroupDb] = [
        CategoryGroupDb(
            id: "1",
            name: "Immediate Obligations",
            categories: [
                CategoryDb(
                    id: "2",
                    name: "Rent",
                    notes: "",
                    isHidden: false,
                    assigned: [
                        .aug2024: 0.00,
                        .sep2024: 0.00,
                        .oct2024: 0.00,
                        .apr2025: 100.00
                    ]
                ),
                CategoryDb(
                    id: "3",
                    name: "Council Tax",
                    notes: "",
                    isHidden: false,
                    assigned: [
                        .aug2024: 311.00,
                        .sep2024: 312.00,
                        .oct2024: 313.00,
                    ]
                ),
                CategoryDb(
                    id: "4",
                    name: "Utilities",
                    notes: "",
                    isHidden: false,
                    assigned: [
                        .aug2024: 0.00,
                        .sep2024: 0.00,
                        .oct2024: 50.00,
                    ]
                )
            ]
        ),
        CategoryGroupDb(
            id: "5",
            name: "True Expenses",
            categories: [
                CategoryDb(
                    id: "6",
                    name: "YNAB",
                    notes: "",
                    isHidden: false,
                    assigned: [
                        .aug2024: 10.00,
                        .sep2024: 11.00,
                        .oct2024: 12.00,
                        .apr2025: 100.00
                    ]
                )
            ]
        ),
        CategoryGroupDb(
            id: "7",
            name: "Monthly Expenses",
            categories: [
                CategoryDb(
                    id: "8",
                    name: "Groceries",
                    notes: "",
                    isHidden: false,
                    assigned: [
                        .aug2024: 0.00,
                        .sep2024: 0.00,
                        .oct2024: 0.00,
                    ]
                )
            ]
        ),
        CategoryGroupDb(
            id: "9",
            name: "Fun",
            categories: [
                CategoryDb(
                    id: "10",
                    name: "Phil",
                    notes: "",
                    isHidden: false,
                    assigned: [
                        .aug2024: 0.00,
                        .sep2024: 0.00,
                        .oct2024: 0.00,
                        .apr2025: 100.00
                    ]
                )
            ]
        )
    ]
}
