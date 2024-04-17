import SwiftSyntax

@frozen public struct Swiftier<Syntax> {
    public typealias Syntax = Syntax
    
    public let syntax: Syntax
    
    public init(syntax: Syntax) {
        self.syntax = syntax
    }
}

public extension Swiftier {
    @frozen struct `Type` {
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
