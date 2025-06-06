//
//  DynamicTypeSize Extension.swift
//  SDUIiOS
//
//  Created by Philippe Robin on 31/05/2025.
//

import SwiftUI

extension DynamicTypeSize {
    
    var multiplier: CGFloat {
        switch self {
        case .xSmall: return 0.82
        case .small: return 0.88
        case .medium: return 1.0
        case .large: return 1.12
        case .xLarge: return 1.23
        case .xxLarge: return 1.35
        case .xxxLarge: return 1.47
        case .accessibility1: return 1.61
        case .accessibility2: return 1.78
        case .accessibility3: return 1.95
        case .accessibility4: return 2.11
        case .accessibility5: return 2.29
        @unknown default: return 1.0
        }
    }
    
}
