import Foundation

@MainActor public class Component: VisualComponent {
    
    let screen: Screen
    
    required init(object: JSONObject, screen: Screen, registrar: Registrar) {
        self.screen = screen
        super.init(object: object, state: screen.state, registrar: registrar, stylesheet: screen.stack!.app!.stylesheet)
    }
    
}
