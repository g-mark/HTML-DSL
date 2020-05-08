import Foundation

public protocol Visitor {
    associatedtype Result

    func visitElement(tag: Tag, attributes: [String: String], child: Node?) -> Result

    func visitText(text: String) -> Result

    func visitComment(text: String) -> Result

    func visitDocumentType(name: String) -> Result

    func visitFragment(children: [Node]) -> Result

    func visitNode(_ node: Node) -> Result
}

extension Visitor {
    
    public func visitNode(_ node: Node) -> Result {
        switch node {
            
        case .element(let tag, let attributes, let child):
            return visitElement(tag: tag, attributes: attributes, child: child)
        
        case .text(let text):
            return visitText(text: text)
        
        case .comment(let text):
            return visitComment(text: text)
        
        case .documentType(let name):
            return visitDocumentType(name: name)
        
        case .fragment(let children):
            return visitFragment(children: children)
        }
    }
    
}

public extension Visitor where Result == Node {
    
    func visitElement(tag: Tag, attributes: [String: String], child: Node?) -> Result {
        .element(tag, attributes: attributes, child: child.map(visitNode))
    }

    func visitText(text: String) -> Result {
        .text(text)
    }

    func visitComment(text: String) -> Result {
        .comment(text)
    }

    func visitDocumentType(name: String) -> Result {
        .documentType(name)
    }

    func visitFragment(children: [Node]) -> Result {
        .fragment(children: children.map(visitNode))
    }
    
}
