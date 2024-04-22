import SwiftSyntax

public typealias SwiftierVariable = Swiftier<VariableDeclSyntax>

enum SwiftierError: Error {
    case couldNotConstruct
}

extension Swiftier<VariableDeclSyntax> {
    public struct `Defaults` {
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
    
}

public extension Swiftier<VariableDeclSyntax> {
     struct Variable {
        var identifier: String
        var specifier: Keyword
        var type: String
         
        init(identifier: String, specifier: Keyword, type: String) throws {
            self.identifier = identifier
            self.specifier = specifier
            self.type = type
        }
    }
}

extension Swiftier.Variable {
    public struct Builder {
        public var variable: Swiftier.Variable
        
        public mutating func type(_ type: String) -> Builder {
            variable.type = type
            return self
        }
        
        public mutating func identifier(_ identifier: String) -> Builder {
            variable.identifier = identifier
            return self
        }
        
        public mutating func specifier(_ specifier: Keyword) -> Builder {
            variable.specifier = specifier
            return self
        }
       
       public static func make() -> Builder {
           Builder(variable: try! .init(
            identifier: Swiftier.Defaults.identifier,
            specifier: Swiftier.Defaults.specifier,
            type: Swiftier.Defaults.type
           ))
       }
        
        public func construct() throws -> Swiftier.Variable {
            return variable
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
