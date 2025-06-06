class Not: BooleanExpression {
    
    let booleanExpression: BooleanExpression

    required init(object: JSONObject, registrar: Registrar) {
        booleanExpression = registrar.parseBooleanExpression(object: object["boolean"])!
        super.init(object: object, registrar: registrar)
    }
    
    override func compute(state: State) -> Bool? {
        if let value = booleanExpression.compute(state: state) {
            return !value
        }
        return nil
    }
}
