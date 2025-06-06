import Foundation

@MainActor class Confirm: Action {
    
    let titleExpression: StringExpression?
    let messageExpression: StringExpression
    let okActions: [Action]
    let cancelActions: [Action]
    
    
    required init(object: JSONObject, registrar: Registrar) {
        titleExpression = registrar.parseStringExpression(object: object["title"])
        messageExpression = registrar.parseStringExpression(object: object["message"])!
        okActions = registrar.parseActions(object: object["okActions"]) ?? []
        cancelActions = registrar.parseActions(object: object["cancelActions"]) ?? []
    }
    
    func run(screen: Screen) async throws(ActionError) {
        let title = titleExpression?.compute(state: screen.state)
        let message = messageExpression.compute(state: screen.state) ?? ""
        if await screen.showConfirmation(title: title, message: message) {
            for anAction in okActions {
                try await anAction.run(screen: screen)
            }
        } else {
            for anAction in cancelActions {
                try await anAction.run(screen: screen)
            }
        }
    }
    
}
