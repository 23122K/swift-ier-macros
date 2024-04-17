//
//  File.swift
//  
//
//  Created by Patryk Maciąg on 16/04/2024.
//

import SwiftSyntax

public extension MemberBlockItemListSyntax {
    func search<S: SyntaxProtocol>(for swiftierSyntaxType: KeyPath<Swiftier<Any>.SyntaxType, S.Type>) -> [S] {
        self.compactMap { member in S.init(member.decl) }
    }
}
