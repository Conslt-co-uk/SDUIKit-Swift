class NumberPlatform: NumberExpression {
    
    let valueExpression: NumberExpression?

    required init(object: JSONObject, registrar: Registrar) {
        valueExpression = registrar.parseNumberExpression(object: object["iOS"] as? JSONObject)
        super.init(object: object, registrar: registrar)
    }
    
    override func compute(state: State) -> Double? {
        return valueExpression?.compute(state: state)
    }
}

