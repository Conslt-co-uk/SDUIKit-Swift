class BooleanVariable: BooleanExpression {
    
    let variableExpression: StringExpression
    let defaultExpression: BooleanExpression
    
    required init(object: JSONObject, registrar: Registrar) {
        variableExpression = registrar.parseStringExpression(object: object["variable"])!
        defaultExpression = registrar.parseBooleanExpression(object: object["default"]) ?? BooleanConstant(constant: nil)
        super.init(object: object, registrar: registrar)
    }
    
    override func compute(state: State) -> Bool? {
        let variable = variableExpression.compute(state: state)
        return state.booleanValue(name: variable) ?? defaultExpression.compute(state: state)
    }
}
