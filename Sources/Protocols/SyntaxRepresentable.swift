//
//  File.swift
//  
//
//  Created by Patryk Maciąg on 11/04/2024.
//

import SwiftSyntax

public protocol SwiftierSyntax {
    associatedtype S: DeclGroupSyntax
    
    var syntax: S { get set }
    
    init(_ synax: S)
}

extension SwiftierSyntax {
    internal var content: MemberBlockItemListSyntax {
        self.syntax.memberBlock.members
    }
}

public struct SwiftierSyntaxType {
    let classSyntax: ClassDeclSyntax.Type
    let enumSyntax: EnumDeclSyntax.Type
    let enumCaseSyntax: EnumCaseDeclSyntax.Type
    let functionSyntax: FunctionDeclSyntax.Type
}

public extension SwiftierSyntax {
    init?(_ syntax: DeclSyntax) {
        guard let syntax = syntax.as(S.self)
        else { return nil }
        
        self.init(syntax)
    }
    
    init?(_ syntax: DeclGroupSyntax) {
        guard let syntax = syntax.as(S.self)
        else { return nil }
        
        self.init(syntax)
    }
}
