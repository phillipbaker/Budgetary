//
//  CategoryGroupDao.swift
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
    
    func startStreaming() {
        continuation.yield(mapper.mapDbToPlain(categoryGroupsDb: mock))
    }
    
    func loadCategoryGroups() -> [CategoryGroupDb] {
        return mock
    }
    
    func streamCategoryGroups() -> AsyncStream<[CategoryGroupPlain]> {
        return stream
    }
    
    func findCategoryGroup(by id: UUID) -> CategoryGroupDb? {
        return mock.first(where: { $0.externalID == id })
    }
    
    func findCategoryGroup(containing categoryID: UUID) -> CategoryGroupDb? {
        return mock.first(where: { $0.categories.contains(where: { $0.externalID == categoryID })})
    }
    
    func create(categoryGroup: CategoryGroupDb) {
        let newMock = mock + [categoryGroup]
        mock = newMock
        continuation.yield(mapper.mapDbToPlain(categoryGroupsDb: mock))
    }
    
    func update(categoryGroup: CategoryGroupDb) {
        let newMock = mock.map { $0.externalID == categoryGroup.externalID ? categoryGroup : $0 }
        mock = newMock
        guard let updateCategoryGroup = mock.first(where: { categoryGroup.id == $0.id }) else {
            print("CategoryGroupDAO - could not find updated group")
            return
        }
        print("Updated Group Category Count: ", updateCategoryGroup.categories.count)
        for category in categoryGroup.categories {
            print("Category Name: ", category.name)
        }
        continuation.yield(mapper.mapDbToPlain(categoryGroupsDb: mock))
    }
    
    func update(categoryGroups: [CategoryGroupDb]) {
        mock = categoryGroups
        continuation.yield(mapper.mapDbToPlain(categoryGroupsDb: mock))
    }
    
    func delete(categoryGroup: CategoryGroupDb) {
        let countBefore = mock.count
        mock.removeAll(where: { $0.externalID == categoryGroup.externalID })
        guard mock.count != countBefore else { return }
        continuation.yield(mapper.mapDbToPlain(categoryGroupsDb: mock))
    }
    
    private var mock: [CategoryGroupDb] = [
        CategoryGroupDb(
            externalID: .init(),
            name: "Immediate Obligations",
            isHidden: false,
            categories: [
                CategoryDb(
                    externalID: .init(),
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
                    externalID: .init(),
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
                    externalID: .init(),
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
            externalID: .init(),
            name: "True Expenses",
            isHidden: false,
            categories: [
                CategoryDb(
                    externalID: .init(),
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
            externalID: .init(),
            name: "Monthly Expenses",
            isHidden: false,
            categories: [
                CategoryDb(
                    externalID: .init(),
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
            externalID: .init(),
            name: "Fun",
            isHidden: false,
            categories: [
                CategoryDb(
                    externalID: .init(),
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
