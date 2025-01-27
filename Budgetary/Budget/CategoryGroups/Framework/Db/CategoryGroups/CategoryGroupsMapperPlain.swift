//
//  CategoryGroupsMapperPlain.swift
//  Budgetary
//
//  Created by Phillip Baker on 05/11/2024.
//

class CategoryGroupsMapperPlain {
    func mapDbToPlain(categoryGroupsDb: [CategoryGroupDb]) -> [CategoryGroupPlain] {
        return categoryGroupsDb.map { categoryGroupDb in
            mapDbToPlain(categoryGroupDb: categoryGroupDb)
        }
    }
    
    func mapDbToPlain(categoryGroupDb: CategoryGroupDb) -> CategoryGroupPlain {
        return CategoryGroupPlain(
            id: categoryGroupDb.id,
            name: categoryGroupDb.name,
            isHidden: categoryGroupDb.isHidden,
            categories: mapDbToPlain(categoriesDb: categoryGroupDb.categories)
        )
    }
    
    func mapDbToPlain(categoriesDb: [CategoryDb]) -> [CategoryPlain] {
        return categoriesDb.map { categoryDb in
            mapDbToPlain(categoryDb: categoryDb)
        }
    }
    
    func mapDbToPlain(categoryDb: CategoryDb) -> CategoryPlain {
        return CategoryPlain(
            id: categoryDb.id,
            name: categoryDb.name,
            notes: categoryDb.notes,
            isHidden: categoryDb.isHidden,
            assigned: categoryDb.assigned
        )
    }
    
    func mapPlainToDb(categoryGroupsPlain: [CategoryGroupPlain]) -> [CategoryGroupDb] {
        return categoryGroupsPlain.map { categoryGroupPlain in
                mapPlainToDb(categoryGroupPlain: categoryGroupPlain)
        }
    }
    
    func mapPlainToDb(categoryGroupPlain: CategoryGroupPlain) -> CategoryGroupDb {
        return CategoryGroupDb(
            id: categoryGroupPlain.id,
            name: categoryGroupPlain.name,
            isHidden: categoryGroupPlain.isHidden,
            categories: mapPlainToDb(categoriePlain: categoryGroupPlain.categories)
        )
    }
    
    func mapPlainToDb(categoriePlain: [CategoryPlain]) -> [CategoryDb] {
        return categoriePlain.map { categoryPlain in
            mapPlainToDb(categoryPlain: categoryPlain)
        }
    }
    
    func mapPlainToDb(categoryPlain: CategoryPlain) -> CategoryDb {
        return CategoryDb(
            id: categoryPlain.id,
            name: categoryPlain.name,
            notes: categoryPlain.notes,
            isHidden: categoryPlain.isHidden,
            assigned: categoryPlain.assigned
        )
    }
}
