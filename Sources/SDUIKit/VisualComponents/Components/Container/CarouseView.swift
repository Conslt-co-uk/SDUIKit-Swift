import SwiftUI

struct CarouselView: View {
    
    var carousel: Carousel
    
    init(carousel: Carousel) {
        self.carousel = carousel
    }
    
    var body: some View {
        ContainerView(container: carousel) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: carousel.style.innerMargin ?? 8) {
                    ComponentsView(components: carousel.components)
                }
            }
        }
    }
}
