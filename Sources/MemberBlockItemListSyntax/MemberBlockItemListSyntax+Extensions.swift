//
//  File.swift
//  
//
//  Created by Patryk Maciąg on 11/04/2024.
//

import SwiftSyntax

public extension MemberBlockItemListSyntax {
    func search<S: DeclSyntaxProtocol>(for swiftierSyntaxType: KeyPath<SwiftierSyntaxType, S.Type>) -> [S] {
        self.compactMap { member in
            member.decl.as(S.self)
        }
    }
}
