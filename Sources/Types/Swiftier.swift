//
//  File.swift
//  
//
//  Created by Patryk Maciąg on 17/04/2024.
//

import SwiftSyntax

@frozen public struct Swiftier<Syntax> {
    public typealias Syntax = Syntax
    
    public let syntax: Syntax
    
    public init(syntax: Syntax) {
        self.syntax = syntax
    }
}

public extension Swiftier {
    typealias SwiftierActor = Swiftier<ActorDeclSyntax>
    typealias SwiftierFunction = Swiftier<FunctionDeclSyntax>
    typealias SwiftierClass = Swiftier<ClassDeclSyntax>
    typealias SwiftierEnum = Swiftier<EnumDeclSyntax>
    typealias SwiftierStruct = Swiftier<StructDeclSyntax>
    
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
