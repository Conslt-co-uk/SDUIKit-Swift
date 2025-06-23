import Foundation

@MainActor class ValidateScreen: Action {
    
    let titleExpression: StringExpression?

    required init(object: JSONObject, registrar: Registrar) {
        titleExpression = registrar.parseStringExpression(object: object["title"])
    }
    
    func run(screen: Screen) async throws(ActionError) {
        if let firstMessage = self.firstMessage(container: screen) {
            let title = titleExpression?.compute(state: screen.state)
            throw .init(title: title, message: firstMessage)
        }
    }
    
    func firstMessage(container: ContainerProtocol) -> String? {
        var firstMessage: String?
        for aComponent in container.components {
            if let component = aComponent as? InputComponent {
                component.validate = true
                if firstMessage == nil, let firstErrorMessage = component.firstErrorMessage {
                    firstMessage = firstErrorMessage
                }
            } else if let container = aComponent as? Container {
                let message = self.firstMessage(container: container)
                if firstMessage == nil, let message = message {
                    firstMessage = message
                }
            }
        }
        return firstMessage
    }
    
}
