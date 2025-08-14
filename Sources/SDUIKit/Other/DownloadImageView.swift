import SwiftUI
import SVGView
import PhotosUI

struct DownloadImageView: View  {
    
    let url: URL
    
    private enum DownloadState {
        case idle
        case failed(Error)
        case downloading
        case image(data: Data)
        case svg(data: Data)
    }

    @SwiftUI.State private var state: DownloadState = .idle
  
    init(url: URL) {
        self.url = url
    }
    
    var body: some View {
        Group {
            switch state {
            case .idle:
                Color.clear
            case .downloading:
                SwiftUI.ProgressView()
            case .image(data: let data):
                SwiftUI.Image(uiImage: UIImage(data: data)!)
                    .resizable()
                    .scaledToFit()
            case .svg(data: let data):
                SVGView(data: data)
            case .failed:
                SwiftUI.Image(systemName: "exclamationmark.triangle")
                    .foregroundColor(.secondary)
            }
        }.onAppear {
            start()
        }
        
    }
    
    func start() {
        switch state {
        case .idle, .failed(_):
            if let scheme = url.scheme, scheme == "data" {
                decodeDataURL(url: url)
            } else {
                Task.detached {
                    await fetch(url: url)
                }
            }
        default:
            return
        }
    }
    
    func decodeDataURL(url: URL) {
        do {
            let data = try Data(contentsOf: url)
            if url.absoluteString.contains("image/svg+xml") {
                state = .svg(data: data)
            } else {
                state = .image(data: data)
            }
        }
        catch {
            state = .failed(error)
        }
    }
    
    func fetch(url: URL) async {
        do {
            let request = URLRequest(url: url)
            let (data, response) = try await URLSession.shared.data(for: request)
            let statusCode = (response as! HTTPURLResponse).statusCode
            guard statusCode >= 200 && statusCode < 300 else {
                state = .failed(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: HTTPURLResponse.localizedString(forStatusCode: statusCode)]))
                return
            }
            if response.mimeType == "image/svg+xml" {
                state = .svg(data: data)
            } else {
                state = .image(data: data)
            }
        }
        catch {
            state = .failed(error)
        }
    }
        
}
