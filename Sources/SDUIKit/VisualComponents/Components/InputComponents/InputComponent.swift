import Foundation

@MainActor @Observable open class InputComponent: Component {
    
    @ObservationIgnored public var variable: String?
    var title: String?
    var titleStyle: Style = Style(object: [:])
    var errorStyle: Style = Style(object: [:])
    var errorMessage: String?
    var validate: Bool = false {
        didSet {
            updateVariables()
        }
    }
    
    private let variableExpression: StringExpression
    private let titleExpression: StringExpression
    private let titleStyleExpression: StyleExpression
    private let errorStyleExpression: StyleExpression
    private let validationExpressions: [BooleanExpression]?
    
    required public init(object: JSONObject, screen: Screen, registrar: Registrar, typeName: String? = nil) {
        variableExpression = registrar.parseStringExpression(object: object["variable"] ?? "")!
        titleExpression = registrar.parseStringExpression(object: object["title"] ?? "")!
        titleStyleExpression = StyleExpression(object: object, registrar: registrar, stylesheet: screen.stack!.app!.stylesheet, styleName: "inputTitle", prefix: "title")
        errorStyleExpression = StyleExpression(object: object, registrar: registrar, stylesheet: screen.stack!.app!.stylesheet, styleName: "inputError", prefix: "error")
        validationExpressions = registrar.parseBooleanExpressions(object: object["validations"])
        super.init(object: object, screen: screen, registrar: registrar, typeName: typeName ?? "field")
    }
    
    override open func updateVariables() {
        super.updateVariables()
        variable = variableExpression.compute(state: state)
        title = titleExpression.compute(state: state)
        titleStyle = titleStyleExpression.style(state: state, stylesheet: screen.stack!.app!.stylesheet)
        errorStyle = errorStyleExpression.style(state: state, stylesheet: screen.stack!.app!.stylesheet)
        errorMessage = validate ? firstErrorMessage : nil
    }
    
    var firstErrorMessage: String? {
        let firstInvalidValidation = validationExpressions?.first { !($0.compute(state: state) ?? false) }
        return firstInvalidValidation?.longMessageExpression?.compute(state: state) ?? firstInvalidValidation?.messageExpression?.compute(state: state)
    }
}
