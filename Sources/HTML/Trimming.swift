import Foundation

infix operator %% : AdditionPrecedence

public func %% (lhs: Node, rhs: Node) -> Node {
    switch (lhs, rhs) {
    case (.trim, .trim):
        return .trim
    default:
        return .fragment(children: [ lhs, .trim, rhs ])
    }
}

prefix operator %

public prefix func % (node: Node) -> Node {
    guard node != .trim else { return .trim }

    return .fragment(children: [ .trim, node ])
}

postfix operator %

public postfix func % (node: Node) -> Node {
    guard node != .trim else { return .trim }

    return .fragment(children: [ node, .trim ])
}
