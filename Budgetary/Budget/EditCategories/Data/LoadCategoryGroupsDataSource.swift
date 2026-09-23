//
//  LoadCategoryGroupsDataSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 03/04/2025.
//

import Factory

final class LoadCategoryGroupsDataSource: LoadCategoryGroupsSource {
    let categoryGroupsDataSourceLocal: any CategoryGroupsDataSourceLocal
    
    init(categoryGroupsDataSourceLocal: any CategoryGroupsDataSourceLocal = Container.shared.categoryGroupsDataSourceLocal()) {
        self.categoryGroupsDataSourceLocal = categoryGroupsDataSourceLocal
    }
    
    let (categoryGroupsStream, continuation) = AsyncStream.makeStream(of: [CategoryGroupPlain].self, bufferingPolicy: .bufferingNewest(1))
    
    let id = "LoadCategoryGroupsDataSource"
    
//    public init() {
//        Task {
////            for await categoryGroups in await categoryGroupsDataSourceLocal.broadcaster.subscribe() {
////                continuation.yield(categoryGroups)
////            }
////            for await categoryGroups in await categoryGroupsDataSourceLocal.categoryGroupsStream() {
////                print("load categories data source await gateway:", categoryGroups)
////                continuation.yield(categoryGroups)
////            }
////            
////            continuation.onTermination = { @Sendable reason in
////                // Handle any necessary cleanup
////                print("categoryGroupsStream terminated with reason: ", reason)
////            }
//        }
//    }
    
    func loadCategoryGroups() async -> [CategoryGroupPlain] {
        await categoryGroupsDataSourceLocal.categoryGroups()
    }

    func categoryGroupsStream() async -> AsyncStream<[CategoryGroupPlain]> {
        return categoryGroupsStream
    }
}

//class Listener {
//    let id: String
//
//    init(id: String) {
//        self.id = id
//    }
//
//    func startListening() {
//        Task {
//            for await value in await broadcaster.subscribe() {
//                print("Listener \(id) received: \(value)")
//            }
//        }
//    }
//}
