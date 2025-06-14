import SwiftUI

struct StackView<Content: View>: View {
    
    @Bindable var stack: Stack
    @ViewBuilder let content: Content
    
    var body: some View {
        content
        .sheet(item: $stack.presentedStack) { aStack in
            VisualComponentView(aStack)
        }
        #if os(macOS)
        .sheet(isPresented: $stack.overlay)
        {
            
            ZStack {
                SwiftUI.ProgressView()
                    .scaleEffect(3)
            }
            .presentationBackground(Color.gray.opacity(0.4))
        }
        #else
        .fullScreenCover(isPresented: $stack.overlay)
        {
            
            ZStack {
                SwiftUI.ProgressView()
                    .scaleEffect(3)
            }
            .presentationBackground(Color.gray.opacity(0.4))
        }
        #endif
        
    }
}
