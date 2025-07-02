import Foundation

open class BooleanExpression: Expression {
    
    let longMessageExpression: StringExpression?
    let messageExpression: StringExpression?
    
    required public init(object: JSONObject, registrar: Registrar) {
        messageExpression = registrar.parseStringExpression(object: object["message"])
        longMessageExpression = registrar.parseStringExpression(object: object["longMessage"])
        super.init(object: object, registrar: registrar)
    }
    
    public func compute(state: State) -> Bool? {
        return nil
    }
    
}
