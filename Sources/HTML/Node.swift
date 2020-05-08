import Foundation

public enum Node: Equatable {
    
    // The `Node`'s name, attribute and children.
    indirect case element(Tag, _ attributes: [String: String], _ children: Node?)

    // The `Node`'s text contents.
    case text(String)

    // The `Node`'s text contents.
    case comment(String)

    // The `Node`'s name.
    case documentType(String)

    // The `Node`'s children.
    case fragment(_ children: [Node])
    
}

extension Node {
    
    public static func element(_ tag: Tag, attributes: [String: String] = [:], child: Node?) -> Node {
        return Node.element(tag, attributes, child)
    }
    
}

extension Node {
    
    public static func fragment(children: [Node]) -> Node {
        let flattened = children
            .flatMap { node -> [Node] in
                switch node {
                case .fragment(let children):
                    return children
                default:
                    return [node]
                }
        }

        return .fragment(flattened)
    }
    
}

extension Node: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Node...) {
        self = .fragment(elements)
    }
}

extension Node: ExpressibleByStringLiteral {
    public init(stringLiteral value: String){
        self = .text(value)
    }
}

extension Node {
    
    internal var hasContent: Bool {
        switch self {
            
        case .element:
            return true
            
        case .text(let text),
             .comment(let text),
             .documentType(let text):
            return !text.isEmpty
            
        case .fragment(let children):
            guard !children.isEmpty else { return false }
            return children.firstIndex(where: { $0.hasContent }) != nil
        }
    }
    
    internal var isFragment: Bool {
        switch self {
        case .fragment:
            return true
        default:
            return false
        }
    }
    
}
