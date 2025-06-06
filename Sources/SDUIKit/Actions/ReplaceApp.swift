import Foundation

@MainActor class ReplaceApp: Action {
    
    let appObject: JSONObject
    let registrar: Registrar
    
    required init(object: JSONObject, registrar: Registrar) {
        self.appObject = object["app"] as! JSONObject
        self.registrar = registrar
    }
    
    func run(screen: Screen) async throws(ActionError) {
        let app = registrar.parseApp(object: appObject)!
        app.root = screen.stack?.app?.root
        screen.stack?.app?.root?.app = app
    }
    
}
