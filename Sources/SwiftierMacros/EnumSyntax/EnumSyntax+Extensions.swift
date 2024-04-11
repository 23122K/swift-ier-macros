//
//  File.swift
//  
//
//  Created by Patryk Maciąg on 11/04/2024.
//

import SwiftSyntax

public extension Array where Array.Element == EnumDeclSyntax {
    var initialise: [EnumSyntax] {
        self.compactMap { enumDeclSyntax in
            EnumSyntax(enumDeclSyntax)
        }
    }
}
