class Round: NumberExpression {
    
    let numberExpression: NumberExpression
    
    required init(object: JSONObject, registrar: Registrar) {
        numberExpression = registrar.parseNumberExpression(object: object["number"])!
        super.init(object: object, registrar: registrar)
    }
    
    override func compute(state: State) -> Double? {
        guard let number = numberExpression.compute(state: state) else { return nil }
        return number.rounded()
    }
}
