import SwiftUI

struct DividerView: View {
    
    var divider: Divider
    
    init(divider: Divider) {
        self.divider = divider
    }
    
    var body: some View {
        SwiftUI.Divider()
        .styled(divider.style)
        .styledMargin(divider.style)
        .padding(.leading, divider.leftMargin)
        .padding(.trailing, divider.rightMargin)
    }
}
