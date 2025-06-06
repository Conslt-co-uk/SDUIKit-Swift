import SwiftUI

struct ImageView: View {
    
    var image: SDUIImage
    
    init(image: SDUIImage) {
        self.image = image
    }
    
    var body: some View {
        HStack {
            if image.style.alignment != "right" {
                Spacer()
            }
            AsyncImage(url: URL(string: image.image)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: self.image.style.borderRadius ?? 0))
                        .styled(self.image.style)
                case .failure(_):
                    Image(systemName: "photo.badge.exclamationmark")
                        .foregroundColor(.gray)
                case .empty:
                    SwiftUI.ProgressView()
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: CGFloat(image.style.width), height: CGFloat(image.style.height))
            if image.style.alignment != "left" {
                Spacer()
            }
        }
        
        .padding(.top, image.style.spaceBefore ?? 0)
        .padding(.bottom, image.style.spaceAfter ?? 0)
        .padding(.horizontal, image.style.margin ?? 0)
    }
}
