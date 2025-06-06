
class NumberConstant: NumberExpression {
    
    let constant: Double?

    required init(object: JSONObject, registrar: Registrar) {
        constant = object["value"] as? Double
        super.init(object: object, registrar: registrar)
    }
    
    init(constant: Double?) {
        self.constant = constant
        super.init(object: [:], registrar: Registrar())
    }
    
    override func compute(state: State) -> Double? {
        return constant
    }
}
