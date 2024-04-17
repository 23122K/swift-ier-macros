import SwiftSyntax

public extension MemberBlockItemListSyntax {
    func search<S: SyntaxProtocol>(for swiftierSyntaxType: KeyPath<Swiftier<Any>.`Type`, S.Type>) -> [S] {
        self.compactMap { member in S.init(member.decl) }
    }
}
