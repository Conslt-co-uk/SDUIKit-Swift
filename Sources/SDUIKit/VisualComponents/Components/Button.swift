import Foundation
import SwiftUI

@MainActor @Observable class Button: Component, VisualProtocol {
    
    var title: String?
    var enabled: Bool?
    var pressedStyle: Style = Style(object: [:])
    var position: String?
    
    private let actions: [Action]?
    private let titleExpression: StringExpression?
    private let enabledExpression: BooleanExpression?
    private let pressedStyleExpression: StyleExpression?
    private let positionExpression: StringExpression?
    let image: SDUIImage?
    
    required init(object: JSONObject, screen: Screen, registrar: Registrar, typeName: String? = nil) {
        enabledExpression = registrar.parseBooleanExpression(object: object["enabled"])
        titleExpression = registrar.parseStringExpression(object: object["title"])
        positionExpression = registrar.parseStringExpression(object: object["position"])
        image = registrar.parseComponent(object: object["image"], screen: screen) as? SDUIImage
        pressedStyleExpression = StyleExpression(object: object, registrar: registrar, stylesheet: screen.stack!.app!.stylesheet, styleName: "pressedButton", prefix: "pressed")
        actions = registrar.parseActions(object: object["actions"])
        super.init(object: object, screen: screen, registrar: registrar, typeName: "button")
    }
    
    override func updateVariables() {
        super.updateVariables()
        enabled = enabledExpression?.compute(state: state)
        position = positionExpression?.compute(state: state)
        title = titleExpression?.compute(state: state)
        image?.updateVariables()
        pressedStyle = pressedStyleExpression?.style(state: state, stylesheet: screen.stack!.app!.stylesheet).add(style: style) ?? style
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
