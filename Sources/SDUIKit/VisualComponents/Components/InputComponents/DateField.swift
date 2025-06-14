
import SwiftUI
import Foundation

@Observable class DateField: InputComponent, VisualProtocol {
    
    var min: Date?
    var max: Date?
    var picker: String?
    
    private let minExpression: StringExpression?
    private let maxExpression: StringExpression?
    private let pickerExpression: StringExpression?
    
    required init(object: JSONObject, screen: Screen, registrar: Registrar, typeName: String? = nil) {
        minExpression = registrar.parseStringExpression(object: object["min"])
        maxExpression = registrar.parseStringExpression(object: object["max"])
        pickerExpression = registrar.parseStringExpression(object: object["picker"])
        super.init(object: object, screen: screen, registrar: registrar, typeName: typeName ?? "dateField")
    }

    override func updateVariables() {
        super.updateVariables()
        min = Date(ISO8601dateString: minExpression?.compute(state: state))
        max = Date(ISO8601dateString: maxExpression?.compute(state: state))
        picker = pickerExpression?.compute(state: state)
    }
    
    @ViewBuilder
    func view() -> any View {
        DateFieldView(dateField: self)
    }
}
