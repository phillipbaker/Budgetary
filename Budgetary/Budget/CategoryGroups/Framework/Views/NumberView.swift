//
//  NumberView.swift
//  Budgetary
//
//  Created by Phillip Baker on 10/09/2024.
//

import SwiftUI

struct NumberView: View {
    let number: String
    
    var body: some View {
        Text("£9,999,999.99")
            .foregroundStyle(.red)
            .hidden()
            .overlay(alignment: .trailing) {
                Text(number)
            }
            .frame(minWidth: 112, alignment: .trailing)
            .font(.subheadline)
    }
}
