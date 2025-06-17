class StringPlatform: StringExpression {
    
    let valueExpression: StringExpression?

    required init(object: JSONObject, registrar: Registrar) {
        valueExpression = registrar.parseStringExpression(object: object["iOS"] as? JSONObject)
        super.init(object: object, registrar: registrar)
    }
    
    override func compute(state: State) -> String? {
        return valueExpression?.compute(state: state)
    }
}
