import Foundation
import SwiftUI

@MainActor @Observable class Responsive: Container, VisualProtocol {
    
    var responsiveWidth: Double = 360
    
    let responsiveWidthExpression: NumberExpression?
    
    required init(object: JSONObject, screen: Screen, registrar: Registrar, typeName: String? = nil) {
        responsiveWidthExpression = registrar.parseNumberExpression(object: object["responsiveWidth"])
        super.init(object: object, screen: screen, registrar: registrar, typeName: typeName)
    }
    
    override func updateVariables() {
        super.updateVariables()
        responsiveWidth = responsiveWidthExpression?.compute(state: state) ?? 360
    }
    
    @ViewBuilder
    func view() -> any View
    {
        ResponsiveView(responsive: self)
    }
}

