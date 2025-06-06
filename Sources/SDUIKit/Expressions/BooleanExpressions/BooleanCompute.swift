class BooleanCompute: BooleanExpression {
    
    let operatorExpression: StringExpression
    let booleanExpressions: [BooleanExpression]
    
    required init(object: JSONObject, registrar: Registrar) {
        operatorExpression = registrar.parseStringExpression(object: object["type"])!
        booleanExpressions = registrar.parseBooleanExpressions(object: object["booleans"])!
        super.init(object: object, registrar: registrar)
    }
    
    override func compute(state: State) -> Bool? {
        guard let op = operatorExpression.compute(state: state) else { return nil }
        let booleans = booleanExpressions.compactMap { $0.compute(state: state) }
        if booleans.count != booleanExpressions.count { return nil }
        
        switch op {
        case "|", "||":
            return booleans.contains(true)
        case "&", "&&":
            return booleans.allSatisfy { $0 }
        default:
            fatalError("Unsupported boolean operator: \(op)")
        }
    }
}
