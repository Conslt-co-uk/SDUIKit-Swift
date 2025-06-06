import SwiftUI

struct CardView: View {
    
    var card: Card
    
    init(card: Card) {
        self.card = card
    }
    
    var body: some View {
        ContainerView(container: card) {
            VStack(spacing: 0) {
                ComponentsView(components: card.components)
            }
        }
    }
}
