import SwiftUI

struct StackView<Content: View>: View {
    
    @Bindable var stack: Stack
    @ViewBuilder let content: Content
    
    var body: some View {
        content
        .styled(stack.style)
        .styledMargin(stack.style)
        .sheet(item: $stack.presentedStack) { aStack in
            VisualComponentView(aStack)
        }
        .fullScreenCover(isPresented: $stack.overlay) {
            ZStack {
                SwiftUI.ProgressView()
                    .scaleEffect(3)
            }
            .presentationBackground(Color.gray.opacity(0.4))
        }
    }
}
