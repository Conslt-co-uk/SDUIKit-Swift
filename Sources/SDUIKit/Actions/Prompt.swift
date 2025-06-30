import Foundation

@MainActor class Prompt: Action {
    
    let titleExpression: StringExpression?
    let messageExpression: StringExpression
    let variableExpression: StringExpression?
    
    required init(object: JSONObject, registrar: Registrar) {
        titleExpression = registrar.parseStringExpression(object: object["title"])
        messageExpression = registrar.parseStringExpression(object: object["message"])!
        variableExpression = registrar.parseStringExpression(object: object["variable"])
    }
    
    func run(screen: Screen) async throws(ActionError) {
        let title = titleExpression?.compute(state: screen.state)
        let message = messageExpression.compute(state: screen.state) ?? ""
        let variableName = variableExpression?.compute(state: screen.state) ?? ""
        let defaultValue = screen.state.stringValue(name: variableName) ?? ""
        if let result = await screen.showPrompt(title: title, message: message, initialValue: defaultValue) {
            screen.state.strings[variableName] = result
        } else {
            throw .init(title: nil, message: nil)
        }
    }
    
}
