//
//  File.swift
//  
//
//  Created by Patryk Maciąg on 11/04/2024.
//

import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct ClassSyntax: SyntaxRepresentable {
    public var syntax: ClassDeclSyntax
    
    public var identifier: String {
        syntax.name.text
    }
    
    public var enums: [EnumSyntax] {
        content
            .filter(for: EnumDeclSyntax.self)
            .initialise
    }
    
    
    init(_ classDeclSyntax: ClassDeclSyntax) {
        self.syntax = classDeclSyntax
    }
}
