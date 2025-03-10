//
//  BudgetaryApp.swift
//  Budgetary
//
//  Created by Phillip Baker on 07/08/2024.
//

import SwiftData
import SwiftUI

@main
struct BudgetaryApp: App {
    let budgetStateMapper = BudgetStateMapper(mapper: BudgetPresentationMapper())
    
    let categoryGroupsLocalDataGateway = CategoryGroupsLocalDataGateway(
        dao: CategoryGroupDao(
            container: try! ModelContainer(),
            mapper: CategoryGroupsMapperPlain()
        ),
        mapper: CategoryGroupsMapperPlain()
    )
    
    let budgetLocalDataGateway = BudgetLocalDatagateway(
        dao: BudgetDao(
            container: try! ModelContainer(),
            mapper: BudgetMapperPlain()
        ),
        mapper: BudgetMapperPlain()
    )
    
    let payessLocalDataGateway = PayeesLocalDataGateway(
        dao: PayeeDao(
            container: try! ModelContainer(),
            mapper: PayeesMapperPlain()),
        mapper: PayeesMapperPlain()
    )
    
    let budgetAccountsLocalDataGateway = BudgetAccountsLocalDataGateway(
        dao: BudgetAccountDao(
            container: try! ModelContainer(),
            mapper: BudgetAccountsMapperPlain()),
        mapper: BudgetAccountsMapperPlain()
    )
    
    let budgetMapper =  BudgetMapper()
    
    let combinedBudgetDataMapper = CombinedBudgetDataMapper()
    
    let homeViewModel = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView(
                budgetViewModel: BudgetViewModel(
                    stateMapper: budgetStateMapper,
                    getBudgetUseCase: GetBudget(
                        source: GetBudgetSourceCombined(
                            budgetDataSourceLocal: budgetLocalDataGateway,
                            payeesDataSourceLocal: payessLocalDataGateway,
                            budgetAccountsDataSourceLocal: budgetAccountsLocalDataGateway,
                            categoryGroupsDataSourceLocal: categoryGroupsLocalDataGateway,
                            mapper: combinedBudgetDataMapper
                        ),
                        mapper: budgetMapper
                    ),
                    assignMoneyUseCase: AssignMoney(
                        source: AssignMoneyDataSource(
                            categoryGroupsDataSourceLocal: categoryGroupsLocalDataGateway
                        ),
                        mapper: budgetMapper
                    )),
                model: homeViewModel
            )
        }
    }
}
