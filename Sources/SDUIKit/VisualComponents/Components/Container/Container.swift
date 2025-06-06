import Foundation
import SwiftUI

@MainActor @Observable public class Container: Component, ContainerProtocol {
    
    public var components: [Component]
    
    required init(object: JSONObject, screen: Screen, registrar: Registrar) {
        self.components = registrar.parseComponents(object: object["components"], screen: screen)!
        super.init(object: object, screen: screen, registrar: registrar)
    }
    
}

