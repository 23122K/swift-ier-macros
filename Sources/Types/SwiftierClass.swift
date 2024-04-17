import SwiftSyntax

public typealias SwiftierClass = Swiftier<ClassDeclSyntax>

public extension SwiftierClass {
    var name: String { syntax.name.text }
    var enums: [SwiftierEnum] {
        syntax.content
            .search(for: \.enum)
            .construct()
    }
    var functions: [SwiftierFunction] {
        syntax.content
            .search(for: \.function)
            .construct()
    }
    var structs: [SwiftierStruct] {
        syntax.content
            .search(for: \.struct)
            .construct()
    }
    var actors: [SwiftierActor] {
        syntax.content
            .search(for: \.actor)
            .construct()
    }
}

public extension SwiftierClass {
    init?(syntax: some SyntaxProtocol) {
        guard let syntax = syntax.as(Syntax.self)
        else { return nil }
        
        self.init(syntax: syntax)
    }
}
