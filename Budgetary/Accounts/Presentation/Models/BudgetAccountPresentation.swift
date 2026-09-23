public struct BudgetAccountPresentation: Equatable, Hashable, Identifiable, Sendable {
    public let id: ID<BudgetAccountPresentation>
    let name: String
    let accountType: BudgetAccountTypePresentation
    let startingBalance: String
    let notes: String?
    let isClosed: Bool
    let balance: String
    let transactionsByDate: [TransactionDate]
}
