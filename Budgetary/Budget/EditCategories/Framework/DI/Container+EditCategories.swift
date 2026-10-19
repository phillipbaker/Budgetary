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
    
    var createCategoryGroupUseCase: Factory<CreateCategoryGroupUseCase> {
        self { CreateCategoryGroupUseCase()}
            .singleton
    }
    
    var createCategoryGroupSource: Factory<CreateCategoryGroupSource> {
        self { CreateCategoryGroupDataSource() }
            .singleton
    }
    
    var createCategoryUseCase: Factory<CreateCategoryUseCase> {
        self { CreateCategoryUseCase() }
            .singleton
    }
    
    public var createCategorySource: Factory<CreateCategorySource> {
        self { CreateCategoryDataSource() }
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
    
    var renameCategoryGroupUseCase: Factory<RenameCategoryGroupUseCase> {
        self { RenameCategoryGroupUseCase() }
            .singleton
    }
    
    var renameCategoryGroupSource: Factory<RenameCategoryGroupSource> {
        self { RenameCategoryGroupDataSource() }
            .singleton
    }
    
    var deleteCategoryUseCase: Factory<DeleteCategoryUseCase> {
        self { DeleteCategoryUseCase() }
            .singleton
    }
    
    var deleteCategorySource: Factory<DeleteCategorySource> {
        self { DeleteCategoryDataSource() }
            .singleton
    }
    
    var deleteCategoryGroupUseCase: Factory<DeleteCategoryGroupUseCase> {
        self { DeleteCategoryGroupUseCase() }
            .singleton
    }
    
    var deleteCategoryGroupSource: Factory<DeleteCategoryGroupSource> {
        self { DeleteCategoryGroupDataSource() }
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
