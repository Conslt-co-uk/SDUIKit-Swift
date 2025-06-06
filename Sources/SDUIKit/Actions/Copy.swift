import Foundation

@MainActor class Copy: Action {
    
    let stringExpression: StringExpression
    
    required init(object: JSONObject, registrar: Registrar) {
        stringExpression = registrar.parseStringExpression(object: object["string"])!
    }
    
    func run(screen: Screen) async throws(ActionError) {
        let string = stringExpression.compute(state: screen.state)
        OS.copyToPasteboard(string)
    }
    
}
