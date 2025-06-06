import Foundation

@MainActor class ReplaceScreen: Action {
    
    let screenObject: JSONObject
    let registrar: Registrar
    
    required init(object: JSONObject, registrar: Registrar) {
        self.screenObject = object["screen"] as! JSONObject
        self.registrar = registrar
    }
    
    func run(screen: Screen) async throws(ActionError) {
        screen.stack?.app?.replaceScreen(screenObject: screenObject, registrar: registrar)
    }
    
}
