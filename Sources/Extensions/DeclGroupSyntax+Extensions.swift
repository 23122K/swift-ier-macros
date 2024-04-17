//
//  File.swift
//  
//
//  Created by Patryk Maciąg on 17/04/2024.
//

import SwiftSyntax

public extension DeclGroupSyntax {
    var content: MemberBlockItemListSyntax { memberBlock.members }
}
