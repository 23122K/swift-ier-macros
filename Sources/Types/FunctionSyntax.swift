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
    
    public var parameters: [FunctionParameterSyntax] {
        syntax.swifitierParameters
    }
    
    public init(_ synax: FunctionDeclSyntax) {
        self.syntax = synax
    }
}

extension FunctionDeclSyntax {
    var swifitierParameters: [FunctionParameterSyntax] {
        self.signature.parameterClause.parameters
            .compactMap { parameter in
                parameter.as(FunctionParameterSyntax.self)
            }
    }
}

public extension FunctionParameterSyntax {
    public var swiftierLabel: String? {
        guard let label = self.secondName?.text
        else { return nil }
        
        return label
    }
    
    public var swiftierName: String {
        return self.firstName.text
    }
    
    public var swifiterType: String {
        return self.swiftierName
    }
}

extension OptionalTypeSyntax {
    var swifiterName: String? {
        self.wrappedType.as(IdentifierTypeSyntax.self)?.name.text
    }
}
