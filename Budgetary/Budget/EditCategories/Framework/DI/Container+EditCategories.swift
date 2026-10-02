//
//  Container+EditCategories.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/05/2025.
//

import Factory

extension Container {
    
    // MARK: Coordinator
    
    var editCategoriesCoordinator: Factory<EditCategoriesCoordinator> {
        self { EditCategoriesCoordinator() }
            .singleton
    }
    
    // MARK: View Model

    @MainActor
    var editCategoriesViewModel: Factory<EditCategoriesViewModel> {
        self { @MainActor in EditCategoriesViewModel() }
            .singleton
    }
    
    // MARK: Mappers
    
    var editCategoriesMapper: Factory<EditCategoriesMapper> {
        self { EditCategoriesMapper() }
            .singleton
    }
    
    var editCategoriesStateMapper: Factory<EditCategoriesStateMapper> {
        self { EditCategoriesStateMapper() }
            .singleton
    }
    
    var editCategoriesPresentationMapper: Factory<EditCategoriesPresentationMapper> {
        self { EditCategoriesPresentationMapper() }
            .singleton
    }
    
    // MARK: Use Cases & Date Sources
    
    var loadCategoryGroupsSource: Factory<LoadCategoryGroupsSource> {
        self { LoadCategoryGroupsDataSource() }
            .singleton
    }
    
    var newGroupUseCase: Factory<NewGroupUseCase> {
        self { NewGroupUseCase()}
            .singleton
    }
    
    var newGroupSource: Factory<NewGroupSource> {
        self { NewGroupDataSource() }
            .singleton
    }
    
    var newCategoryUseCase: Factory<NewCategoryUseCase> {
        self { NewCategoryUseCase() }
            .singleton
    }
    
    public var newCategorySource: Factory<NewCategorySource> {
        self { NewCategoryDataSource() }
            .singleton
    }
    
    var renameCategoryUseCase: Factory<RenameCategoryUseCase> {
        self { RenameCategoryUseCase() }
            .singleton
    }
    
    var renameCategorySource: Factory<RenameCategorySource> {
        self { RenameCategoryDataSource() }
            .singleton
    }
    
    var renameGroupUseCase: Factory<RenameGroupUseCase> {
        self { RenameGroupUseCase() }
            .singleton
    }
    
    var renameGroupSource: Factory<RenameGroupSource> {
        self { RenameGroupDataSource() }
            .singleton
    }
    
    var removeCategoryUseCase: Factory<RemoveCategoryUseCase> {
        self { RemoveCategoryUseCase() }
            .singleton
    }
    
    var removeCategorySource: Factory<RemoveCategorySource> {
        self { RemoveCategoryDataSource() }
            .singleton
    }
    
    var removeGroupUseCase: Factory<RemoveGroupUseCase> {
        self { RemoveGroupUseCase() }
            .singleton
    }
    
    var removeGroupSource: Factory<RemoveGroupSource> {
        self { RemoveGroupDataSource() }
            .singleton
    }
    
    var hideCategoryUseCase: Factory<HideCategoryUseCase> {
        self { HideCategoryUseCase() }
            .singleton
    }
    
    var hideCategorySource: Factory<HideCategorySource> {
        self { HideCategoryDataSource() }
            .singleton
    }
    
    var hideCategoryGroupSource: Factory<HideCategoryGroupSource> {
        self { HideCategoryGroupDataSource() }
            .singleton
    }
    
    var moveCategoryGroupUseCase: Factory<MoveCategoryGroupUseCase> {
        self { MoveCategoryGroupUseCase() }
            .singleton
    }
    
    var moveCategoryGroupSource: Factory<MoveCategoryGroupSource> {
        self { MoveCategoryGroupDataSource() }
            .singleton
    }
    
    var moveCategoryUseCase: Factory<MoveCategoryUseCase> {
        self { MoveCategoryUseCase() }
            .singleton
    }
    
    var moveCategorySource: Factory<MoveCategorySource> {
        self { MoveCategoryDataSource() }
            .singleton
    }
}
