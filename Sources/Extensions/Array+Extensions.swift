import SwiftSyntax

public extension Array where Array.Element: SyntaxProtocol {
    func construct() -> [Swiftier<Element>] {
        self.compactMap { syntax in
            Swiftier(syntax: syntax)
        }
    }
}
