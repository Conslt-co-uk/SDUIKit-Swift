
class BooleanConstant: BooleanExpression {
    
    let constant: Bool?

    required init(object: JSONObject, registrar: Registrar) {
        constant = object["value"] as? Bool
        super.init(object: object, registrar: registrar)
    }
    
    init(constant: Bool?) {
        self.constant = constant
        super.init(object: [:], registrar: Registrar())
    }
    
    override func compute(state: State) -> Bool? {
        return constant
    }
}
