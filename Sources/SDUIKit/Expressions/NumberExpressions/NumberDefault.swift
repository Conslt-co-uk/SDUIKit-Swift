class NumberDefault: NumberExpression {
    
    let numberExpressions: [NumberExpression]
    let defaultExpression: NumberExpression
    
    required init(object: JSONObject, registrar: Registrar) {
        numberExpressions = registrar.parseNumberExpressions(object: object["numbers"])!
        defaultExpression = registrar.parseNumberExpression(object: object["default"])!
        super.init(object: object, registrar: registrar)
    }
    
    override func compute(state: State) -> Double? {
        let defaultValue = defaultExpression.compute(state: state)
        let numbers = numberExpressions.compactMap { $0.compute(state: state) }
        return numbers.first ?? defaultValue
    }
}
