import SwiftUI

struct BackgroundView: View {
    
    let string: String?
    
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        if let string {
            if string.contains(",") {
                LinearGradient(string: string, darkMode: colorScheme == .dark)
            } else {
                Color(hex: string, darkMode: colorScheme == .dark)
            }
        } else {
            Color.clear
        }
    }
    
}
