//
//  File.swift
//  
//
//  Created by Patryk Maciąg on 11/04/2024.
//

import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public extension ClassSyntax {
    init(_ declGroupSyntax: DeclGroupSyntax) throws {
        guard let classDeclSyntax = declGroupSyntax.as(ClassDeclSyntax.self)
        else { throw SwiftierMacrosError.couldNotCastDeclaration }
        self.init(classDeclSyntax)
    }
    
    init?(_ declSyntax: DeclSyntax) throws {
        guard let classDeclSyntax = declSyntax.as(ClassDeclSyntax.self)
        else { throw SwiftierMacrosError.couldNotCastDeclaration }
        
        self.init(classDeclSyntax)
    }
}

enum SwiftierMacrosError: Error {
    case couldNotCastDeclaration
}
