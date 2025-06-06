import Foundation

@MainActor class Push: Action {
    
    let screenObject: JSONObject
    let registrar: Registrar
    
    required init(object: JSONObject, registrar: Registrar) {
        self.screenObject = object["screen"] as! JSONObject
        self.registrar = registrar
    }
    
    func run(screen: Screen) async throws(ActionError) {
        guard let stack = screen.stack else { return }
        guard let screenToPush = registrar.parseScreen(object: screenObject, stack: stack, state: screen.state) else { return }
        stack.push(screen: screenToPush)
    }
    
}
