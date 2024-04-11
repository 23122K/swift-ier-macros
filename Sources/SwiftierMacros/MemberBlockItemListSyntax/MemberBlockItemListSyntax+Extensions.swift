//
//  File.swift
//  
//
//  Created by Patryk Maciąg on 11/04/2024.
//

import SwiftSyntax

public extension MemberBlockItemListSyntax {
    func filter<S: SyntaxProtocol>(for syntaxType: S.Type) -> [S] {
        self.compactMap { member in
            member.decl.as(S.self)
        }
    }
}
