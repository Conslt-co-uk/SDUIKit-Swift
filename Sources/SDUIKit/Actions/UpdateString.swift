import Foundation


@MainActor class UpdateString: Action {
    
    let variableExpression: StringExpression
    let valueExpression: StringExpression?
    let nameExpression: StringExpression?

    required init(object: JSONObject, registrar: Registrar) {
        variableExpression = registrar.parseStringExpression(object: object["variable"])!
        valueExpression = registrar.parseStringExpression(object: object["value"])
        nameExpression = registrar.parseStringExpression(object: object["name"])
    }
    
    func run(screen: Screen) async throws(ActionError) {
        guard let variable = variableExpression.compute(state: screen.state) else { return }
        let value = valueExpression?.compute(state: screen.state)
        let name = nameExpression?.compute(state: screen.state)
        var state = screen.state
        if let name, let namedState = screen.stack?.app?.state(name: name) {
            state = namedState
        }
        state.strings[variable] = value
    }
    
}
