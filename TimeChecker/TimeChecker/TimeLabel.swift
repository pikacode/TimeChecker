//
//  TimeLabel.swift
//  TimeChecker
//
//  Created by u.shinchen@outlook.com on 2025/02/13.
//

import SwiftUI

struct TimeLabel: View {
    
    let kind: TimeLabelKind
    @Binding var hour: Int
    let minHour = 0
    let maxHour = 23
    let stepHeight = Constants.stepHeight
    
    var inRange: Bool = true

    @State private var dragOffset: CGFloat = 0 // 初期位置（デフォルトは中央位置）

    var body: some View {
        VStack {
            
            HStack(spacing: 0) {
                Rectangle()
                    .fill(getBackgroundColor())
                    .frame(width: 100, height: 4)
                
                Text("\(kind.text): \(hour)時")
                    .font(.system(size: 16))
                    .padding()
                    .background(getBackgroundColor())
                    .border(getBorderColor(), width: 1.5)
                    .background(Color.white)
                    .cornerRadius(4)
                    .frame(height: stepHeight)
                Spacer()
            }
            .offset(y: dragOffset)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        let newOffset = value.location.y
                        var newHour = Int((newOffset / stepHeight).rounded())
                        newHour = min(max(minHour, newHour), maxHour)
                        if newHour != hour {
                            hour = newHour
                            dragOffset = CGFloat(newHour - minHour) * stepHeight
                        }
                    }
                    .onEnded { _ in
                        // ドラッグ終了時に最近の刻みに自動調整
                        dragOffset = CGFloat(hour - minHour) * stepHeight
                    }
            )
            
            Spacer()
        }
        
        .onAppear {
            dragOffset = CGFloat(hour - minHour) * stepHeight
        }
    }
    
    func getBackgroundColor() -> Color {
        if kind == .point {
            if inRange {
                return kind.backgroundColor
            } else {
                return kind.outRangColor
            }
        } else {
            return kind.backgroundColor
        }
    }
    
    func getBorderColor() -> Color {
        if kind == .point {
            if inRange {
                return kind.borderColor
            } else {
                return kind.outRangBorderColor
            }
        } else {
            return kind.borderColor
        }
    }
    
}

#Preview {
    ZStack {
        TimeLabel(kind: .start, hour: .constant(1))
        TimeLabel(kind: .end, hour: .constant(5))
        TimeLabel(kind: .point, hour: .constant(10))
    }
}
