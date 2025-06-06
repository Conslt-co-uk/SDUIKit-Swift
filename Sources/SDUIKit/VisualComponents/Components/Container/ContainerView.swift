import SwiftUI

struct ContainerView<Content: View>: View {
    
    let container: Container
    @ViewBuilder let content: Content
    
    var body: some View {
        content
            .styled(container.style)
            .styledMargin(container.style)
        
    }
}
