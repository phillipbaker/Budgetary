//
//  CreditCardPaymentGroupPresentationPreviewData.swift
//  Budgetary
//
//  Created by Phillip Baker on 16/01/2026.
//

extension CreditCardPaymentGroupPresentation {
    static let mock = CreditCardPaymentGroupPresentation(
        id: .init(),
        name: "Credit Card Payments",
        isHidden: false,
        assignedTotal: [:],
        activityTotal: [:],
        availableTotal: [:],
        categories: [CreditCardRowPresentation(
            id: .init(),
            name: "Credit Card Payments",
            isHidden: false,
            assigned: [:],
            activity: [:],
            available: [:]
        )]
    )
}
