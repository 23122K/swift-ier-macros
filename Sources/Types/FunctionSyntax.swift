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
    
    public var parameters: [ParameterSyntax] {
        syntax.swifitierParameters.construct()
    }
    
    public init(_ synax: FunctionDeclSyntax) {
        self.syntax = synax
    }
}


public enum ParameterSyntax {
    case parameters(label: String, name: String)
    case parameter(name: String)
}

extension Array where Array.Element ==  FunctionParameterSyntax {
    func construct() -> [ParameterSyntax] {
        self.compactMap { syntax in
            guard let secondName = syntax.secondName else {
                return .parameter(name: syntax.firstName.text)
            }
            
            return .parameters(label: syntax.firstName.text, name: secondName.text)
        }
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

