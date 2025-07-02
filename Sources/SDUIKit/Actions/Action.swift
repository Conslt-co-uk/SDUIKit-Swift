import Foundation

@MainActor public protocol Action {
    
    init (object: JSONObject, registrar: Registrar)
    func run(screen: Screen) async throws(ActionError)
    
}
