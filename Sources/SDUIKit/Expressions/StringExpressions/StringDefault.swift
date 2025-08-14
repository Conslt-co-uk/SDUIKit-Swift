class StringDefault: StringExpression {
    
    let stringExpressions: [StringExpression]
    let defaultExpression: StringExpression
    
    required init(object: JSONObject, registrar: Registrar) {
        stringExpressions = registrar.parseStringExpressions(object: object["strings"])!
        defaultExpression = registrar.parseStringExpression(object: object["default"])!
        super.init(object: object, registrar: registrar)
    }
    
    override func compute(state: State) -> String? {
        let defaultValue = defaultExpression.compute(state: state)
        let strings = stringExpressions.compactMap { $0.compute(state: state) }
        return strings.first ?? defaultValue
    }
}
