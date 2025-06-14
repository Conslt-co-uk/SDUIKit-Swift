//
//  Gradient.swift
//  SDUIKit
//
//  Created by Philippe Robin on 12/06/2025.
//

import SwiftUI

extension LinearGradient {
    
    init(string: String, darkMode: Bool) {
        let elements = string.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
        if elements.first?.contains(":") ?? false {
            let stops: [Gradient.Stop] = elements.compactMap { element in
                let parts = element.split(separator: ":").map { $0.trimmingCharacters(in: .whitespaces) }
                guard parts.count == 2 else { return nil }
                let color = Color(hex: parts[0], darkMode: darkMode)
                let location: Double = Double(parts[1]) ?? 0
                return Gradient.Stop(color: color, location: location)
            }
            self.init(stops: stops, startPoint: .top, endPoint: .bottom)
        } else {
            let colors = elements.compactMap { Color(hex: $0, darkMode: darkMode) }
            self.init(colors: colors, startPoint: .top, endPoint: .bottom)
        }
    }
    
}
