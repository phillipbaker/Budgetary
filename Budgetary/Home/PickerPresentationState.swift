//
//  PickerPresentationState.swift
//  Budgetary
//
//  Created by Phillip Baker on 05/02/2026.
//

public enum PickerStatePresentation: Equatable, Hashable, Sendable {
    case categoryPicker
    case payeePicker
    case accountPicker
}

public enum CategoryGroupRowsStatePresentation: Equatable, Hashable, Sendable {
    case notLoaded
    case loading
    case error
    case loaded([CategoryNamePresentation])
}

public enum CategoryGroupPickerStatePresentation: Equatable, Hashable, Sendable {
    case notLoaded
    case loading
    case error
    case loaded([CategoryGroupNamePresentation])
}

public enum PayeesStatePresentation: Equatable, Hashable, Sendable {
    case notLoaded
    case loading
    case error
    case loaded(PayeePickerDataPresentation)
}

public enum AccountPickerStatePresentation: Equatable, Hashable, Sendable {
    case notLoaded
    case loading
    case error
    case loaded([TransactionAccountPresentation])
}
