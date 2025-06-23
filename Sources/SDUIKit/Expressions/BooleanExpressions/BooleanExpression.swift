import Foundation

class BooleanExpression: Expression {
    
    let longMessageExpression: StringExpression?
    let messageExpression: StringExpression?
    
    required init(object: JSONObject, registrar: Registrar) {
        messageExpression = registrar.parseStringExpression(object: object["message"])
        longMessageExpression = registrar.parseStringExpression(object: object["longMessage"])
        super.init(object: object, registrar: registrar)
    }
    
    func compute(state: State) -> Bool? {
        return nil
    }
    
}
