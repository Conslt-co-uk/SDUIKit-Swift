import Foundation

@MainActor class Back: Action {
    
    required init(object: JSONObject, registrar: Registrar) {
        
    }
    
    func run(screen: Screen) async throws(ActionError) {
        screen.stack?.back()
    }
    
}
