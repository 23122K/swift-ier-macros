//
//  File.swift
//  
//
//  Created by Patryk Maciąg on 11/04/2024.
//

import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct EnumSyntax: SyntaxRepresentable {
    public var syntax: EnumDeclSyntax
    public var name: String
    
    public var cases: [EnumCaseSyntax] {
        content
            .filter(for: EnumCaseDeclSyntax.self)
            .initialise
    }
    
    init(_ enumDeclSyntax: EnumDeclSyntax) {
        self.syntax = enumDeclSyntax
        self.name = syntax.name.text
    }
}
