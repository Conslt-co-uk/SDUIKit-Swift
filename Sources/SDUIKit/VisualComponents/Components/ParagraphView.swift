import SwiftUI

struct ParagraphView: View {
    
    var paragraph: Paragraph
    
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    var textAlignment: TextAlignment {
        switch paragraph.style.alignment {
        case "right":
            return .trailing
        case "center":
            return .center
        default:
            return .leading
        }
    }
    
    var alignment: Alignment {
        switch paragraph.style.alignment {
        case "right":
            return .trailing
        case "center":
            return .center
        default:
            return .leading
        }
    }
    
    init(paragraph: Paragraph) {
        self.paragraph = paragraph
    }
    
    var body: some View {
        
        
        paragraph.spans.reduce(Text("")) { partialResult, span in
            if span.actions != nil {
                let index = paragraph.spans.firstIndex { $0 === span }!
                return partialResult + Text(.init("[\(span.text)](\(index))"))
                    .styledText(span.style.add(style: paragraph.style), darkMode: colorScheme == .dark, dynamicTypeSize: dynamicTypeSize)
            } else {
                return partialResult + Text(span.text)
                    .styledText(span.style.add(style: paragraph.style), darkMode: colorScheme == .dark, dynamicTypeSize: dynamicTypeSize)
            }
        }
        .multilineTextAlignment(textAlignment)
        .frame(maxWidth: .infinity, alignment: alignment)
        .styledMargin(paragraph.style)
        .environment(\.openURL, OpenURLAction(handler: { url in
            Task {
                await paragraph.clicked(url: url)
            }
            return .handled
        }))
    }
}
