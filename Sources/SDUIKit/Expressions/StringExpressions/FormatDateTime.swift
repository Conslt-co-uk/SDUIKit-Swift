import Foundation

class FormatDate: StringExpression {
    
    let dateExpression: StringExpression?
    let timestampExpression: NumberExpression?
    let timeZoneExpression: StringExpression?

    let dateStyleExpression: StringExpression?
    let timeStyleExpression: StringExpression?
    let localeExpression: StringExpression?
    
    var dateFormatter = DateFormatter()
    
    required init(object: JSONObject, registrar: Registrar) {
        dateExpression = registrar.parseStringExpression(object: object["date"])
        timestampExpression = registrar.parseNumberExpression(object: object["timestamp"])
        timeZoneExpression = registrar.parseStringExpression(object: object["timeZone"])
        dateStyleExpression = registrar.parseStringExpression(object: object["dateStyle"])
        timeStyleExpression = registrar.parseStringExpression(object: object["timeStyle"])
        localeExpression = registrar.parseStringExpression(object: object["locale"])
        super.init(object: object, registrar: registrar)
    }
    
    override func compute(state: State) -> String? {
        var date: Date?
        if let dateString = dateExpression?.compute(state: state) {
            date = Date(ISO8601dateString: dateString)
        } else if let timestamp = timestampExpression?.compute(state: state) {
            date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        }
        guard let date else { return nil }
        let timeZoneString = timeZoneExpression?.compute(state: state)
        let dateStyle = dateStyleExpression?.compute(state: state)
        let timeStyle = timeStyleExpression?.compute(state: state)
        let locale = localeExpression?.compute(state: state)
        dateFormatter.timeZone = TimeZone(identifier: timeZoneString ?? TimeZone.current.identifier)
        dateFormatter.locale = Locale(identifier: locale ?? Locale.current.identifier)
        dateFormatter.dateStyle = {
            switch dateStyle {
            case "long":
                return .long
            case "medium":
                return .medium
            case "short":
                return .short
            default:
                return .none
            }
        } ()
        dateFormatter.timeStyle = {
            switch timeStyle {
            case "long":
                return .long
            case "medium":
                return .medium
            case "short":
                return .short
            default:
                return .none
            }
        } ()
        return dateFormatter.string(for: date)
    }
}
