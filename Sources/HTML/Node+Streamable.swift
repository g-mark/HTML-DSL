//
//  Node+Streamable.swift
//  HTML
//
//  Created by Steven Grosmark on 1/25/20.
//

import Foundation

extension Node: TextOutputStreamable {
    
    public func write<Target>(to target: inout Target) where Target : TextOutputStream {
        streamable().write(to: &target)
    }
    
}

extension Node {
    
    public func streamable(mode: RenderMode = .pretty) -> TextOutputStreamable {
        StreamableNode(self, mode: mode)
    }
    
    public enum RenderMode {
        case pretty
        case compact
    }
}

public struct StreamableNode: TextOutputStreamable {
    
    public init(_ node: Node, mode: Node.RenderMode = .pretty) {
        self.node = node
        self.mode = mode
    }
    
    public func write<Target>(to target: inout Target) where Target : TextOutputStream {
        write(node, to: &target, mode: mode)
    }
    
    private let node: Node
    private var mode: Node.RenderMode
    
    private func write<Target>(_ node: Node,
                               to target: inout Target,
                               depth: Int = 0,
                               mode: Node.RenderMode) where Target : TextOutputStream {
        
        switch node {
            
        case let .element(tag, attributes, child):
            if mode == .pretty {
                target.write(String(repeating: "\t", count: depth))
            }
            
            target.write("<")
            target.write(tag.name)
            
            for (key, value) in attributes.sorted(by: { $0 < $1 }) {
                target.write(" ")
                target.write(key)
                target.write("=\"")
                target.write(value)
                target.write("\"")
            }
            
            if let child = child {
                target.write(">")
                
                if child.hasContent {
                    let preferredMode = tag.preferredRenderMode ?? mode
                    if preferredMode == .pretty {
                        target.write("\n")
                    }
                    
                    write(child, to: &target, depth: depth + 1, mode: preferredMode)
                    
                    if preferredMode == .pretty {
                        target.write(String(repeating: "\t", count: depth))
                    }
                }
                
                target.write("</")
                target.write(tag.name)
                target.write(">")
            }
            else {
                target.write("/>")
            }
            if mode == .pretty {
                target.write("\n")
            }
            
        case let .text(value):
            if !value.isEmpty {
                if mode == .pretty {
                    target.write(String(repeating: "\t", count: depth))
                }
                target.write(value)
                if mode == .pretty {
                    target.write("\n")
                }
            }
            
        case let .comment(value):
            target.write("<!-- ")
            target.write(value)
            target.write(" -->")
            
        case let .documentType(name):
            target.write("<!DOCTYPE ")
            target.write(name)
            target.write(">\n")
            
        case let .fragment(children):
            for child in children {
                write(child, to: &target, depth: depth, mode: mode)
            }
        }
    }
    
}
