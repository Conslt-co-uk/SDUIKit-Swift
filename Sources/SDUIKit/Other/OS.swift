import Foundation

#if os(macOS)

import AppKit

@MainActor
class OS {
    
    static func copyToPasteboard(_ text: String?) {

        NSPasteboard.general.clearContents()
        if let text = text {
            NSPasteboard.general.setString(text, forType: .string)
        }
    }
    

    static func openURL(_ url: URL) {
        NSWorkspace.shared.open(url)
    }
    

}



#else

import UIKit

@MainActor
class OS {
    
    static func copyToPasteboard(_ text: String?) {
        #if !os(tvOS)
        UIPasteboard.general.string = text
        #endif
    }
    

    static func openURL(_ url: URL) {
        if  UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
        
    }
    

}

#endif
