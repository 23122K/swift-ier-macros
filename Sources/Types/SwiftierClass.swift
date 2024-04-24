import SwiftSyntax

public typealias SwiftierClass = Swiftier<ClassDeclSyntax>

public extension SwiftierClass {
    var name: String { syntax.name.text }
    var variables: [SwiftierVariable] {
        syntax.content
            .search(for: \.variable)
            .swiftier()
    }
    
    var enums: [SwiftierEnum] {
        syntax.content
            .search(for: \.enum)
            .swiftier()
    }
    var functions: [SwiftierFunction] {
        syntax.content
            .search(for: \.function)
            .swiftier()
    }
    
    var structs: [SwiftierStruct] {
        syntax.content
            .search(for: \.struct)
            .swiftier()
    }
    var actors: [SwiftierActor] {
        syntax.content
            .search(for: \.actor)
            .swiftier()
    }
}

public extension SwiftierClass {
    init?(syntax: some SyntaxProtocol) {
        guard let syntax = syntax.as(Syntax.self)
        else { return nil }
        
        self.init(syntax: syntax)
    }
}
