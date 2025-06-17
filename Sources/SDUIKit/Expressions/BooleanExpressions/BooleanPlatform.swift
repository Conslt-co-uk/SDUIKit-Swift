class BooleanPlatform: BooleanExpression {
    
    let valueExpression: BooleanExpression?

    required init(object: JSONObject, registrar: Registrar) {
        valueExpression = registrar.parseBooleanExpression(object: object["iOS"] as? JSONObject)
        super.init(object: object, registrar: registrar)
    }
    
    override func compute(state: State) -> Bool? {
        return valueExpression?.compute(state: state)
    }
}
