//
//  CategoryGroupsMapperPlain.swift
//  Budgetary
//
//  Created by Phillip Baker on 05/11/2024.
//

import Dependencies

actor CategoryGroupsLocalDataGateway: CategoryGroupsDataSourceLocal {
    let dao: CategoryGroupDao
    let mapper: CategoryGroupsMapperPlain
    
    private let (stream, continuation) = AsyncStream.makeStream(of: [CategoryGroupPlain].self, bufferingPolicy: .bufferingNewest(1))
    
    init(dao: CategoryGroupDao, mapper: CategoryGroupsMapperPlain) {
        self.dao = dao
        self.mapper = mapper
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
    
    func findCategoryGroup(by id: String) -> CategoryGroupPlain {
        let categoryGroupDb = dao.findCategoryGroup(by: id)
        return mapper.mapDbToPlain(categoryGroupDb: categoryGroupDb)
    }
    
    func findCategory(by id: String) -> CategoryPlain {
        let category = dao.findCategory(by: id)
        return mapper.mapDbToPlain(categoryDb: category)
    }
    
    func update(category: CategoryPlain) {
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
