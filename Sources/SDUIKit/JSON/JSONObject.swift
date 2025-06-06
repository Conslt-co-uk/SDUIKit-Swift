import Foundation

public typealias JSONObject = [String: JSONValue]

public protocol JSONValue {}
extension String:      JSONValue {}
extension Int:         JSONValue {}
extension Double:      JSONValue {}
extension Bool:        JSONValue {}
extension NSNull:      JSONValue {}
extension JSONObject:  JSONValue {}
extension [JSONValue]: JSONValue {}
