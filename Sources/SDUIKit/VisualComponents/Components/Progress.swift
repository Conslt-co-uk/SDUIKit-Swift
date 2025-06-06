import Foundation
import SwiftUI

@MainActor @Observable class Progress: Component, VisualProtocol {
    
    var title: String?
    var progress: Double = 0
    
    private let titleExpression: StringExpression?
    private let progressExpression: NumberExpression
    
    required init(object: JSONObject, screen: Screen, registrar: Registrar) {
        titleExpression = registrar.parseStringExpression(object: object["title"])
        progressExpression = registrar.parseNumberExpression(object: object["progress"])!
        super.init(object: object, screen: screen, registrar: registrar)
    }
    
    override func updateVariables() {
        super.updateVariables()
        title = titleExpression?.compute(state: state)
        progress = progressExpression.compute(state: state) ?? 0
    }
    
    @ViewBuilder
    func view() -> any View {
        ProgressView(progress: self)
    }
}

