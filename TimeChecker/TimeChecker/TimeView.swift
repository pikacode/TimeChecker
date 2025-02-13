//
//  TimeView.swift
//  TimeChecker
//
//  Created by u.shinchen@outlook.com on 2025/02/13.
//
import SwiftUI

struct TimeSliderView: View {
    
    //保存する
    @AppStorage("startHour") private var startHour = 3
    @AppStorage("endHour")   private var endHour   = 12
    @AppStorage("pointHour") private var pointHour = 6
    
    // 判断条件
    // 結果は自動的に生成するため、保存の必要はありません。
    func isContain(_ hour: Int) -> Bool {
        if startHour < endHour {
            return hour >= startHour && hour < endHour
        } else {
            return hour >= startHour || hour < endHour
        }
    }

    let minHour = Constants.minHour
    let maxHour = Constants.maxHour
    let stepHeight = Constants.stepHeight

    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                
                HStack {
                    ZStack {
                        TimeLabel(kind: .start, hour: $startHour)
                        TimeLabel(kind: .end, hour: $endHour)
                        TimeLabel(kind: .point, hour: $pointHour, inRange: isContain(pointHour))
                        
                        HStack {
                            VStack(spacing: 0) {
                                ForEach(minHour...maxHour, id: \.self) { hour in
                                    Text("\(hour)時")
                                        .frame(width: 70, height: stepHeight)
                                        .background(getBackgroundColor(hour))
                                        .background(Color.white)
                                }
                                .border(Color.gray, width: 1)
                            }
                            Spacer()
                        }
                        
                    }
                    .frame(height: stepHeight * CGFloat(maxHour - minHour + 1))
                    .padding(.leading, 70)
                    
                }
                .ignoresSafeArea(edges: .all)
                       
            }
                        
            Text("ラベルを「上下」にドラッグしてください。")
                .padding(.top)
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.1))
                .font(.system(size: 15))
            
        }
    }
    
    func getBackgroundColor(_ hour: Int) -> Color {
        if hour == pointHour {
            if isContain(hour) {
                return TimeLabelKind.point.backgroundColor
            } else {
                return TimeLabelKind.point.outRangColor
            }
        } else if isContain(hour) {
            return TimeLabelKind.start.backgroundColor
        } else {
            return Color.gray.opacity(0.1)
        }
    }
    
}


#Preview {
    TimeSliderView()
}
