import SwiftUI

struct ImageView: View {
    
    var image: SDUIImage
    
    init(image: SDUIImage) {
        self.image = image
    }
    
    var body: some View {
        HStack {
            if image.style.alignment == "left" || image.style.alignment == "center" {
                Spacer()
            }
            DownloadImageView(url: image.imageURL ?? URL(string: "unknown")!)
                .clipShape(RoundedRectangle(cornerRadius: self.image.style.borderRadius ?? 0))
                .padding(image.style.innerMargin ?? 0)
                .styled(self.image.style)
                .frame(width: CGFloat(image.style.width), height: CGFloat(image.style.height))
            if image.style.alignment == "right" || image.style.alignment == "center" {
                Spacer()
            }
        }
        .padding(.top, image.style.spaceBefore ?? 0)
        .padding(.bottom, image.style.spaceAfter ?? 0)
        .padding(.horizontal, image.style.margin ?? 0)
    }
}
