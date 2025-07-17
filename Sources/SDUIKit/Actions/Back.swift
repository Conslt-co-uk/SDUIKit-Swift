import Foundation

@MainActor class Back: Action {
    
    let nameExpression: StringExpression?
    
    required init(object: JSONObject, registrar: Registrar) {
        nameExpression = registrar.parseStringExpression(object: object["name"])
    }
    
    func run(screen: Screen) async throws(ActionError) {
        let name = nameExpression?.compute(state: screen.state)
        screen.stack?.back(name: name)
    }
    
}
