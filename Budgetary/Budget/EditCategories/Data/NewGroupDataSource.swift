//
//  NewGroupDataSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 03/04/2025.
//

import Factory

final class NewGroupDataSource: NewGroupSource {
    let categoryGroupsDataSourceLocal: any CategoryGroupsDataSourceLocal = Container.shared.categoryGroupsDataSourceLocal()

    func addNew(categoryGroup: CategoryGroupPlain) async {
        await categoryGroupsDataSourceLocal.create(categoryGroup: categoryGroup)
    }
}
