import Foundation

@MainActor class Close: Action {
    
    required init(object: JSONObject, registrar: Registrar) {
        
    }
    
    func run(screen: Screen) async throws(ActionError) {
        screen.stack?.app?.close()
    }
    
}
