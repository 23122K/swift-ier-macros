import SwiftSyntax

public typealias SwiftierVariable = Swiftier<VariableDeclSyntax>

enum SwiftierError: Error {
    case couldNotConstruct
}

extension Swiftier {
    enum `Defaults`: String {
        case name
        case specifier
        case type
    }
}

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
    static func make() -> Self {
        let syntax = Syntax(
            bindingSpecifier: .specifier(.let),
            bindings: [
                .binding(name: Defaults.name.rawValue, type: Defaults.type.rawValue)
            ]
        )
        
        return Self(syntax: syntax)
    }
    
    mutating func type(_ type: String) {
        let node = syntax.bindings.first!.index
        syntax.bindings[node] = .binding(type: type)
    }
    
    mutating func name(_ name: String) {
        let node = syntax.bindings.first!.index
        syntax.bindings[node] = .binding(name: name)
    }
    
    func construct() throws -> Self {
        if identifier == Defaults.name.rawValue {
            throw SwiftierError.couldNotConstruct
        }
        
        return self
    }
    
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
    
    static func binding(name: String) -> Self {
        Self(pattern: IdentifierPatternSyntax.identifier(name))
    }
    
    static func binding(type: String) -> Self {
        Self(pattern: IdentifierPatternSyntax.identifier("Chuj"), typeAnnotation: .type(type))
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
