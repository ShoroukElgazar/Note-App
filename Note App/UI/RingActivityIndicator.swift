//
//  RingActivityIndicator.swift
//  Note App
//
//  Created by Shorouk Mohamed on 4/10/23.
//

import SwiftUI

struct RingActivityIndicator: View {
    var progress: CGFloat
    var progressColor: Color
    var remainingColor: Color
    
    var body: some View {
        let strokeStyle = StrokeStyle(lineWidth: 8.0, lineCap: .round, lineJoin: .round)
        
        let progressEnd = min(max(progress, 0.0), 1.0)
        let progressStart = progressEnd - 0.25
        
        return ZStack {
            Circle()
                .stroke(style: strokeStyle)
                .foregroundColor(remainingColor)
            
            Circle()
                .trim(from: progressStart, to: progressEnd)
                .stroke(style: strokeStyle)
                .foregroundColor(progressColor)
        }
    }
}
