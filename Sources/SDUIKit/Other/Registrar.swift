//
//  Registrar.swift
//  SDUIiOS
//
//  Created by Philippe Robin on 28/05/2025.
//

@MainActor
public class Registrar {
    
    private var appTypes: [String: App.Type] = [:]
    private var stackTypes: [String: Stack.Type] = [:]
    private var screenTypes: [String: Screen.Type] = [:]
    private var componentTypes: [String: Component.Type] = [:]
    private var actionTypes: [String: Action.Type] = [:]
    private var booleanExpressionTypes: [String: BooleanExpression.Type] = [:]
    private var numberExpressionTypes: [String: NumberExpression.Type] = [:]
    private var stringExpressionTypes: [String: StringExpression.Type] = [:]
    
    public init() {
        appTypes["classic"] = ClassicApp.self
        
        stackTypes["navigation"] = Navigation.self
        stackTypes["tab"] = TabStack.self
        stackTypes["split"] = SplitStack.self
        
        screenTypes["form"] = Form.self
        
        componentTypes["card"] = Card.self
        componentTypes["combo"] = Combo.self
        componentTypes["flow"] = Flow.self
        componentTypes["responsive"] = Responsive.self
        componentTypes["carousel"] = Carousel.self
        componentTypes["paragraph"] = Paragraph.self
        componentTypes["textField"] = SDUITextField.self
        componentTypes["passwordField"] = PasswordField.self
        componentTypes["selectField"] = SelectField.self
        componentTypes["dateField"] = DateField.self
        componentTypes["timeField"] = TimeField.self
        componentTypes["switch"] = SwitchField.self
        componentTypes["radioField"] = RadioField.self
        componentTypes["button"] = Button.self
        componentTypes["divider"] = Divider.self
        componentTypes["progress"] = Progress.self
        componentTypes["image"] = SDUIImage.self
        componentTypes["menuItem"] = MenuItem.self
        
        actionTypes["alert"] = Alert.self
        actionTypes["confirm"] = Confirm.self
        actionTypes["if"] = IfAction.self
        actionTypes["copy"] = Copy.self
        actionTypes["updateBoolean"] = UpdateBoolean.self
        actionTypes["updateNumber"] = UpdateNumber.self
        actionTypes["updateString"] = UpdateString.self
        actionTypes["fetch"] = Fetch.self
        actionTypes["wait"] = Wait.self
        actionTypes["back"] = Back.self
        actionTypes["push"] = Push.self
        actionTypes["close"] = Close.self
        actionTypes["showDetail"] = ShowDetail.self
        actionTypes["present"] = Present.self
        actionTypes["getLocation"] = GetLocation.self
        actionTypes["openURL"] = OpenURL.self
        actionTypes["replaceScreen"] = ReplaceScreen.self
        actionTypes["replaceApp"] = ReplaceApp.self
        actionTypes["validateScreen"] = ValidateScreen.self
        actionTypes["callback"] = Callback.self
        
        booleanExpressionTypes["constant"] = BooleanConstant.self
        booleanExpressionTypes["variable"] = BooleanVariable.self
        booleanExpressionTypes["default"] = BooleanDefault.self
        booleanExpressionTypes["??"] = BooleanDefault.self
        booleanExpressionTypes["if"] = BooleanIf.self
        booleanExpressionTypes["!"] = Not.self
        booleanExpressionTypes["not"] = Not.self
        booleanExpressionTypes["|"] = BooleanCompute.self
        booleanExpressionTypes["||"] = BooleanCompute.self
        booleanExpressionTypes["&"] = BooleanCompute.self
        booleanExpressionTypes["&&"] = BooleanCompute.self
        booleanExpressionTypes["="] = Compare.self
        booleanExpressionTypes["=="] = Compare.self
        booleanExpressionTypes["!="] = Compare.self
        booleanExpressionTypes["<>"] = Compare.self
        booleanExpressionTypes["<"] = Compare.self
        booleanExpressionTypes["smaller"] = Compare.self
        booleanExpressionTypes[">"] = Compare.self
        booleanExpressionTypes["greater"] = Compare.self
        booleanExpressionTypes["<="] = Compare.self
        booleanExpressionTypes["smallerOrEqual"] = Compare.self
        booleanExpressionTypes[">="] = Compare.self
        booleanExpressionTypes["greaterOrEqual"] = Compare.self
        booleanExpressionTypes["regex"] = Regex.self
        booleanExpressionTypes["isNull"] = IsNull.self
        booleanExpressionTypes["platform"] = BooleanPlatform.self
        
        numberExpressionTypes["constant"] = NumberConstant.self
        numberExpressionTypes["variable"] = NumberVariable.self
        numberExpressionTypes["default"] = NumberDefault.self
        numberExpressionTypes["??"] = NumberDefault.self
        numberExpressionTypes["if"] = NumberIf.self
        numberExpressionTypes["+"] = NumberCompute.self
        numberExpressionTypes["plus"] = NumberCompute.self
        numberExpressionTypes["-"] = NumberCompute.self
        numberExpressionTypes["minus"] = NumberCompute.self
        numberExpressionTypes["*"] = NumberCompute.self
        numberExpressionTypes["multiply"] = NumberCompute.self
        numberExpressionTypes["/"] = NumberCompute.self
        numberExpressionTypes["divide"] = NumberCompute.self
        numberExpressionTypes["min"] = NumberCompute.self
        numberExpressionTypes["max"] = NumberCompute.self
        numberExpressionTypes["round"] = Round.self
        numberExpressionTypes["length"] = Length.self
        numberExpressionTypes["platform"] = NumberPlatform.self
        
        stringExpressionTypes["constant"] = StringConstant.self
        stringExpressionTypes["variable"] = StringVariable.self
        stringExpressionTypes["default"] = StringDefault.self
        stringExpressionTypes["??"] = StringDefault.self
        stringExpressionTypes["if"] = StringIf.self
        stringExpressionTypes["concat"] = Concat.self
        stringExpressionTypes["trim"] = Trim.self
        stringExpressionTypes["formatDate"] = FormatDate.self
        stringExpressionTypes["formatNumber"] = FormatNumber.self
        stringExpressionTypes["platform"] = StringPlatform.self
    }
    
