import Foundation

class FormatNumber: StringExpression {
    
    let numberExpression: NumberExpression
    let currencyExpression: StringExpression?
    let groupingExpression: BooleanExpression?
    let minDecimals: NumberExpression?
    let maxDecimals: NumberExpression?
    let localeExpression: StringExpression?
    
    var numberFormatter = NumberFormatter()
    
    required init(object: JSONObject, registrar: Registrar) {
        numberExpression = registrar.parseNumberExpression(object: object["number"])!
        currencyExpression = registrar.parseStringExpression(object: object["currency"])
        groupingExpression = registrar.parseBooleanExpression(object: object["grouping"])
        minDecimals = registrar.parseNumberExpression(object: object["minDecimals"])
        maxDecimals = registrar.parseNumberExpression(object: object["maxDecimals"])
        localeExpression = registrar.parseStringExpression(object: object["locale"])
        super.init(object: object, registrar: registrar)
    }
    
    override func compute(state: State) -> String? {
        guard let number = numberExpression.compute(state: state) else { return nil }
        let currency = currencyExpression?.compute(state: state)
        let isGroupingEnabled = groupingExpression?.compute(state: state) ?? false
        let minDecimals = Int(minDecimals?.compute(state: state))
        let maxDecimals = Int(maxDecimals?.compute(state: state))
        let locale = localeExpression?.compute(state: state)
        
        numberFormatter.minimumFractionDigits = minDecimals ?? 0
        numberFormatter.maximumFractionDigits = maxDecimals ?? 0
        numberFormatter.currencyCode = currency
        numberFormatter.usesGroupingSeparator = isGroupingEnabled
        numberFormatter.locale = Locale(identifier: locale ?? Locale.current.identifier)
        
        return numberFormatter.string(from: NSNumber(value: number))
        
    }
}
