//
//  KeypadView.swift
//  Budgetary
//
//  Created by Phillip Baker on 06/01/2025.
//

import SwiftUI

struct KeypadView: View {
    @State var assigned = 0.00
    
    var body: some View {
        Grid(verticalSpacing: 16) {
            GridRow {
                Button {
                    
                } label: {
                    DetailButtonLabel(
                        label: "Assign",
                        systemImage: "banknote"
                    )
                }
                
                Button {
                    
                } label: {
                    DetailButtonLabel(
                        label: "Auto-Assign",
                        systemImage: "bolt.fill"
                    )
                }
                
                Button {
                    
                } label: {
                    DetailButtonLabel(
                        label: "Move Money",
                        systemImage: "arrowshape.right.fill"
                    )
                }
                
                Button {
                    
                } label: {
                    DetailButtonLabel(
                        label: "Details",
                        systemImage: "ellipsis"
                    )
                }
            }
            
            GridRow {
                Button("7") {
                    
                }
                .font(.title3)
                .tint(.primary)
                
                Button("8") {
                    
                }
                .font(.title3)
                .tint(.primary)
                
                Button("9") {
                    
                }
                .font(.title3)
                .tint(.primary)
                
                Button("-") {
                    
                }
                .font(.title)
            }
            
            GridRow {
                Button("4") {
                    
                }
                .font(.title3)
                .tint(.primary)
                
                Button("5") {
                    
                }
                .font(.title3)
                .tint(.primary)
                
                Button("6") {
                    
                }
                .font(.title3)
                .tint(.primary)
                
                Button("+") {
                    
                }
                .font(.title)
            }
            
            GridRow {
                Button("1") {
                    
                }
                .font(.title3)
                .tint(.primary)
                
                Button("2") {
                    
                }
                .font(.title3)
                .tint(.primary)
                
                Button("3") {
                    
                }
                .font(.title3)
                .tint(.primary)
                
                Button("=") {
                    
                }
                .font(.title)
            }
            
            GridRow {
                Button {

                } label: {
                    Image(systemName: "x.circle.fill")
                        .tint(.secondary.opacity(0.8))
                }
                
                Button("0") {
                    
                }
                .font(.title3)
                .tint(.primary)
                
                Button {
                    
                } label: {
                    Image(systemName: "delete.left")
                        .tint(.primary)
                }
                
                Button("Done") {
                    
                }
                .font(.subheadline)
                .fontWeight(.semibold)
                .buttonStyle(.borderedProminent)
            }
        }
        
    }
}

#Preview {
    KeypadView()
}

struct DetailButtonLabel: View {
    let label: String
    let systemImage: String
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: systemImage)
                .frame(minWidth: 28, minHeight: 24)
                .padding(.vertical, 4)
                .padding(.horizontal, 24)
                .background(.secondary.opacity(0.15))
                .tint(.secondary)
                .clipShape(RoundedRectangle(cornerRadius: 8))

            Text(label)
                .font(.caption2)
                .tint(.secondary)
        }
    }
}
