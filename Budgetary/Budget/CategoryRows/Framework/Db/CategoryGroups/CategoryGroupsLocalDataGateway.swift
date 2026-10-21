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

    func loadCategoryGroups() -> [CategoryGroupPlain] {
        let categoryGroupsDb = dao.loadCategoryGroups()
        return mapper.mapDbToPlain(categoryGroupsDb: categoryGroupsDb)
    }
    
    func findCategoryGroup(by id: ID<CategoryGroupPlain>) -> CategoryGroupPlain? {
        guard let categoryGroupDb = dao.findCategoryGroup(by: id.rawValue) else { return nil }
        return mapper.mapDbToPlain(categoryGroupDb: categoryGroupDb)
    }
    
    func findCategoryGroup(containing categoryID: ID<CategoryPlain>) -> CategoryGroupPlain? {
        guard let categoryGroupDb = dao.findCategoryGroup(containing: categoryID.rawValue) else { return nil }
        return mapper.mapDbToPlain(categoryGroupDb: categoryGroupDb)
    }
    
    func create(categoryGroup: CategoryGroupPlain) {
        dao.create(categoryGroup: mapper.mapPlainToDb(categoryGroupPlain: categoryGroup))
    }

    func update(categoryGroup: CategoryGroupPlain) {
        dao.update(categoryGroup: mapper.mapPlainToDb(categoryGroupPlain: categoryGroup))
    }
    
    func update(categoryGroups: [CategoryGroupPlain]) {
        dao.update(categoryGroups: mapper.mapPlainToDb(categoryGroupsPlain: categoryGroups))
    }
    
    func delete(categoryGroup: CategoryGroupPlain) {
        dao.delete(categoryGroup: mapper.mapPlainToDb(categoryGroupPlain: categoryGroup))
    }
}
