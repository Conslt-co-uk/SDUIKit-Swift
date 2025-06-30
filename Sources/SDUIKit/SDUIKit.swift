import Foundation

@MainActor @Observable public class Root {
    
    let registrar: Registrar
    let appObject: JSONObject
    var app: App
    let callback: (([String: Any]) -> ())?
    let urlSession: URLSession
    
    public init(json: JSONObject, registrar: Registrar = Registrar(), urlSession: URLSession? = nil, callback: (([String: Any]) -> ())? = nil) {
        self.app = registrar.parseApp(object: json)!
        self.registrar = registrar
        self.callback = callback
        self.appObject = json
        if let urlSession = urlSession {
            self.urlSession = urlSession
        } else {
            let config = URLSessionConfiguration.default
            config.httpCookieStorage = HTTPCookieStorage.shared
            config.httpShouldSetCookies = true
            config.httpCookieAcceptPolicy = .always
            self.urlSession = URLSession(configuration: config)
        }
        app.root = self
    }
    
    func openDeepLink(url: URL) {
        var appObject = self.appObject
        var state = appObject["state"] as? [String: JSONValue] ?? [:]
        var strings = state["strings"] as? [String: JSONValue] ?? [:]
        strings["app.startURL"] = url.absoluteString as JSONValue
        state["strings"] = strings as JSONValue
        appObject["state"] = state as JSONValue
        let app = registrar.parseApp(object: appObject)!
        app.root = self
        self.app = app
    }
    
}

