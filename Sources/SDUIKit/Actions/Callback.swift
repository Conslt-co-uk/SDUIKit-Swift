import Foundation

@MainActor class Callback: Action {
    
    let booleanExpressions: [String: BooleanExpression]?
    let numberExpresions: [String: NumberExpression]?
    let stringExpressions: [String: StringExpression]?
    
    
    required init(object: JSONObject, registrar: Registrar) {
        booleanExpressions = (object["booleans"] as? [String: JSONValue])?.mapValues { registrar.parseBooleanExpression(object: $0)! }
        numberExpresions = (object["numbers"] as? [String: JSONValue])?.mapValues { registrar.parseNumberExpression(object: $0)! }
        stringExpressions = (object["strings"] as? [String: JSONValue])?.mapValues { registrar.parseStringExpression(object: $0)! }
    }
    
    func run(screen: Screen) async throws(ActionError) {
        let booleans = booleanExpressions?.mapValues { $0.compute(state: screen.state) }
        let numbers = numberExpresions?.mapValues { $0.compute(state: screen.state) }
        let strings = stringExpressions?.mapValues { $0.compute(state: screen.state) }
        var json: [String: Any] = [:]
        for (key, value) in booleans ?? [:] {
            json[key] = value
        }
        for (key, value) in numbers ?? [:] {
            json[key] = value
        }
        for (key, value) in strings ?? [:] {
            json[key] = value
        }
        screen.stack?.app?.root?.callback?(json)
    }
    
}
