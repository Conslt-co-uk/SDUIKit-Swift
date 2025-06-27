import SwiftUI

struct ResponsiveView: View {
    
    var responsive: Responsive
    
    init(responsive: Responsive) {
        self.responsive = responsive
    }
    
    var body: some View {
        ViewThatFits(in: .horizontal) {
            HStack(spacing: 0) {
                ComponentsView(components: responsive.components)
            }.frame(minWidth: responsive.responsiveWidth)
            VStack(spacing: 0) {
                ComponentsView(components: responsive.components)
            }
        }
    }
}
