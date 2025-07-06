import Foundation

@MainActor class UpdateNumber: Action {
    
    let variableExpression: StringExpression
    let valueExpression: NumberExpression?
    let nameExpression: StringExpression?

    required init(object: JSONObject, registrar: Registrar) {
        variableExpression = registrar.parseStringExpression(object: object["variable"])!
        valueExpression = registrar.parseNumberExpression(object: object["value"])
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
        state.numbers[variable] = value
    }
    
}
