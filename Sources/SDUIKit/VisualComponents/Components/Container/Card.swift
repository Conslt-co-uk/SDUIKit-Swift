import Foundation
import SwiftUI

@MainActor @Observable class Card: Container, VisualProtocol {
    
    required init(object: JSONObject, screen: Screen, registrar: Registrar, typeName: String? = nil) {
        super.init(object: object, screen: screen, registrar: registrar, typeName: "card")
    }
    
    @ViewBuilder
    func view() -> any View
    {
        CardView(card: self)
    }
}

