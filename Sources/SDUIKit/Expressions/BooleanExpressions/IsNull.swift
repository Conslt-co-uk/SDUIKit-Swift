class IsNull: BooleanExpression {
    
    let booleanExpression: BooleanExpression?
    let numberExpression: NumberExpression?
    let stringExpression: StringExpression?

    required init(object: JSONObject, registrar: Registrar) {
        booleanExpression = registrar.parseBooleanExpression(object: object["boolean"])
        numberExpression = registrar.parseNumberExpression(object: object["number"])
        stringExpression = registrar.parseStringExpression(object: object["string"])
        super.init(object: object, registrar: registrar)
    }
    
    override func compute(state: State) -> Bool? {
        if let booleanExpression {
            return booleanExpression.compute(state: state) == nil
        }
        if let numberExpression {
            return numberExpression.compute(state: state) == nil
        }
        if let stringExpression {
            return stringExpression.compute(state: state) == nil
        }
        return nil
    }
}
