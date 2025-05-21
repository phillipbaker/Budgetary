//
//  Container+DataGateways.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/05/2025.
//

import Factory
import SwiftData

extension Container {    
    
    // MARK: Data Gateways
    
    var streamBroadcaster: Factory<StreamBroadcaster<Sendable>> {
        self { StreamBroadcaster(id: "Test") }
            .singleton
    }

    var budgetDataSourceLocal: Factory<BudgetDataSourceLocal> {
        self { BudgetLocalDatagateway() }
            .singleton
    }
    
    var payeesDataSourceLocal: Factory<PayeesDataSourceLocal> {
        self { PayeesLocalDataGateway() }
            .singleton
    }
    
    var budgetAccountsDataSourceLocal: Factory<BudgetAccountsDataSourceLocal> {
        self { BudgetAccountsLocalDataGateway() }
            .singleton
    }
    
    var categoryGroupsDataSourceLocal: Factory<any CategoryGroupsDataSourceLocal> {
        self { CategoryGroupsLocalDataGateway() }
            .singleton
    }
    
    var budgetAccountsMapperPlain: Factory<BudgetAccountsMapperPlain> {
        self { BudgetAccountsMapperPlain() }
            .singleton
    }
    
    var payeesMapperPlain: Factory<PayeesMapperPlain> {
        self { PayeesMapperPlain() }
            .singleton
    }
    
    // MARK: DAOs
    
    var budgetDao: Factory<BudgetDao> {
        self { BudgetDao(container: try! ModelContainer()) }
            .singleton
    }
    
    var categoryGroupDao: Factory<CategoryGroupDao> {
        self { CategoryGroupDao(container: try! ModelContainer()) }
            .singleton
    }
    
    var payeeDao: Factory<PayeeDao> {
        self { PayeeDao(container: try! ModelContainer()) }
            .singleton
    }
    
    var budgetAccountDao: Factory<BudgetAccountDao> {
        self { BudgetAccountDao(container: try! ModelContainer()) }
            .singleton
    }
}
