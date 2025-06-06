class StringVariable: StringExpression {
    
    let variableExpression: StringExpression
    let defaultExpression: StringExpression
    
    required init(object: JSONObject, registrar: Registrar) {
        variableExpression = registrar.parseStringExpression(object: object["variable"])!
        defaultExpression = registrar.parseStringExpression(object: object["default"]) ?? StringConstant(constant: nil)
        super.init(object: object, registrar: registrar)
    }
    
    override func compute(state: State) -> String? {
        let variable = variableExpression.compute(state: state)
        return state.stringValue(name: variable) ?? defaultExpression.compute(state: state)
    }
}
