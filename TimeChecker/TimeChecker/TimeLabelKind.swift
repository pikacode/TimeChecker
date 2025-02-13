//
//  TimeLabelKind.swift
//  TimeChecker
//
//  Created by u.shinchen@outlook.com on 2025/02/13.
//

import SwiftUI

enum TimeLabelKind {
    case start
    case end
    case point
    
    var text: String {
        switch self {
        case .start:
            return "開始時刻"
        case .end:
            return "終了時刻"
        case .point:
            return "ある時刻"
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .start, .end:
            return Color.green.opacity(0.3)
        case .point:
            return Color.blue.opacity(0.3)
        }
    }
    
    var borderColor: Color {
        switch self {
        case .start, .end:
            return Color.green
        case .point:
            return Color.blue
        }
    }
    
    var outRangColor: Color {
        switch self {
        case .start, .end:
            return Color.green.opacity(0.3)
        case .point:
            return Color.red.opacity(0.5)
        }
    }
    
    var outRangBorderColor: Color {
        switch self {
        case .start, .end:
            return Color.green
        case .point:
            return Color.red
        }
    }

}
