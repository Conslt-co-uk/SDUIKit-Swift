import SwiftUI

extension Color {
    
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let alpha, red, green, blue: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (alpha, red, green, blue) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (alpha, red, green, blue) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (alpha, red, green, blue) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (alpha, red, green, blue) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(red) / 255,
            green: Double(green) / 255,
            blue: Double(blue) / 255,
            opacity: Double(alpha) / 255
        )
    }
    
    init(hex: String, darkMode: Bool) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        if hex.contains("/") {
            if darkMode {
                self = Color(hex: String(hex.split(separator: "-").last ?? ""))
            } else {
                self = Color(hex: String(hex.split(separator: "-").first ?? ""))
            }
        } else {
            self = Color(hex: hex)
        }
    }
    
    init(sduiName: String?, darkMode: Bool, default: Color = .clear) {
        guard let sduiName else {
            self = `default`
            return
        }
        if sduiName.starts(with: "#") {
            self = Color(hex: sduiName, darkMode: darkMode)
        } else {
            self = Color(sduiName)
        }
    }
    
}
