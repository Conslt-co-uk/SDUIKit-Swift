
import SwiftUI
import Foundation

@Observable class MultilineField: InputComponent, VisualProtocol {
    
    var placeholder: String?
    var content: String?
    var rows: Int = 3
    let placeholderExpression: StringExpression?
    let contentExpression: StringExpression?
    let rowsExpression: NumberExpression?
    
    required init(object: JSONObject, screen: Screen, registrar: Registrar, typeName: String? = nil) {
        placeholderExpression = registrar.parseStringExpression(object: object["placeholder"])
        contentExpression = registrar.parseStringExpression(object: object["content"])
        rowsExpression = registrar.parseNumberExpression(object: object["rows"])
        super.init(object: object, screen: screen, registrar: registrar, typeName: typeName ?? "textField")
    }

    override func updateVariables() {
        super.updateVariables()
        rows = Int(rowsExpression?.compute(state: state) ?? 3)
        placeholder = placeholderExpression?.compute(state: state)
        content = contentExpression?.compute(state: state)
    }
    
    @ViewBuilder
    func view() -> any View {
        MultilineFieldView(textField: self)
    }
}
