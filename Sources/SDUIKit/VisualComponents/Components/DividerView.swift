import SwiftUI

struct DividerView: View {
    
    var divider: Divider
    
    @Environment(\.colorScheme) private var colorScheme
    
    init(divider: Divider) {
        self.divider = divider
    }
    
    var body: some View {
        SwiftUI.Divider()
            .frame(minHeight: divider.style.borderWidth ?? 1)
            .overlay {
                divider.style.borderColor.map { Color(sduiName: $0, darkMode: colorScheme == .dark) }
            }
            
        .styledMargin(divider.style)
        .padding(.leading, divider.leftMargin)
        .padding(.trailing, divider.rightMargin)
    }
}
