//
//  File.swift
//  
//
//  Created by Patryk Maciąg on 17/04/2024.
//

import SwiftSyntax

public typealias SwiftierActor = Swiftier<ActorDeclSyntax>
public typealias SwiftierFunction = Swiftier<FunctionDeclSyntax>
public typealias SwiftierClass = Swiftier<ClassDeclSyntax>
public typealias SwiftierEnum = Swiftier<EnumDeclSyntax>
public typealias SwiftierStruct = Swiftier<StructDeclSyntax>

@frozen public struct Swiftier<Syntax> {
    public typealias Syntax = Syntax
    
    public let syntax: Syntax
    
    public init(syntax: Syntax) {
        self.syntax = syntax
    }
}

public extension Swiftier {
    @frozen struct SyntaxType {
        let `protocol`: ProtocolDeclSyntax.Type
        let `class`:    ClassDeclSyntax.Type
        let `actor`:    ActorDeclSyntax.Type
        let `struct`:   StructDeclSyntax.Type
        
        let `enum`:     EnumDeclSyntax.Type
        let `case`:     EnumCaseDeclSyntax.Type
        
        let `function`: FunctionDeclSyntax.Type
        let `parametr`: FunctionParameterSyntax.Type
    }
}
