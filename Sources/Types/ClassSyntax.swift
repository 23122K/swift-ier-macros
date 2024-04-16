//
//  File.swift
//  
//
//  Created by Patryk Maciąg on 11/04/2024.
//

import SwiftSyntax

public struct ClassSyntax: SwiftierSyntax {    
    public var syntax: ClassDeclSyntax
    public var identifier: String {
        syntax.name.text
    }
    
    public var functions: [FunctionDeclSyntax] {
        content
            .search(for: \.functionSyntax)
    }
    
    
    public var enums: [EnumSyntax] {
        content
            .search(for: \.enumSyntax)
            .construct()
    }
    
    public init(_ syntax: ClassDeclSyntax) {
        self.syntax = syntax
    }
}
