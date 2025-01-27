//
//  CategoryGroupsMapperPlain.swift
//  Budgetary
//
//  Created by Phillip Baker on 05/11/2024.
//

import Dependencies

class CategoryGroupsLocalDataGateway: CategoryGroupsDataSourceLocal {
    var dao: CategoryGroupDao
    var mapper: CategoryGroupsMapperPlain
    
    init(dao: CategoryGroupDao, mapper: CategoryGroupsMapperPlain) {
        self.dao = dao
        self.mapper = mapper
    }
    
    func categoryGroupsStream() async -> AsyncStream<[CategoryGroupPlain]> {
        let (stream, continuation) = AsyncStream.makeStream(of: [CategoryGroupPlain].self)
        for await categoryGroupsPlain in await dao.streamCategoryGroups() {
//            let categoryGroupsPlain = categoryGroupsDb.map { categoryGroupDb in
//                self.mapper.mapDbToPlain(categoryGroupDb: categoryGroupDb)
//            }
            continuation.yield(categoryGroupsPlain)
            return stream
        }
        continuation.finish()
        return stream
    }
    
    func findCategoryGroup(by id: String) -> CategoryGroupPlain {
        let categoryGroupDb = dao.findCategoryGroup(by: id)
        return mapper.mapDbToPlain(categoryGroupDb: categoryGroupDb)
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
