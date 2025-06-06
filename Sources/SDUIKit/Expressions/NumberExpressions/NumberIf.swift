class NumberIf: NumberExpression {
    
    let conditionExpression: BooleanExpression
    let ifTrueExpression: NumberExpression?
    let ifFalseExpression: NumberExpression?
    
    
    required init(object: JSONObject, registrar: Registrar) {
        conditionExpression = registrar.parseBooleanExpression(object: object["condition"])!
        ifTrueExpression = registrar.parseNumberExpression(object: object["ifTrue"])
        ifFalseExpression = registrar.parseNumberExpression(object: object["ifFalse"])
        super.init(object: object, registrar: registrar)
    }
    
    override func compute(state: State) -> Double? {
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
