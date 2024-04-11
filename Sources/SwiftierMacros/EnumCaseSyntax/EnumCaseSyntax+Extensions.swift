//
//  File.swift
//  
//
//  Created by Patryk Maciąg on 11/04/2024.
//

import SwiftSyntax

public extension Array where Array.Element == EnumCaseDeclSyntax {
    var initialise: [EnumCaseSyntax] {
        self.compactMap { syntax in
            try? EnumCaseSyntax(syntax: syntax)
        }
    }
}
