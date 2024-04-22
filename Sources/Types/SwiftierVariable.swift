import SwiftSyntax

public typealias SwiftierVariable = Swiftier<VariableDeclSyntax>

enum SwiftierError: Error {
    case couldNotConstruct
}

extension Swiftier<VariableDeclSyntax> {
    struct `Defaults` {
        static let identifier: String = "foo"
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

public extension Swiftier where Swiftier.Syntax == VariableDeclSyntax {
    static let variable = Variable.make()
}

public extension Swiftier<VariableDeclSyntax> {
     struct Variable {
        var identifier: String
        var specifier: Keyword
        var type: String
        
        internal init(identifier: String, specifier: Keyword, type: String) {
            self.identifier = identifier
            self.specifier = specifier
            self.type = type
        }
         
         public mutating func type(_ type: String) -> Self {
             self.type = type
             return self
         }
         
         public mutating func identifier(_ identifier: String) -> Self {
             self.identifier = identifier
             return self
         }
         
         public mutating func specifier(_ specifier: Keyword) -> Self {
             self.specifier = specifier
             return self
         }
        
        public func construct() throws -> Syntax {
            try .init(
                bindingSpecifier: .specifier(Self.check(specifier)),
                bindings: [
                    .binding(
                        name: Self.check(identifier),
                        type: Self.check(type))
                ]
            )
        }
        
        public static func make() -> Self {
            self.init(
                identifier: Defaults.identifier,
                specifier: Defaults.specifier,
                type: Defaults.type
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
