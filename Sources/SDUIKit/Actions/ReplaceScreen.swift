import Foundation

@MainActor class ReplaceScreen: Action {
    
    let screenObject: JSONObject
    let registrar: Registrar
    
    required init(object: JSONObject, registrar: Registrar) {
        let objectOrName = object["screen"]!
        if let name = objectOrName as? String {
            self.screenObject = registrar.components[name] as! JSONObject
        } else {
            self.screenObject = object["screen"] as! JSONObject
        }
        self.registrar = registrar
    }
    
    func run(screen: Screen) async throws(ActionError) {
        screen.stack?.app?.replaceScreen(screenObject: screenObject, registrar: registrar)
    }
    
}
