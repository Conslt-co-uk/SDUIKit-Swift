class Regex: BooleanExpression {
    
    let regexExpression: StringExpression
    let stringExpression: StringExpression

    required init(object: JSONObject, registrar: Registrar) {
        regexExpression = registrar.parseStringExpression(object: object["regex"])!
        stringExpression = registrar.parseStringExpression(object: object["string"])!
        super.init(object: object, registrar: registrar)
    }
    
    override func compute(state: State) -> Bool? {
        guard let regex = regexExpression.compute(state: state) else  { return nil }
        guard let string = stringExpression.compute(state: state) else  { return nil }
        if let range = string.range(of: regex, options: .regularExpression, range: nil, locale: nil) {
            let rangeString = string[range]
            return string == rangeString
        } else {
            return false
        }
    }
}
