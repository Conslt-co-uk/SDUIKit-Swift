import Foundation

@MainActor @Observable class Span: VisualComponent {
    
    var text: String = ""
    
    private let textExpression: StringExpression
    let actions: [Action]?
    
    override init(object: JSONObject, state: State, registrar: Registrar, stylesheet: Stylesheet, typeName: String? = nil) {
        textExpression = registrar.parseStringExpression(object: object["text"])!
        actions = registrar.parseActions(object: object["actions"])
        if actions != nil {
            print("hgh")
        }
        super.init(object: object, state: state, registrar: registrar, stylesheet: stylesheet, typeName: actions != nil ? "link" : nil)
        if actions != nil {
            dump(self.style)
        }
    }
    
    override func updateVariables() {
        text = textExpression.compute(state: state) ?? ""
        super.updateVariables()
    }
}
