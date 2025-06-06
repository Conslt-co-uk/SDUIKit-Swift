import Foundation

@MainActor class Present: Action {
    
    let stackObject: JSONObject
    let registrar: Registrar
    
    required init(object: JSONObject, registrar: Registrar) {
        self.stackObject = object["stack"] as! JSONObject
        self.registrar = registrar
    }
    
    func run(screen: Screen) async throws(ActionError) {
        guard let app = screen.stack?.app else { return }
        guard let stackToPush = registrar.parseStack(object: stackObject, state: screen.state, app: app) else { return }
        app.present(stack: stackToPush)
    }
    
}
