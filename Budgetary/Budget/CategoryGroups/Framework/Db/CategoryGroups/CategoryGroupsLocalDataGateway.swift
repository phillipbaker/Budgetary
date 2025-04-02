//
//  CategoryGroupsLocalDataGateway.swift
//  Budgetary
//
//  Created by Phillip Baker on 05/11/2024.
//

import Factory

actor CategoryGroupsLocalDataGateway: CategoryGroupsDataSourceLocal {
    let dao: CategoryGroupDao = Container.shared.categoryGroupDao()
    let mapper: CategoryGroupsMapperPlain = Container.shared.categoryGroupsMapperPlain()
    
    private let (stream, continuation) = AsyncStream.makeStream(of: [CategoryGroupPlain].self, bufferingPolicy: .bufferingNewest(1))
    
    init() {
        Task { await startStreaming() }
    }
    
    func categoryGroupsStream() -> AsyncStream<[CategoryGroupPlain]> {
        return stream
    }
    
    private func startStreaming() async {
        for await categoryGroupsPlain in dao.streamCategoryGroups() {
            continuation.yield(categoryGroupsPlain)
        }
        
        continuation.onTermination = { @Sendable reason in
            // Handle any necessary cleanup
            print("categories gateway stream terminated with reason: ", reason)
        }
    }
    
    func allCategoryGroups() -> [CategoryGroupPlain] {
        let categoryGroupsDb = dao.allCategoryGroups()
        return mapper.mapDbToPlain(categoryGroupsDb: categoryGroupsDb)
    }
    
    func findCategoryGroup(by id: String) -> CategoryGroupPlain {
        let categoryGroupDb = dao.findCategoryGroup(by: id)
        return mapper.mapDbToPlain(categoryGroupDb: categoryGroupDb)
    }
    
    func findCategory(by id: String) -> CategoryPlain {
        let category = dao.findCategory(by: id)
        return mapper.mapDbToPlain(categoryDb: category)
    }
    
    func update(category: CategoryPlain) {
        print("update category called in gateway")
        print("name in gateway:", category.name)
        let categoryDb = mapper.mapPlainToDb(categoryPlain: category)
        dao.update(category: categoryDb)
    }
    
    func create(categoryGroup: CategoryGroupPlain) {
        dao.create(categoryGroup: mapper.mapPlainToDb(categoryGroupPlain: categoryGroup))
    }
    
    func update(categoryGroup: CategoryGroupPlain) {
        dao.update(categoryGroup: mapper.mapPlainToDb(categoryGroupPlain: categoryGroup))
    }
    
    func delete(categoryGroup: CategoryGroupPlain) {
        dao.delete(categoryGroup: mapper.mapPlainToDb(categoryGroupPlain: categoryGroup))
    }
}
