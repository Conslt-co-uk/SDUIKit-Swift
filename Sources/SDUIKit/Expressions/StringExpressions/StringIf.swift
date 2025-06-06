class StringIf: StringExpression {
    
    let conditionExpression: BooleanExpression
    let ifTrueExpression: StringExpression?
    let ifFalseExpression: StringExpression?
    
    
    required init(object: JSONObject, registrar: Registrar) {
        conditionExpression = registrar.parseBooleanExpression(object: object["condition"])!
        ifTrueExpression = registrar.parseStringExpression(object: object["ifTrue"])
        ifFalseExpression = registrar.parseStringExpression(object: object["ifFalse"])
        super.init(object: object, registrar: registrar)
    }
    
    override func compute(state: State) -> String? {
        let condition = conditionExpression.compute(state: state)
        if condition == true {
            return ifTrueExpression?.compute(state: state)
        } else if condition == false {
            return ifFalseExpression?.compute(state: state)
        } else {
            return nil
        }
    }
}
