//
//  GetBudgetUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//

import Factory

public final class GetBudgetUseCase: Sendable {
    let source: GetBudgetSource = Container.shared.getBudgetSource()
    let mapper: BudgetMapper = Container.shared.budgetMapper()

    private let dataStore = BudgetDataStore()
    private let (combinedDataStream, continuation) = AsyncStream.makeStream(of: CombinedBudgetData.self)

    public init() {
        Task { await startStreaming() }
    }
    
    private func startStreaming() async {
        for await data in await source.budgetData() {
            await dataStore.update(with: data) // Store the latest data in the actor
            continuation.yield(data) // Push to stream
        }
        
        continuation.onTermination = { _ in
            // Handle cleanup if needed
        }
    }
    
    func budget(for monthYear: MonthYear, filteredBy filterId: String) -> AsyncStream<Budget> {
        let filter = CategoryFilter(rawValue: filterId) ?? .allCategories
        
        return AsyncStream { continuation in
            Task {
                // Get the latest data safely from the actor
                if let latestData = await dataStore.getLatestData() {
                    continuation.yield(mapper.mapBudget(for: monthYear, filteredBy: filter, from: latestData))
                    await dataStore.update(monthYear: monthYear)
                }
                
                // Listen for new updates in budget data stream
                for await data in combinedDataStream {
                    continuation.yield(await mapper.mapBudget(for: dataStore.getMonthYear(), filteredBy: filter, from: data))
                    await dataStore.update(with: data)
                }
            }
            
            continuation.onTermination = { _ in
                // Cleanup if necessary
            }
        }
    }
}

actor BudgetDataStore {
    private var latestData: CombinedBudgetData?
    private var monthYear: MonthYear?
    
    func update(monthYear: MonthYear) {
        self.monthYear = monthYear
    }
    
    func update(with data: CombinedBudgetData) {
        latestData = data
    }

    func getLatestData() -> CombinedBudgetData? {
        return latestData
    }
    
    func getMonthYear() -> MonthYear {
        return monthYear ?? .currentMonthYear
    }
}
