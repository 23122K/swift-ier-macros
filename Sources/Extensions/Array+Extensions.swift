import SwiftSyntax

public extension Array where Array.Element: SyntaxProtocol {
    func swiftier() -> [Swiftier<Element>] {
        self.compactMap { syntax in
            Swiftier(syntax: syntax)
        }
    }
}
