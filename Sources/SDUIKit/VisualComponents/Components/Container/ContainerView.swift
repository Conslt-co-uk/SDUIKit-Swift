import SwiftUI

struct ContainerView<Content: View>: View {
    
    let container: Container
    @ViewBuilder let content: Content
    
    var body: some View {
        content
            .padding(container.style.innerMargin ?? 0)
            .frame(width: CGFloat(container.style.width), height: CGFloat(container.style.height))
            .styled(container.style)
            .styledMargin(container.style)
        
    }
}
