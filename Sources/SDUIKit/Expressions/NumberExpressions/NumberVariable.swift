class NumberVariable: NumberExpression {
    
    let variableExpression: StringExpression
    let defaultExpression: NumberExpression
    
    required init(object: JSONObject, registrar: Registrar) {
        variableExpression = registrar.parseStringExpression(object: object["variable"])!
        defaultExpression = registrar.parseNumberExpression(object: object["default"]) ?? NumberConstant(constant: nil)
        super.init(object: object, registrar: registrar)
    }
    
    override func compute(state: State) -> Double? {
        let variable = variableExpression.compute(state: state)
        return state.numberValue(name: variable) ?? defaultExpression.compute(state: state)
    }
}
