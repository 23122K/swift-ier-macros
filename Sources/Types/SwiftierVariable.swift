import SwiftSyntax

public typealias SwiftierVariable = Swiftier<VariableDeclSyntax>

enum SwiftierError: Error {
    case couldNotConstruct
}

extension Swiftier<VariableDeclSyntax> {
    struct `Defaults` {
        static let identifier: String = "example"
        static let specifier: Keyword = .let
        static let type: String = "Int"
        
        private init() { }
    }
}

extension PatternBindingListSyntax {
    func indentifier() -> String? {
        self.first?.indentifier()
    }
    
    func type() -> String? {
        self.first?.type()
    }
}

public extension Swiftier.Variable {
    func construct(_ variable: (inout Self) -> Void) -> Self {
        var value: Self = self
        variable(&value)
        return value
    }
}

public extension Swiftier<VariableDeclSyntax> {
    struct Variable {
        public var identifier: String
        public var specifier: Keyword
        public var type: String
        public var value: String?
        public var attribute: String?
        public var modifiers: [String]?
        
        public static func initiate() -> Self {
            self.init(
                identifier: Defaults.identifier,
                specifier: Defaults.specifier,
                type: Defaults.type
            )
        }
        
        init(identifier: String, specifier: Keyword, type: String) {
            self.identifier = identifier
            self.specifier = specifier
            self.type = type
        }
        
        public func syntax() -> VariableDeclSyntax {
            return .init(
                attributes: [
                    .attribute(
                        AttributeSyntax.construct(with: attribute!)
                    )
                ],
                modifiers: [
                    .construct(with: modifiers!.first!)
                ],
                bindingSpecifier: .specifier(specifier),
                bindings: [
                    .construct(identifier: identifier, type: type, default: value)
                ]
            )
        }
        
        public func swiftier() -> Swiftier<Syntax> {
            let syntax = syntax()
            return .init(syntax: syntax)
        }
    }
}

extension DeclModifierSyntax {
    static func construct(with modifier: String) -> Self {
        DeclModifierSyntax(
            name: .token(
                .identifier(modifier)
            ),
            detail: nil
        )
    }
}

extension AttributeSyntax {
    static func construct(with attribute: String) -> Self {
        AttributeSyntax(
            atSign: .token(.atSign),
            attributeName: IdentifierTypeSyntax(
                name: .identifier(attribute)
            ),
            trailingTrivia: .newline
        )
    }
}

extension PatternBindingSyntax {
    static func construct(identifier name: String, type: String, default value: String?) -> Self {
        return PatternBindingSyntax(
            pattern: IdentifierPatternSyntax.construct(with: name),
            typeAnnotation: TypeAnnotationSyntax.construct(with: type),
            initializer: InitializerClauseSyntax.construct(with: value),
            accessorBlock: nil
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

extension PatternSyntaxProtocol {
    static func construct(with name: String) -> IdentifierPatternSyntax {
        return IdentifierPatternSyntax(identifier: .token(.identifier(name)))
    }
}

extension DeclModifierSyntax {
    static func modifier(_ modifier: TokenSyntax) -> Self {
        DeclModifierSyntax(name: modifier)
    }
}

//TODO: NA chama wjebałem INT'a
extension InitializerClauseSyntax {
    static func construct(with value: String?) -> Self? {
        guard let value
        else { return nil }
        
        return InitializerClauseSyntax(
            equal: .token(.equal),
            value: IntegerLiteralExprSyntax(literal: .integerLiteral(value))
        )
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
    static func construct(with stringValue: String) -> Self {
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
