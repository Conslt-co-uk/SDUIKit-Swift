import Foundation
import SwiftUI

@Observable @MainActor
class Form: Screen, VisualProtocol {
    
    required init(object: JSONObject, stack: Stack, state: State, registrar: Registrar, typeName: String? = nil) {
        super.init(object: object, stack: stack, state: state, registrar: registrar, typeName: "form")
    }
    
    
    @ViewBuilder
    func view() -> any View
    {
        FormView(form: self)
    }
    
}
