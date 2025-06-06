class BooleanIf: BooleanExpression {
    
    let conditionExpression: BooleanExpression
    let ifTrueExpression: BooleanExpression?
    let ifFalseExpression: BooleanExpression?
    
    required init(object: JSONObject, registrar: Registrar) {
        conditionExpression = registrar.parseBooleanExpression(object: object["condition"])!
        ifTrueExpression = registrar.parseBooleanExpression(object: object["ifTrue"])
        ifFalseExpression = registrar.parseBooleanExpression(object: object["ifFalse"])
        super.init(object: object, registrar: registrar)
    }
    
    override func compute(state: State) -> Bool? {
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
