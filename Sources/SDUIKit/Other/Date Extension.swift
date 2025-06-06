import Foundation


let ISO8601timeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    formatter.calendar = Calendar(identifier: .gregorian)
    return formatter
}()

let ISO8601dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.calendar = Calendar(identifier: .gregorian)
    return formatter
}()

extension Date {
    
    var ISO8601timeString: String {
        return ISO8601timeFormatter.string(from: self)
    }
    
    init?(ISO8601timeString string: String?) {
        if let string, let date = ISO8601timeFormatter.date(from: string) {
            self = date
        } else {
            return nil
        }
    }
    
    var ISO8601dateString: String {
        return ISO8601dateFormatter.string(from: self)
    }
    
    init?(ISO8601dateString string: String?) {
        if let string, let date = ISO8601dateFormatter.date(from: string) {
            self = date
        } else {
            return nil
        }
    }
}
