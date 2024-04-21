import SwiftSyntax

public typealias SwiftierFunction = Swiftier<FunctionDeclSyntax>
public typealias SwiftierParameter = Swiftier<FunctionParameterSyntax>
public typealias SwiftierIdentifierType = Swiftier<IdentifierTypeSyntax>

public extension SwiftierFunction {
    var name: String {
        syntax.name.text
    }
//    var parameters: [SwiftierParameter] {
//        syntax.parameters.com
//    }
}

public extension SwiftierParameter {
    var label: String? { syntax.secondName?.text ?? nil }
    var name: String { syntax.firstName.text }
}
