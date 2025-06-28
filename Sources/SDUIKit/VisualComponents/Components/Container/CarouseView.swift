import SwiftUI

struct CarouselView: View {
    
    var carousel: Carousel
    
    init(carousel: Carousel) {
        self.carousel = carousel
    }
    
    var body: some View {
        ContainerView(container: carousel) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: carousel.style.horizontalSpacing ?? 0) {
                    ComponentsView(components: carousel.components)
                }
            }
        }
    }
}
