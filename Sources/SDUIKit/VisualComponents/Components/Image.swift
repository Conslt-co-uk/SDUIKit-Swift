import Foundation
import SwiftUI

@MainActor @Observable class SDUIImage: Component, VisualProtocol {
    
    var imageURL: URL?
    
    private let imageExpression: StringExpression
    
    required init(object: JSONObject, screen: Screen, registrar: Registrar, typeName: String? = nil) {
        imageExpression = registrar.parseStringExpression(object: object["url"] ?? 0)!
        super.init(object: object, screen: screen, registrar: registrar, typeName: typeName ?? "image")
    }
    
    override func updateVariables() {
        super.updateVariables()
        imageURL = screen.stack?.app?.stylesheet.imageFor(name: imageExpression.compute(state: state))
    }
    
    @ViewBuilder
    func view() -> any View {
        ImageView(image: self)
    }
}


