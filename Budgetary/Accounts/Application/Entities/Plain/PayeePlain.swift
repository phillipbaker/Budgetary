//
//  PayeePlain.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//

public struct PayeePlain: Equatable, Sendable {
    let id: String
    let name: String
    let aliases: [String]
    let includedInPayeeList: Bool
    let automaticallyCategorizeIsOn: Bool
    let defaultCategoryId: String
}
