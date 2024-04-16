//
//  File.swift
//  
//
//  Created by Patryk Maciąg on 16/04/2024.
//

import SwiftSyntax

public struct FunctionSyntax {
    public var syntax: FunctionDeclSyntax
    public var name: String {
        syntax.name.text
    }
    
    public init(_ synax: FunctionDeclSyntax) {
        self.syntax = synax
    }
}


