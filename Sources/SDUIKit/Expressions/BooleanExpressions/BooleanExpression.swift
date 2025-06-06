import Foundation

class BooleanExpression: Expression {
    
    let messageExpression: StringExpression?
    
    required init(object: JSONObject, registrar: Registrar) {
        messageExpression = registrar.parseStringExpression(object: object["message"])
        super.init(object: object, registrar: registrar)
    }
    
    func compute(state: State) -> Bool? {
        return nil
    }
    
}