    func parseApp(object: JSONValue?) -> App? {
        guard let object = object as? JSONObject else { return nil }
        let typeName = object["type"] as? String ?? "classic"
        let aType = appTypes[typeName]!
        return aType.init(object: object, registrar: self)
    }
    
    func parseStack(object: JSONValue?, state: State, app: App) -> Stack? {
        guard let object = object as? JSONObject else { return nil }
        let typeName = object["type"] as? String ?? "navigation"
        let aType = stackTypes[typeName]!
        return aType.init(object: object, app: app, registrar: self)
    }
    
    func parseScreen(object: JSONValue?, stack: Stack, state: State) -> Screen? {
        guard let object = object as? JSONObject else { return nil }
        let typeName = object["type"] as? String ?? "form"
        let aType = screenTypes[typeName]!
        return aType.init(object: object, stack: stack, state: state, registrar: self)
    }
    
    func parseComponent(object: JSONValue?, screen: Screen) -> Component? {
        if let object = object as? String {
            if object == "---" {
                return Divider(object: [:], screen: screen, registrar: self)
            }
            return Paragraph(object: ["spans": object], screen: screen, registrar: self)
        }
        guard let object = object as? JSONObject else { return nil }
        let typeName = object["type"] as! String
        let aType = componentTypes[typeName]!
        return aType.init(object: object, screen: screen, registrar: self)
    }
    
    func parseComponents(object: JSONValue?, screen: Screen) -> [Component]? {
        guard let object = object else { return nil }
        guard let array = object as? [JSONValue] else {
            return [parseComponent(object: object, screen: screen)].compactMap { $0 }
        }
        return array.compactMap { parseComponent(object: $0, screen: screen) }
    }
    
