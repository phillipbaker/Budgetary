//
//  NumberPadView.swift
//  Budgetary
//
//  Created by Phillip Baker on 23/01/2025.
//

import SwiftUI

struct NumberPadView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    NumberPadView()
}

struct CustomKeyboardView: View {
    @Binding var text: String
    @FocusState.Binding var isActive: Bool
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(spacing: 0), count: 3), spacing: 15) {
            ForEach(1...9, id: \.self) { index in
                buttonView("\(index)")
            }
            
            buttonView("delete.backward.fill", isImage: true)
            buttonView("0")
            buttonView("checkmark.circle.fill", isImage: true)
        }
        .padding(15)
        .background(.background.shadow(.drop(color: .black.opacity(0.08), radius: 5, x: 0, y: -5)))
    }
    
    @ViewBuilder
    func buttonView(_ value: String, isImage: Bool = false) -> some View {
        Group {
            if isImage {
                Image(systemName: value)
            } else {
                Text(value)
            }
        }
        .font(.title3)
        .fontWeight(.semibold)
        .frame(width: 50, height: 50)
        .background {
            if !isImage {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.background.shadow(.drop(color: .black.opacity(0.08), radius: 3, x: 0, y: 0)))
            }
        }
        .foregroundStyle(Color.primary)
        .onTapGesture {
            if isImage {
                if value == "delete.backward.fill" && !text.isEmpty {
                    // Delete last character
                    text.removeLast()
                }
                
                if value == "checkmark.circle.fill" {
                    // Close keyboard
                    isActive = false
                }
            } else {
                text += value
            }
        }
        .onLongPressGesture {
            text = ""
        }
    }
}

//#Preview {
//    CustomKeyboardView(text: .constant(""), isActive: @FocusState = false)
//}
