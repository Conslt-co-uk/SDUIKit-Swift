import SwiftUI

struct ResponsiveView: View {
    
    var responsive: Responsive
    
    init(responsive: Responsive) {
        self.responsive = responsive
    }
    
    var body: some View {
        ContainerView(container: responsive) {
            if responsive.vertical {
                VStack(spacing: responsive.style.verticalSpacing ?? 0) {
                    ComponentsView(components: responsive.components)
                }
                
            } else {
                HStack(spacing: responsive.style.horizontalSpacing ?? 0) {
                    ComponentsView(components: responsive.components)
                }.frame(minWidth: responsive.responsiveWidth)

            }
        }
    }
}
