class BooleanDefault: BooleanExpression {
    
    let booleanExpressions: [BooleanExpression]
    let defaultExpression: BooleanExpression
    
    required init(object: JSONObject, registrar: Registrar) {
        booleanExpressions = registrar.parseBooleanExpressions(object: object["booleans"])!
        defaultExpression = registrar.parseBooleanExpression(object: object["default"])!
        super.init(object: object, registrar: registrar)
    }
    
    override func compute(state: State) -> Bool? {
        let defaultValue = defaultExpression.compute(state: state)
        let booleans = booleanExpressions.compactMap { $0.compute(state: state) }
        return booleans.first ?? defaultValue
    }
}
