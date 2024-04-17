import SwiftSyntax

public extension DeclGroupSyntax {
    var content: MemberBlockItemListSyntax { memberBlock.members }
}
