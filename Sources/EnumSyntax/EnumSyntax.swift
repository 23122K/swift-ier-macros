//
//  File.swift
//  
//
//  Created by Patryk Maciąg on 11/04/2024.
//

import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct EnumSyntax: SwifiterSyntax {
    public var syntax: EnumDeclSyntax
    public var name: String
    public var cases: [EnumCaseSyntax] {
        content
            .search(for: \.enumCaseSyntax)
            .construct()
    }
    
    public init(_ syntax: EnumDeclSyntax) {
        self.syntax = syntax
        self.name = syntax.name.text
    }
}
