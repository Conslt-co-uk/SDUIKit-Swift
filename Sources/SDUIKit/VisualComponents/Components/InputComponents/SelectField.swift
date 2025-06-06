
import SwiftUI
import Foundation

@Observable class SelectField: InputComponent, VisualProtocol {
    
    struct SelectValue: Identifiable {
        let value: String
        let title: String
        init(object: JSONObject) {
            value = object["value"] as! String
            title = object["title"] as! String
        }
        
        var id: String { value }
    }
    
    let values: [SelectValue]
    
    required init(object: JSONObject, screen: Screen, registrar: Registrar) {
        values = (object["values"] as! [JSONObject]).map{ SelectValue(object: $0) }
        super.init(object: object, screen: screen, registrar: registrar)
    }
    
    @ViewBuilder
    func view() -> any View {
        SelectFieldView(selectField: self)
    }
}
