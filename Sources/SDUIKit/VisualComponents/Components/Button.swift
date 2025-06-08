import Foundation
import SwiftUI

@MainActor @Observable class Button: Component, VisualProtocol {
    
    var title: String?
    var image: UIImage?
    var imageURL: URL?
    var enabled: Bool?
    var pressedStyle: Style = Style(object: [:])
    
    private let actions: [Action]?
    private let titleExpression: StringExpression?
    private let imageExpression: StringExpression?
    private let enabledExpression: BooleanExpression?
    private let pressedStyleExpression: StyleExpression?
    
    required init(object: JSONObject, screen: Screen, registrar: Registrar) {
        enabledExpression = registrar.parseBooleanExpression(object: object["enabled"])
        titleExpression = registrar.parseStringExpression(object: object["title"])
        imageExpression = registrar.parseStringExpression(object: object["image"])
        pressedStyleExpression = StyleExpression(object: object, registrar: registrar, stylesheet: screen.stack!.app!.stylesheet, styleName: "buttonPressed", prefix: "pressed")
        actions = registrar.parseActions(object: object["actions"])
        super.init(object: object, screen: screen, registrar: registrar)
    }
    
    override func updateVariables() {
        super.updateVariables()
        enabled = enabledExpression?.compute(state: state)
        title = titleExpression?.compute(state: state)
        if let imageString = imageExpression?.compute(state: state), let imageURL = URL(string: imageString) {
            if imageURL != self.imageURL {
                if let imageData = try? Data(contentsOf: imageURL) {
                    image = UIImage(data: imageData)
                } else {
                    image = nil
                }
            }
        } else {
            imageURL = nil
            image = nil
        }
        
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
