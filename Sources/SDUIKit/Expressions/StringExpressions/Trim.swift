import Foundation

class Trim: StringExpression {
    
    let stringExpression: StringExpression

    required init(object: JSONObject, registrar: Registrar) {
        stringExpression = registrar.parseStringExpression(object: object["string"])!
        super.init(object: object, registrar: registrar)
    }
    
    override func compute(state: State) -> String? {
        guard let string = stringExpression.compute(state: state) else { return nil }
        return string.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
