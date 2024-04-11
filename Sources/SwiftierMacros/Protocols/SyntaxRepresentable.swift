//
//  File.swift
//  
//
//  Created by Patryk Maciąg on 11/04/2024.
//

import SwiftSyntax

public protocol SyntaxRepresentable {
    associatedtype S: DeclGroupSyntax
    
    var syntax: S { get set }
}

extension SyntaxRepresentable {
    internal var content: MemberBlockItemListSyntax {
        self.syntax.memberBlock.members
    }
}



