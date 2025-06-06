
class StringConstant: StringExpression {
    
    let constant: String?

    required init(object: JSONObject, registrar: Registrar) {
        constant = object["value"] as? String
        super.init(object: object, registrar: registrar)
    }
    
    init(constant: String?) {
        self.constant = constant
        super.init(object: [:], registrar: Registrar())
    }
    
    override func compute(state: State) -> String? {
        return constant
    }
}
