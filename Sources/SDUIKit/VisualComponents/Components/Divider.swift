import Foundation
import SwiftUI

@MainActor @Observable class Divider: Component, VisualProtocol {
    
    var leftMargin: Double = 0
    var rightMargin: Double = 0
    
    private let leftMarginExpression: NumberExpression
    private let rightMarginExpression: NumberExpression
    
    required init(object: JSONObject, screen: Screen, registrar: Registrar, typeName: String? = nil) {
        leftMarginExpression = registrar.parseNumberExpression(object: object["leftMargin"] ?? 0)!
        rightMarginExpression = registrar.parseNumberExpression(object: object["rightMargin"] ?? 0)!
        super.init(object: object, screen: screen, registrar: registrar, typeName: typeName ?? "divider")
    }
    
    override func updateVariables() {
        super.updateVariables()
        leftMargin = leftMarginExpression.compute(state: state) ?? 0
        rightMargin = rightMarginExpression.compute(state: state) ?? 0
    }
    
    @ViewBuilder
    func view() -> any View {
        DividerView(divider: self)
    }
}



