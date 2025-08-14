import SwiftUI

struct TabItemView: View {
    
    @Bindable var tab: TabItem
    
    func resizeImage(_ image: UIImage, to size: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: size))
        }
    }
    
    func imageFromDataURL(_ url: URL) -> UIImage {
        let data = Data(base64Encoded: url.absoluteString.split(separator: ",").last.map(String.init) ?? "")!
        let uiImage = resizeImage(UIImage(data: data)!, to: CGSize(width: tab.image.style.width ?? 25, height: tab.image.style.height ?? 25))!
        return uiImage.withRenderingMode(.alwaysTemplate)
    }
    
    var body: some View {
        NavigationStack(path: $tab.path) {
            VisualComponentView(tab.screens.first!)
                .navigationDestination(for: Int.self) { index in
                    if tab.screens.count > index {
                        VisualComponentView(tab.screens[index])
                    }
                }
        }
        .tabItem {
            Label {
                Text(tab.title)
            } icon: {
                Image(uiImage: imageFromDataURL(tab.image.imageURL!))
            }
        }
        #if !os(tvOS)
        .badge(tab.badge ?? 0)
        #endif
        .tag(tab.name)
    }
}
