//
//  CoverOverspendingFromEmptyView.swift
//  Budgetary
//
//  Created by Phillip Baker on 18/10/2024.
//

import SwiftUI

struct CoverOverspendingFromEmptyView: View {
    var searchText: String
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: searchText.isEmpty ? "envelope" : "magnifyingglass")
                .font(.largeTitle)
                .foregroundStyle(.secondary)
            
            VStack(spacing: 8) {
                Text(searchText.isEmpty ? "No categories" : "No categories with “\(searchText)”")
                    .font(.headline)
                Text(searchText.isEmpty ? "None of your categories have money available to cover overspending." : "None of your categories with money available match this search.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity)
        .multilineTextAlignment(.center)
        .listRowBackground(Color.clear)
        .padding()
    }
}

#Preview {
    CoverOverspendingFromEmptyView(searchText: "Rent")
}
