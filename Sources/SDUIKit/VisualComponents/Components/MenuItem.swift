import Foundation
import SwiftUI

@MainActor @Observable class MenuItem: Component, VisualProtocol {

    var pressedStyle: Style = Style(object: [:])
    
    private let actions: [Action]?
    let imageComponent: SDUIImage?
    let disclosureImageComponent: SDUIImage?
    let leftComponent: Component
    let rightComponent: Component?
    
    
    private let pressedStyleExpression: StyleExpression?
    
    required init(object: JSONObject, screen: Screen, registrar: Registrar, typeName: String? = nil) {
        imageComponent = registrar.parseComponent(object: object["image"], screen: screen) as? SDUIImage
        disclosureImageComponent = registrar.parseComponent(object: object["disclosureImage"], screen: screen) as? SDUIImage
        leftComponent = registrar.parseComponent(object: object["leftComponent"], screen: screen)!
        rightComponent = registrar.parseComponent(object: object["rightComponent"], screen: screen)
        pressedStyleExpression = StyleExpression(object: object, registrar: registrar, stylesheet: screen.stack!.app!.stylesheet, styleName: "pressedMenuItem", prefix: "pressed")
        actions = registrar.parseActions(object: object["actions"])
        super.init(object: object, screen: screen, registrar: registrar, typeName: "menuItem")
    }
    
    override func updateVariables() {
        super.updateVariables()
        imageComponent?.updateVariables()
        disclosureImageComponent?.updateVariables()
        leftComponent.updateVariables()
        rightComponent?.updateVariables()
        pressedStyle = pressedStyleExpression?.style(state: state).add(style: style) ?? style
    }
    
    var hasActions: Bool {
        actions != nil
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
        MenuItemView(menu: self)
    }
}


