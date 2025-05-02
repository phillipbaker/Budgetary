//
//  EditableCategoryPresentation.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/03/2025.
//

import Foundation
import CoreTransferable
import UniformTypeIdentifiers

public struct EditableCategoryPresentation: Equatable, Identifiable, Sendable {
    public let id: String
    let name: String
}

extension EditableCategoryPresentation: Codable, Transferable {
    public static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .editableCategoryPresentation)
        ProxyRepresentation(exporting: \.name)
    }
}

extension UTType {
    static let editableCategoryPresentation = UTType(
        "com.phillipbaker.Budgetary.EditableCategoryPresentation"
    )!
}
