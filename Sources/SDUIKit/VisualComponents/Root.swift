import Foundation

@MainActor @Observable class Root {
    
    var app: App
    var callback: (([String: Any]) -> ())?
    
    public init(json: JSONObject, callback: (([String: Any]) -> ())? = nil) {
        let registrar = Registrar()
        let app = registrar.parseApp(object: json)!
        self.app = app
        self.callback = callback
        app.root = self
    }
    
}
