import SwiftSyntax

public typealias SwiftierVariable = Swiftier<VariableDeclSyntax>

enum SwiftierError: Error {
    case couldNotConstruct
}

extension Swiftier<VariableDeclSyntax> {
    public struct `Defaults` {
        static let identifier: String = "example"
        static let specifier: Keyword = .let
        static let type: String = "Int"
        
        private init() { }
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

extension Swiftier<VariableDeclSyntax> {
    struct Variable {
        public var identifier: String
        public var specifier: Keyword
        public var type: String
        
        public static func foundation() -> Self {
            self.init(
                identifier: Swiftier.Defaults.identifier,
                specifier: Swiftier.Defaults.specifier,
                type: Swiftier.Defaults.type
            )
        }
        
        init(identifier: String, specifier: Keyword, type: String) {
            self.identifier = identifier
            self.specifier = specifier
            self.type = type
        }
        
        public func construct() -> Syntax {
            return Syntax(
                bindingSpecifier: .specifier(specifier),
                bindings: [
                    .binding(name: identifier, type: type)
                ]
            )
        }
    }
}

extension Swiftier.Variable {
    func build(_ edit: (inout Self) -> Void) -> Self {
        var value: Self = self
        edit(&value)
        return value
    }
}

public extension SwiftierC.Variable {
    func build(_ edit: (inout Self) -> Void) -> Self {
        var value: Self = self
        edit(&value)
        return value
    }
}

public extension SwiftierC<VariableDeclSyntax> {
    class Variable: SwiftierC<VariableDeclSyntax> {
        public var identifier: String
        public var specifier: Keyword
        public var type: String
        
        public static func foundation() -> Self {
            self.init(
                identifier: Swiftier.Defaults.identifier,
                specifier: Swiftier.Defaults.specifier,
                type: Swiftier.Defaults.type
            )
        }
        
        public func type(_ type: String) -> Self {
            self.type = type
            return self
        }
        
        public func identifier(_ identifier: String) -> Self {
            self.identifier = identifier
            return self
        }
        
        public func specifier(_ specifier: Keyword) -> Self {
            self.specifier = specifier
            return self
        }
        
        public func construct() -> Self {
            self.syntax = Syntax(
                bindingSpecifier: .specifier(specifier),
                bindings: [
                    .binding(name: identifier, type: type)
                ]
            )
            
            return self
        }
                
        internal required init(identifier: String, specifier: Keyword, type: String) {
            self.identifier = identifier
            self.specifier = specifier
            self.type = type
            
            super.init(
                syntax: Syntax(
                    bindingSpecifier: .specifier(specifier),
                    bindings: [
                        .binding(name: identifier, type: type)
                    ]
                )
            )
        }
        
        private static func check<T>(_ optionalValue: Optional<T>) throws -> T {
            guard let value = optionalValue
            else { throw SwiftierError.couldNotConstruct }
            
            return value
        }
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
