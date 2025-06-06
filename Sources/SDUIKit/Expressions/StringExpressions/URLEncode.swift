import Foundation

class URLEncode: StringExpression {
    
    let stringExpression: StringExpression

    required init(object: JSONObject, registrar: Registrar) {
        stringExpression = registrar.parseStringExpression(object: object["string"])!
        super.init(object: object, registrar: registrar)
    }
    
    override func compute(state: State) -> String? {
        guard let string = stringExpression.compute(state: state) else { return nil }
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "!*'();:@&=+$,/?#[]")
        return string.addingPercentEncoding(withAllowedCharacters: allowed)
    }
}
