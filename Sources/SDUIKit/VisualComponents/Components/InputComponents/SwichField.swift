import SwiftUI
import Foundation

@Observable class SwitchField: InputComponent, VisualProtocol {
    
    struct SelectValue: Identifiable {
        let variable: String
        let title: String
        init(object: JSONObject) {
            variable = object["variable"] as! String
            title = object["title"] as! String
        }
        
        var id: String { variable }
    }
    
    let values: [SelectValue]
    
    required init(object: JSONObject, screen: Screen, registrar: Registrar) {
        values = (object["values"] as! [JSONObject]).map{ SelectValue(object: $0) }
        super.init(object: object, screen: screen, registrar: registrar)
    }
    
    @ViewBuilder
    func view() -> any View {
        SwitchFieldView(switchField: self)
    }
}
