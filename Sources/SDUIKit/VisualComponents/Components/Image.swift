import Foundation
import SwiftUI

@MainActor @Observable class SDUIImage: Component, VisualProtocol {
    
    var image: String = ""
    
    private let imageExpression: StringExpression
    
    required init(object: JSONObject, screen: Screen, registrar: Registrar, typeName: String? = nil) {
        imageExpression = registrar.parseStringExpression(object: object["image"] ?? 0)!
        super.init(object: object, screen: screen, registrar: registrar, typeName: typeName ?? "image")
    }
    
    override func updateVariables() {
        super.updateVariables()
        image = imageExpression.compute(state: state)!
    }
    
    @ViewBuilder
    func view() -> any View {
        ImageView(image: self)
    }
}


