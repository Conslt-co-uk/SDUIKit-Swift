class NumberCompute: NumberExpression {
    
    let operatorExpression: StringExpression
    let numberExpressions: [NumberExpression]
    
    required init(object: JSONObject, registrar: Registrar) {
        operatorExpression = registrar.parseStringExpression(object: object["type"])!
        numberExpressions = registrar.parseNumberExpressions(object: object["numbers"])!
        super.init(object: object, registrar: registrar)
    }
    
    override func compute(state: State) -> Double? {
        guard let op = operatorExpression.compute(state: state) else { return nil }
        let numbers = numberExpressions.compactMap { $0.compute(state: state) }
        if numbers.count != numberExpressions.count { return nil }
        
        switch op {
        case "+", "plus":
            return numbers.reduce(0, +)
        case "-", "minus":
            return numbers.dropFirst().reduce(numbers[0], -)
        case "*", "multiply":
            return numbers.reduce(1, *)
        case "/", "divide":
            return numbers.dropFirst().reduce(numbers[0], /)
        case "min":
            return numbers.min()
        case "max":
            return numbers.max()
        default:
            return nil
        }
    }
}
