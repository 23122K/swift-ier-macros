//
//  File.swift
//  
//
//  Created by Patryk Maciąg on 13/04/2024.
//

import SwiftSyntax

public extension Array where Array.Element == EnumDeclSyntax {
    func construct() -> [EnumSyntax] {
        self.compactMap { syntax in EnumSyntax(syntax) }
    }
}

public extension Array where Array.Element == EnumCaseDeclSyntax {
    func construct() -> [EnumCaseSyntax] {
        self.compactMap { syntax in EnumCaseSyntax(syntax) }
    }
}

public extension Array where Array.Element == ClassDeclSyntax {
    func construct() -> [ClassSyntax] {
        self.compactMap { syntax in ClassSyntax(syntax) }
    }
}

public extension Array where Array.Element == FunctionDeclSyntax {
    func construct() -> [FunctionSyntax] {
        self.compactMap { syntax in FunctionSyntax(syntax) }
    }
}

