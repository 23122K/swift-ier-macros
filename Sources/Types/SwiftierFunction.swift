import SwiftSyntax

public typealias SwiftierFunction = Swiftier<FunctionDeclSyntax>

public extension Swiftier where Swiftier.Syntax == OptionalTypeSyntax {
    var type: String? {
        guard let type = syntax.wrappedType.as(IdentifierTypeSyntax.self)?.name.text
        else { return nil }
        
        return type
    }
}

public extension Swiftier where Swiftier.Syntax == FunctionDeclSyntax {
    var name: String {
        syntax.name.text
    }
}

public extension Swiftier where Swiftier.Syntax == FunctionParameterSyntax {
    var label: String? {
        syntax.secondName?.text ?? nil
    }
    
    var name: String {
        syntax.firstName.text
    }
}
