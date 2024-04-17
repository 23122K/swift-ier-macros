//
//  File.swift
//  
//
//  Created by Patryk Maciąg on 11/04/2024.
//

import SwiftSyntax

public extension Swiftier where Swiftier.Syntax == ClassDeclSyntax {
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

public extension Swiftier.SwiftierClass {
    init?(_ syntax: Syntax) {
        self.init(syntax: syntax)
    }
}
