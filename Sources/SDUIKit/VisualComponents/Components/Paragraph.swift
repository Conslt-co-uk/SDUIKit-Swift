import Foundation
import SwiftUI

@MainActor @Observable class Paragraph: Component, VisualProtocol {
    
    let spans: [Span]
    var alignment: String = "left"
    
    let alignmentExpression: StringExpression
    
    required init(object: JSONObject, screen: Screen, registrar: Registrar, typeName: String? = nil) {
        spans = registrar.ParseSpans(object: object["spans"], screen: screen) ?? []
        alignmentExpression = registrar.parseStringExpression(object: object["alignment"] ?? "left")!
        super.init(object: object, screen: screen, registrar: registrar, typeName: "paragraph")
    }
    
    override func updateVariables() {
        super.updateVariables()
        alignment = alignmentExpression.compute(state: state) ?? "left"
    }
    
    func clicked(url: URL) async {
        if let index = Int(url.absoluteString),
           let actions = spans[index].actions {
            await screen.run(actions: actions)
        }
    }
    
    @ViewBuilder
    func view() -> any View {
        ParagraphView(paragraph: self)
    }
    
}
