import Foundation

@MainActor open class Component: VisualComponent {
    
    let screen: Screen
    
    required public init(object: JSONObject, screen: Screen, registrar: Registrar, typeName: String? = nil) {
        self.screen = screen
        super.init(object: object, state: screen.state, registrar: registrar, stylesheet: screen.stack!.app!.stylesheet, typeName: typeName)
    }
    
}
