import SwiftUI

struct ProgressView: View {
    
    var progress: Progress
    
    init(progress: Progress) {
        self.progress = progress
    }
    
    var body: some View {
        Group {
            if let title = progress.title {
                SwiftUI.ProgressView(value: progress.progress, total: 1) {
                    Text(title)
                        .styledText(progress.style)
                }
            } else {
                SwiftUI.ProgressView(value: progress.progress)
            }
        }
        .styled(progress.style)
        .styledMargin(progress.style)
    }
}
