class Compare: BooleanExpression {
    
    let comparatorExpression: StringExpression
    let booleanExpression1: BooleanExpression?
    let booleanExpression2: BooleanExpression?
    let numberExpression1: NumberExpression?
    let numberExpression2: NumberExpression?
    let stringExpression1: StringExpression?
    let stringExpression2: StringExpression?


    required init(object: JSONObject, registrar: Registrar) {
        comparatorExpression = registrar.parseStringExpression(object: object["type"])!
        booleanExpression1 = registrar.parseBooleanExpression(object: object["boolean1"])
        booleanExpression2 = registrar.parseBooleanExpression(object: object["boolean2"])
        numberExpression1 = registrar.parseNumberExpression(object: object["number1"])
        numberExpression2 = registrar.parseNumberExpression(object: object["number2"])
        stringExpression1 = registrar.parseStringExpression(object: object["string1"])
        stringExpression2 = registrar.parseStringExpression(object: object["string2"])
        super.init(object: object, registrar: registrar)
    }
    
    override func compute(state: State) -> Bool? {
        let comparator = comparatorExpression.compute(state: state)!
        if let boolean1 = booleanExpression1?.compute(state: state),
           let boolean2 = booleanExpression2?.compute(state: state) {
            switch comparator {
            case "=","==", "equal":
                return boolean1 == boolean2
            case "!=", "<>", "different":
                return boolean1 != boolean2
            default:
                return nil
            }
        }
        if let number1 = numberExpression1?.compute(state: state),
           let number2 = numberExpression2?.compute(state: state) {
            switch comparator {
            case "=","==", "equal":
                return number1 == number2
            case "!=", "<>", "different":
                return number1 != number2
            case ">", "greater":
                return number1 > number2
            case "<", "smaller":
                return number1 < number2
            case ">=", "greaterOrEqual":
                return number1 >= number2
            case "<=", "smallerOrEqual":
                return number1 <= number2
            default:
                return nil
            }
        }
        if let string1 = stringExpression1?.compute(state: state),
           let string2 = stringExpression2?.compute(state: state) {
            switch comparator {
            case "=","==", "equal":
                return string1 == string2
            case "!=", "<>", "different":
                return string1 != string2
            case ">", "greater":
                return string1 > string2
            case "<", "smaller":
                return string1 < string2
            case ">=", "greaterOrEqual":
                return string1 >= string2
            case "<=", "smallerOrEqual":
                return string1 <= string2
            default:
                return nil
            }
        }
        return nil
    }
}
