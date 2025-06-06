import Foundation

@MainActor class IfAction: Action {
    
    let conditionExpression: BooleanExpression
    let trueActions: [Action]
    let falseActions: [Action]
    
    
    required init(object: JSONObject, registrar: Registrar) {
        conditionExpression = registrar.parseBooleanExpression(object: object["condition"])!
        trueActions = registrar.parseActions(object: object["trueActions"]) ?? []
        falseActions = registrar.parseActions(object: object["falseActions"]) ?? []
    }
    
    func run(screen: Screen) async throws(ActionError) {
        let condition = conditionExpression.compute(state: screen.state) ?? false
        if condition {
            for anAction in trueActions {
                try await anAction.run(screen: screen)
            }
        } else {
            for anAction in falseActions {
                try await anAction.run(screen: screen)
            }
        }
    }
    
}
