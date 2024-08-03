//
//  PieChart.swift
//  Projekt_iOS
//
//  Created by Magdaléna Klimešová on 21.06.2023.
//

import SwiftUI

struct PieChart: View {
    @ObservedObject var episodeViewModel: EpisodeViewModel
    var body: some View {
        VStack(alignment: .leading){
            HStack( spacing: 15){
                Row(indexColor: 0)
                Row(indexColor: 1)
                Row(indexColor: 2)
                Row(indexColor: 3)
                Row(indexColor: 4)
                
            }
            HStack( spacing: 15){
                Row(indexColor: 5)
                Row(indexColor: 6)
                Row(indexColor: 7)
                Row(indexColor: 8)
                Row(indexColor: 9)
            }
        }
        
        Canvas { context, size in
            let total = episodeViewModel.dataToPieChart.reduce(0) { $0 + $1.0 }
                    context.translateBy(x: size.width * 0.5, y: size.height * 0.5)
                    var pieContext = context
                    pieContext.rotate(by: .degrees(-90))
                    let radius = min(size.width, size.height) * 0.48
                    var startAngle = Angle.zero
                    for (value, color) in episodeViewModel.dataToPieChart {
                        let angle = Angle(degrees: 360 * (value / total))
                        let endAngle = startAngle + angle
                        let path = Path { p in
                            p.move(to: .zero)
                            p.addArc(center: .zero, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
                            p.closeSubpath()
                        }
                        pieContext.fill(path, with: .color(color))
                        startAngle = endAngle
                    }
                }
        .aspectRatio(1.5, contentMode: .fit)
     
        
    }
}

struct Row: View {
    var indexColor: Int
    var body: some View {
        HStack {
            Circle()
                .fill(colors[indexColor])
                .frame(width: 10,height: 10)
            Text("S\(indexColor+1)")
                .font(.system(.callout,design: .rounded))
                
        }
    }
}
