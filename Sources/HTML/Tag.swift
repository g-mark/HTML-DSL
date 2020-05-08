//
//  Tag.swift
//  HTML
//
//  Created by Steven Grosmark on 1/26/20.
//

import Foundation

public enum Tag: String, Equatable {
    case a
    case abbr
    case acronym
    case address
    case applet
    case area
    case article
    case aside
    case audio
    case b
    case base
    case basefont
    case bdi
    case bdo
    case bgsound
    case big
    case blink
    case blockquote
    case body
    case br
    case button
    case canvas
    case caption
    case center
    case cite
    case code
    case col
    case colgroup
    case command
    case content
    case data
    case datalist
    case dd
    case del
    case details
    case dfn
    case dialog
    case dir
    case div
    case dl
    case dt
    case element
    case em
    case embed
    case fieldset
    case figcaption
    case figure
    case font
    case footer
    case form
    case frame
    case frameset
    case h1
    case h2
    case h3
    case h4
    case h5
    case h6
    case head
    case header
    case hgroup
    case hr
    case html
    case i
    case iframe
    case image
    case img
    case input
    case ins
    case isindex
    case kbd
    case keygen
    case label
    case legend
    case li
    case link
    case listing
    case main
    case map
    case mark
    case marquee
    case menu
    case menuitem
    case meta
    case meter
    case multicol
    case nav
    case nextid
    case nobr
    case noembed
    case noframes
    case noscript
    case object
    case ol
    case optgroup
    case option
    case output
    case p
    case param
    case picture
    case plaintext
    case pre
    case progress
    case q
    case rb
    case rp
    case rt
    case rtc
    case ruby
    case s
    case samp
    case script
    case section
    case select
    case shadow
    case slot
    case small
    case source
    case spacer
    case span
    case strike
    case strong
    case style
    case sub
    case summary
    case sup
    case table
    case tbody
    case td
    case template
    case textarea
    case tfoot
    case th
    case thead
    case time
    case title
    case tr
    case track
    case tt
    case u
    case ul
    case `var`
    case video
    case wbr
    case xmp
}

extension Tag {
    
    var name: String { rawValue }
    
    var preferredRenderMode: Node.RenderMode? {
        switch self {
            
        case .a, .abbr,
             .b, .bdi, .bdo, .br,
             .cite, .code,
             .data, .dfn,
             .em,
             .h1, .h2, .h3, .h4, .h5, .h6,
             .i,
             .kbd,
             .label,
             .mark,
             .p, .pre,
             .q,
             .rb, .rp, .rt, .rtc, .ruby,
             .s, .samp, .small, .span, .strong, .sub, .sup,
             .textarea, .time, .title, .tt,
             .u,
             .var,
             .wbr:
            return .compact
            
        case .acronym, .address, .applet, .area, .article, .aside, .audio,
             .base, .basefont, .bgsound, .big, .blink, .blockquote, .body, .button,
             .canvas, .caption, .center, .col, .colgroup, .command, .content,
             .datalist, .dd, .del, .details, .dialog, .dir, .div, .dl, .dt,
             .element, .embed,
             .fieldset, .figcaption, .figure, .font, .footer, .form, .frame, .frameset,
             .head, .header, .hgroup, .hr, .html,
             .iframe, .image, .img, .input, .ins, .isindex,
             .keygen,
             .legend, .li, .link, .listing,
             .main, .map, .marquee, .menu, .menuitem, .meta, .meter, .multicol,
             .nav, .nextid, .nobr, .noembed, .noframes, .noscript,
             .object, .ol, .optgroup, .option, .output,
             .param, .picture, .plaintext, .progress,
             .script, .section, .select, .shadow, .slot, .source, .spacer, .strike, .style, .summary,
             .table, .tbody, .td, .template, .tfoot, .th, .thead, .tr, .track,
             .ul,
             .video,
             .xmp:
            return nil
        }
    }
    
}
