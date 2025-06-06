import Foundation

@MainActor @Observable class Span: VisualComponent {
    
    var text: String = ""
    
    private let textExpression: StringExpression
    let actions: [Action]?
    
    override init(object: JSONObject, state: State, registrar: Registrar, stylesheet: Stylesheet) {
        textExpression = registrar.parseStringExpression(object: object["text"])!
        actions = registrar.parseActions(object: object["actions"])
        super.init(object: object, state: state, registrar: registrar, stylesheet: stylesheet)
    }
    
    override func updateVariables() {
        text = textExpression.compute(state: state) ?? ""
    }
}
