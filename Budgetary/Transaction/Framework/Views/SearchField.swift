//
//  SearchField.swift
//  Budgetary
//
//  Created by Phillip Baker on 11/06/2025.
//

import SwiftUI

struct SearchField: View {
    let title: String
    @Binding var searchText: String
    @FocusState var focused: Bool
    @State private var isEditing = false
    
    var body: some View {
        HStack(spacing: 10) {
            HStack(spacing: 4) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.secondary)
                
                ZStack(alignment: .leading) {
                    if searchText.isEmpty {
                        Text(title)
                            .foregroundStyle(.secondary)
                    }
                    
                    TextField("", text: $searchText)
                        .focused($focused)
                        .onTapGesture {
                            if !isEditing {
                                withAnimation(.easeInOut(duration: 0.25)) {
                                    isEditing = true
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                                    focused = true
                                }
                            }
                        }
                        .submitLabel(.search)
                        .autocorrectionDisabled()
                }
                
                if !searchText.isEmpty {
                    Button {
                        searchText = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(.systemBackground))
            )
            // Dynamically resize based on focus
            .frame(maxWidth: focused ? .infinity : .infinity, alignment: .leading)
            .transition(.opacity)
            .animation(.easeInOut(duration: 0.25), value: isEditing)
            
            
            if focused {
                Button("Cancel") {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        searchText = ""
                        focused = false
                        isEditing = false
                    }
                }
                .transition(.move(edge: .trailing).combined(with: .opacity))
                .animation(.easeInOut(duration: 0.25), value: isEditing)
            }
        }
        .padding(.horizontal)
        .padding(.bottom, 8)
        
        .onAppear {
            withAnimation {
                focused = true
            }
        }
    }
}


#Preview {
    SearchField(title: "", searchText: .constant(""))
}
