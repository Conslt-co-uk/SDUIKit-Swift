import SwiftUI
import Combine

public final class State: ObservableObject {
    
    @Published var strings: [String: String?] = [:]
    @Published var numbers: [String: Double?] = [:]
    @Published var booleans: [String: Bool?] = [:]
    
    public init(strings: [String : String?] = [:], numbers: [String : Double?] = [:], booleans: [String : Bool?] = [:]) {
        self.strings = strings
        self.numbers = numbers
        self.booleans = booleans
    }
    
    required init(object: JSONObject?) {
        guard let object = object else {
            self.strings = [:]
            self.numbers = [:]
            self.booleans = [:]
            return
        }
        if let strings = object["strings"] as? [String: String?] {
            self.strings = strings
        } else {
            self.strings = [:]
        }
        
        if let numbers = object["numbers"] as? [String: Double?] {
            self.numbers = numbers
        } else {
            self.numbers = [:]
        }
        
        if let booleans = object["booleans"] as? [String: Bool?] {
            self.booleans = booleans
        } else {
            self.booleans = [:]
        }
    }
    
    func stringValue(name: String?) -> String? { strings[name ?? ""] ?? nil }
    
    func numberValue(name: String?) -> Double? { numbers[name ?? ""] ?? nil }
    
    func booleanValue(name: String?) -> Bool? { booleans[name ?? ""] ?? nil }

    func stringBinding(name: String) -> Binding<String?> {
        return Binding {  [self] in
            return strings[name] ?? nil
        } set: { [self] value in
            strings[name] = value
        }
    }
    
    @MainActor
    func numberBinding(name: String) -> Binding<Double?> {
        return Binding {  [self] in
            return numbers[name] ?? nil
        } set: { [self] value in
            numbers[name] = value
        }
    }
    
    @MainActor
    func booleanBinding(name: String) -> Binding<Bool?> {
        return Binding {  [self] in
            return booleans[name] ?? nil
        } set: { [self] value in
            booleans[name] = value
        }
    }
    
    @MainActor
    func dateBinding(name: String) -> Binding<Date?> {
        return Binding<Date?> {
            if let result = self.strings[name], let string = result {
                return Date(ISO8601dateString: string)
            } else {
                return nil
            }
        } set: { newValue in
            self.strings[name] = newValue?.ISO8601dateString
        }
    }
    
    @MainActor
    func timeBinding(name: String) -> Binding<Date?> {
        return Binding<Date?> {
            if let result = self.strings[name], let string = result {
                return Date(ISO8601timeString: string)
            } else {
                return nil
            }
        } set: { newValue in
            self.strings[name] = newValue?.ISO8601timeString
        }
    }
    
    
    func copy() -> State {
        return State() // XXXX
    }

}