    func parseSpan(object: JSONValue?, screen: Screen) -> Span? {
        guard let object = object else { return nil }
        if let _ = parseStringExpression(object: object) {
            return Span(object: ["text": object], state: screen.state, registrar: self, stylesheet: screen.stack!.app!.stylesheet)
        }
        if let string = object as? String {
            return Span(object: ["text": string], state: screen.state, registrar: self, stylesheet: screen.stack!.app!.stylesheet)
        }
        guard let object = object as? JSONObject else { return nil }
        return Span(object: object, state: screen.state, registrar: self, stylesheet: screen.stack!.app!.stylesheet)
    }
    
    func ParseSpans(object: JSONValue?, screen: Screen) -> [Span]? {
        guard let object = object else { return nil }
        guard let array = object as? [JSONValue] else {
            return [parseSpan(object: object, screen: screen)].compactMap { $0 }
        }
        return array.compactMap { parseSpan(object: $0, screen: screen) }
    }
    
    func parseAction(object: JSONValue?) -> Action? {
        guard let object = object as? JSONObject else { return nil }
        let typeName = object["type"] as! String
        let aType = actionTypes[typeName]!
        return aType.init(object: object, registrar: self)
    }
    
    func parseActions(object: JSONValue?) -> [Action]? {
        guard let object else { return nil }
        guard let array = object as? [JSONObject] else {
            return [parseAction(object: object)!]
        }
        return array.compactMap { parseAction(object: $0) }
    }
    
    func parseBooleanExpression(object: JSONValue?) -> BooleanExpression? {
        if let constant = object as? Bool {
            return BooleanConstant(constant: constant)
        }
        if let string = object as? String, string.hasPrefix("$"), string.hasSuffix("$"), string.count > 2 {
            let variable = string.trimmingCharacters(in: .init(charactersIn: "$"))
            return BooleanVariable(object: ["variable": variable], registrar: self)
        }
        guard let object = object as? JSONObject else { return nil }
        let typeName = object["type"] as! String
        let aType = booleanExpressionTypes[typeName]!
        return aType.init(object: object, registrar: self)
    }
    
    func parseBooleanExpressions(object: JSONValue?) -> [BooleanExpression]? {
        if let array = object as? [JSONValue] {
            return array.compactMap { parseBooleanExpression(object: $0) }
        }
        return [parseBooleanExpression(object: object)].compactMap { $0 }
    }
    
    func parseNumberExpression(object: JSONValue?) -> NumberExpression? {
        guard let object else { return nil }
        if let constant = object as? Int {
            return NumberConstant(constant: Double(constant))
        }
        if let constant = object as? Double {
            return NumberConstant(constant: constant)
        }
        if let string = object as? String, string.hasPrefix("$"), string.hasSuffix("$"), string.count > 2 {
            let variable = string.trimmingCharacters(in: .init(charactersIn: "$"))
            return NumberVariable(object: ["variable": variable], registrar: self)
        }
        guard let object = object as? JSONObject else { return nil }
        let typeName = object["type"] as! String
        let aType = numberExpressionTypes[typeName]!
        return aType.init(object: object, registrar: self)
    }
    
    func parseNumberExpressions(object: JSONValue?) -> [NumberExpression]? {
        if let array = object as? [JSONValue] {
            return array.compactMap { parseNumberExpression(object: $0) }
        }
        return [parseNumberExpression(object: object)].compactMap { $0 }
    }
    
    func parseStringExpression(object: JSONValue?) -> StringExpression? {
        if let string = object as? String, string.hasPrefix("$"), string.hasSuffix("$"), string.count > 2 {
            let variable = string.trimmingCharacters(in: .init(charactersIn: "$"))
            return StringVariable(object: ["variable": variable], registrar: self)
        }
        if let constant = object as? String {
            return StringConstant(constant: constant)
        }
        guard let object = object as? JSONObject else { return nil }
        guard let typeName = object["type"] as? String else { return nil }
        guard let aType = stringExpressionTypes[typeName] else { return nil }
        return aType.init(object: object, registrar: self)
    }
    
    func parseStringExpressions(object: JSONValue?) -> [StringExpression]? {
        if let array = object as? [JSONValue] {
            return array.compactMap { parseStringExpression(object: $0) }
        }
        return [parseStringExpression(object: object)].compactMap { $0 }
    }
}
