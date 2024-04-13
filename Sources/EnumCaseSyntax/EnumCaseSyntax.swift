//
//  File.swift
//  
//
//  Created by Patryk Maciąg on 11/04/2024.
//

import SwiftSyntax

public struct EnumCaseSyntax {
    public var syntax: EnumCaseDeclSyntax
    public var name: String
    
    public init?(_ syntax: EnumCaseDeclSyntax) {
        guard let name = syntax.elements.first?.name.text
        else { return nil }
        
        self.syntax = syntax
        self.name = name
    }
}
