//
//  View+Focus.swift
//  Budgetary
//
//  Created by Phillip Baker on 25/09/2024.
//

import SwiftUI

//extension View {
//    /// Mirror changes in the view model focused field to the view @FocusState property.
//    /// Mirror changes in the view @FocusState property to the view model focused field.
//    func bind(
//        _ focusState: FocusState<EditCategoriesViewModel.FocusedField?>.Binding,
//        to focus: Binding<EditCategoriesViewModel.FocusedField?>
//    ) -> some View {
//        self
//            .onChange(of: focus.wrappedValue) { _, newValue in
//                focusState.wrappedValue = newValue
//            }
//            .onChange(of: focusState.wrappedValue) { _, newValue in
//                focus.wrappedValue = newValue
//            }
//    }
//}
