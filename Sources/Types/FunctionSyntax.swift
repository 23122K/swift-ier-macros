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
    
    var swiftierType: String? {
        let swiftierTypeSyntax = Swiftier(syntax: self.type.as(OptionalTypeSyntax.self)!)
        return swiftierTypeSyntax.type
    }
}

@frozen public struct Swiftier<Syntax> {
    typealias Syntax = Syntax
    
    internal let syntax: Syntax
    
    public init(syntax: Syntax) {
        self.syntax = syntax
    }
}

extension Swiftier where Swiftier.Syntax == OptionalTypeSyntax {
    var type: String? {
        guard let type = syntax.wrappedType.as(IdentifierTypeSyntax.self)?.name.text else {
            return nil
        }
        
        return type
    }
}

enum SwiftierError {
    case funcShouldHaveAType
}

