//
//  StreamBroadcaster.swift
//  Budgetary
//
//  Created by Phillip Baker on 05/04/2025.
//

import Foundation

public actor StreamBroadcaster<T> where T: Sendable {
    private var continuations: [UUID: AsyncStream<T>.Continuation] = [:]
    private var latestValue: T? = nil  // Store the latest value
    
    let id: String
    
    init(id: String) {
        self.id = id
    }

    func subscribe() -> AsyncStream<T> {
        AsyncStream { continuation in
            let id = UUID()
            
            // Store the continuation
            continuations[id] = continuation
            
            // Send the latest value to the new subscriber (if it exists)
            if let value = latestValue {
                continuation.yield(value)  // Send the most recent value to the new subscriber
            }

            continuation.onTermination = { _ in
                Task { await self.removeContinuation(id) }
            }
        }
    }

    func send(_ value: T) {
        // Store the most recent value
        latestValue = value
        
        // Send the value to all active continuations
        for continuation in continuations.values {
            continuation.yield(value)
        }
    }

    private func removeContinuation(_ id: UUID) {
        continuations.removeValue(forKey: id)
    }
}
