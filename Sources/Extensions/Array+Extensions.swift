//
//  File.swift
//  
//
//  Created by Patryk Maciąg on 13/04/2024.
//

import SwiftSyntax

public extension Array where Array.Element: SyntaxProtocol {
    func construct() -> [Swiftier<Element>] {
        self.compactMap { syntax in
            Swiftier(syntax: syntax)
        }
    }
}
