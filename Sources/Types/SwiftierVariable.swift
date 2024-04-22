import SwiftSyntax

public typealias SwiftierVariable = Swiftier<VariableDeclSyntax>

public extension SwiftierVariable {
    var specifier: String { syntax.bindingSpecifier.text }
    var identifier: String? { syntax.bindings.indentifier() }
    var type: String? { syntax.bindings.type() }
}

extension PatternBindingListSyntax {
    func indentifier() -> String? {
        self.first?.indentifier()
    }
    
    func type() -> String? {
        self.first?.type()
    }
}

public extension SwiftierVariable {
    init(specifier keyword: Keyword, identifer name: String, type: String) {
        let syntax = Syntax(
            bindingSpecifier: .specifier(keyword),
            bindings: [
                .binding(name: name, type: type)
            ]
        )
        
        self.init(syntax: syntax)
    }
}

extension PatternBindingSyntax {
    static func binding(name: String, type: String) -> Self {
        return PatternBindingSyntax(
            pattern: IdentifierPatternSyntax.identifier(name),
            typeAnnotation: TypeAnnotationSyntax.type(type)
        )
    }
    
    func indentifier() -> String? {
        IdentifierTypeSyntax(self)?.name.text
    }
    
    func type() -> String? {
        let typeAnnotation = TypeAnnotationSyntax(self)
        let type = IdentifierTypeSyntax(typeAnnotation)
        return type?.name.text
    }
}

extension DeclModifierSyntax {
    static func modifier(_ modifier: TokenSyntax) -> Self {
        DeclModifierSyntax(name: modifier)
    }
}

//TODO: NA chama wjebałem INT'a
extension InitializerClauseSyntax {
    static func initialise(with value: String) -> Self {
        InitializerClauseSyntax(value: IntegerLiteralExprSyntax(literal: .integerLiteral(value)))
    }
}

///Defines Variable `name` eg. `let foo: Int` where `foo` is a` name`
extension IdentifierPatternSyntax {
    static func identifier(_ stringValue: String) -> Self {
        IdentifierPatternSyntax(identifier: .token(.identifier(stringValue)))
    }
}

///Defines Variable `Type` eg. `let foo: Int` where `Int` is a  Type``
extension IdentifierTypeSyntax {
    static func identifier(_ stringValue: String) -> Self {
        IdentifierTypeSyntax(name: .identifier(stringValue))
    }
}

extension TypeAnnotationSyntax {
    static func type(_ stringValue: String) -> Self {
        TypeAnnotationSyntax(type: IdentifierTypeSyntax.identifier(stringValue))
    }
}


extension TokenSyntax {
    static let `let`: TokenSyntax = .token(.keyword(.let))
    static let `static`: TokenSyntax = .token(.keyword(.static))
    static func token(_ token: TokenKind) -> Self {
        TokenSyntax(token, presence: .present)
    }
    
    static func specifier(_ keyword: Keyword) -> TokenSyntax {
        .token(.keyword(keyword))
    }
}
