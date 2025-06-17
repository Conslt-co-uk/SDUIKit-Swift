import Foundation

@MainActor class PlatformAction: Action {
    
    let actions: [Action]
    
    required init(object: JSONObject, registrar: Registrar) {
        actions = registrar.parseActions(object: object["iOS"]) ?? []
    }
    
    func run(screen: Screen) async throws(ActionError) {
        for anAction in actions {
            try await anAction.run(screen: screen)
        }
    }
    
}
