import Foundation
import SwiftUI

@MainActor @Observable class Button: Component, VisualProtocol {
    
    var title: String?
    var enabled: Bool?
    var pressedStyle: Style = Style(object: [:])
    
    private let actions: [Action]?
    private let titleExpression: StringExpression
    private let enabledExpression: BooleanExpression?
    private let pressedStyleExpression: StyleExpression?
    
    required init(object: JSONObject, screen: Screen, registrar: Registrar) {
        enabledExpression = registrar.parseBooleanExpression(object: object["enabled"])
        titleExpression = registrar.parseStringExpression(object: object["title"])!
        pressedStyleExpression = StyleExpression(object: object, registrar: registrar, stylesheet: screen.stack!.app!.stylesheet, styleName: "buttonPressed", prefix: "pressed")
        actions = registrar.parseActions(object: object["actions"])
        super.init(object: object, screen: screen, registrar: registrar)
    }
    
    override func updateVariables() {
        super.updateVariables()
        enabled = enabledExpression?.compute(state: state)
        title = titleExpression.compute(state: state)
        pressedStyle = pressedStyleExpression?.style(state: state).add(style: style) ?? style
    }
    
    func run() {
        if let actions {
            Task {
                await screen.run(actions: actions)
            }
        }
    }
    
    @ViewBuilder
    func view() -> any View
    {
        ButtonView(button: self)
    }
}
