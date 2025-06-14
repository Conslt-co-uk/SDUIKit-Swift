
import SwiftUI
import Foundation

@Observable class SDUITextField: InputComponent, VisualProtocol {
    
    var placeholder: String?
    var content: String?
    let placeholderExpression: StringExpression?
    let contentExpression: StringExpression?
    
    
    required init(object: JSONObject, screen: Screen, registrar: Registrar, typeName: String? = nil) {
        placeholderExpression = registrar.parseStringExpression(object: object["placeholder"])
        contentExpression = registrar.parseStringExpression(object: object["content"])
        
        super.init(object: object, screen: screen, registrar: registrar, typeName: typeName ?? "textField")
    }

    override func updateVariables() {
        super.updateVariables()
        placeholder = placeholderExpression?.compute(state: state)
        content = contentExpression?.compute(state: state)
    }
    
    @ViewBuilder
    func view() -> any View {
        TextFieldView(textField: self)
    }
}
