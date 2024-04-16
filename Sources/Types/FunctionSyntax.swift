//
//  File.swift
//  
//
//  Created by Patryk Maciąg on 16/04/2024.
//

import SwiftSyntax

extension FunctionDeclSyntax {
    var swifitierParameters: [FunctionParameterSyntax] {
        self.signature.parameterClause.parameters
            .compactMap { parameter in
                parameter.as(FunctionParameterSyntax.self)
            }
    }
}

@frozen public struct Swiftier<Syntax> {
    public typealias Syntax = Syntax
    
    public let syntax: Syntax
    
    public init(syntax: Syntax) {
        self.syntax = syntax
    }
}

public extension Swiftier where Swiftier.Syntax == OptionalTypeSyntax {
    var type: String? {
        guard let type = syntax.wrappedType.as(IdentifierTypeSyntax.self)?.name.text else {
            return nil
        }
        
        return type
    }
}

public extension Swiftier where Swiftier.Syntax == FunctionDeclSyntax {
    var name: String {
        syntax.name.text
    }
    
    var parametes: [FunctionParameterSyntax] {
        syntax.swifitierParameters
    }
}

public extension Swiftier where Swiftier.Syntax == FunctionParameterSyntax {
    var label: String? {
        syntax.secondName?.text ?? nil
    }
    
    var name: String {
        syntax.firstName.text
    }
}
