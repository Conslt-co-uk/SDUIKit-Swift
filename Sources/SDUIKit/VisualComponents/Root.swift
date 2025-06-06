import Foundation

@MainActor @Observable public class Root {
    
    var app: App
    
    public init(data: Data) {
        let registrar = Registrar()
        let json = try! JSONDecoder().decode(AnyDecodable.self, from: data).value
        let app = registrar.parseApp(object: json)!
        self.app = app
        app.root = self
    }
    
}
