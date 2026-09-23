//
//  HomeAction.swift
//  Budgetary
//
//  Created by Phillip Baker on 19/01/2026.
//

enum HomeAction {
    case tabSelected(AppTab)
    case newTransactionButtonTapped(AppTab)
    case sheetDismissed
    case push(AppTab, Destination)
    case pop(AppTab)
    case popToRoot(AppTab)
}

