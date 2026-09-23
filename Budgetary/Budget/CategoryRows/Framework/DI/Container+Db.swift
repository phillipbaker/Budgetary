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

    var budgetDataSourceLocal: Factory<BudgetDataSourceLocal> {
        self { BudgetLocalDataGateway() }
            .singleton
    }
    
    var payeesDataSourceLocal: Factory<any PayeesDataSourceLocal> {
        self { PayeesLocalDataGateway() }
            .singleton
    }
    
    var budgetAccountsDataSourceLocal: Factory<any BudgetAccountsDataSourceLocal> {
        self { BudgetAccountsLocalDataGateway() }
            .singleton
    }
    
    var categoryGroupsDataSourceLocal: Factory<any CategoryGroupsDataSourceLocal> {
        self { CategoryGroupsLocalDataGateway() }
            .singleton
    }
    
    var creditCardPaymentGroupDataSourceLocal: Factory<any CreditCardPaymentGroupDataSourceLocal> {
        self { CreditCardPaymentGroupLocalDataGateway() }
    }
    
    var budgetAccountsMapperPlain: Factory<BudgetAccountsMapperPlain> {
        self { BudgetAccountsMapperPlain() }
            .singleton
    }
    
    var payeesMapperPlain: Factory<PayeesMapperPlain> {
        self { PayeesMapperPlain() }
            .singleton
    }
    
    var creditCardPaymentGroupMapperPlain: Factory<CreditCardPaymentGroupMapperPlain> {
        self { CreditCardPaymentGroupMapperPlain() }
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
    
    var creditCardPaymentGroupDao: Factory<CreditCardPaymentGroupDao> {
        self { CreditCardPaymentGroupDao(container: try! ModelContainer()) }
            .singleton
    }
}
