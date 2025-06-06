class Concat: StringExpression {
    
    let stringExpressions: [StringExpression]
    let separatorExpression: StringExpression?
    
    required init(object: JSONObject, registrar: Registrar) {
        stringExpressions = registrar.parseStringExpressions(object: object["strings"])!
        separatorExpression = registrar.parseStringExpression(object: object["separator"])
        super.init(object: object, registrar: registrar)
    }
    
    override func compute(state: State) -> String? {
        let strings = stringExpressions.compactMap { $0.compute(state: state) }
        let separator = separatorExpression?.compute(state: state) ?? ""
        guard strings.count == stringExpressions.count else { return nil }
        return strings.joined(separator: separator)
    }
}
