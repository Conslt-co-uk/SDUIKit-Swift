class Length: NumberExpression {
    
    let stringExpression: StringExpression
    
    required init(object: JSONObject, registrar: Registrar) {
        stringExpression = registrar.parseStringExpression(object: object["string"])!
        super.init(object: object, registrar: registrar)
    }
    
    override func compute(state: State) -> Double? {
        guard let string = stringExpression.compute(state: state) else { return nil }
        return Double(string.count)
    }
}
