//
//  CategoryGroupsLocalDataGateway.swift
//  Budgetary
//
//  Created by Phillip Baker on 05/11/2024.
//

import Factory

actor CategoryGroupsLocalDataGateway: CategoryGroupsDataSourceLocal {
    typealias CategoryGroupBroadcaster = StreamBroadcaster<[CategoryGroupPlain]>
    
    let dao: CategoryGroupDao = Container.shared.categoryGroupDao()
    let mapper: CategoryGroupsMapperPlain = Container.shared.categoryGroupsMapperPlain()
    
    private let _broadcaster = StreamBroadcaster<[CategoryGroupPlain]>(id: "CategoryGroupsLocalDataGateway")
    
    nonisolated var broadcaster: CategoryGroupBroadcaster {
        return _broadcaster
    }

    init() {
        Task { await startStreaming() }
    }
    
    private func startStreaming() async {
        for await categoryGroupsPlain in dao.streamCategoryGroups() {
            await _broadcaster.send(categoryGroupsPlain)
        }
    }
    
    func allCategoryGroups() -> [CategoryGroupPlain] {
        let categoryGroupsDb = dao.allCategoryGroups()
        return mapper.mapDbToPlain(categoryGroupsDb: categoryGroupsDb)
    }
    
    func findCategoryGroup(by id: String) -> CategoryGroupPlain? {
        guard let categoryGroupDb = dao.findCategoryGroup(by: id) else { return nil }
        return mapper.mapDbToPlain(categoryGroupDb: categoryGroupDb)
    }
    
    func findCategoryGroup(containing categoryId: String) async -> CategoryGroupPlain? {
        guard let categoryGroupDb = dao.findCategoryGroup(containing: categoryId) else { return nil }
        return mapper.mapDbToPlain(categoryGroupDb: categoryGroupDb)
    }
    
    func addNew(categoryGroup: CategoryGroupPlain) async {
        dao.create(categoryGroup: mapper.mapPlainToDb(categoryGroupPlain: categoryGroup))
    }

    func update(categoryGroup: CategoryGroupPlain) {
        dao.update(categoryGroup: mapper.mapPlainToDb(categoryGroupPlain: categoryGroup))
    }
    
    func update(categoryGroups: [CategoryGroupPlain]) async {
        dao.update(categoryGroups: mapper.mapPlainToDb(categoryGroupsPlain: categoryGroups))
    }
    
    func delete(categoryGroup: CategoryGroupPlain) {
        dao.delete(categoryGroup: mapper.mapPlainToDb(categoryGroupPlain: categoryGroup))
    }
}
