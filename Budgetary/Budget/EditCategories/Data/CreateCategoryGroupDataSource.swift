//
//  CreateCategoryGroupDataSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 03/04/2025.
//

import Factory

final class CreateCategoryGroupDataSource: CreateCategoryGroupSource {
    let categoryGroupsDataSourceLocal: any CategoryGroupsDataSourceLocal = Container.shared.categoryGroupsDataSourceLocal()

    func create(categoryGroup: CategoryGroupPlain) async {
        await categoryGroupsDataSourceLocal.create(categoryGroup: categoryGroup)
    }
}
