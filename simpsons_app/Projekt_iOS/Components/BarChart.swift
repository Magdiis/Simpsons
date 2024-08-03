//
//  BarChart.swift
//  Projekt_iOS
//
//  Created by Magdaléna Klimešová on 21.06.2023.
//

import SwiftUI
import Charts

struct BarChart: View {
    @ObservedObject var episodeViewModel: EpisodeViewModel

    var body: some View {
        VStack {
            HStack {
                Image("donut")
                    .resizable()
                    .frame(width: 37, height: 32)
                Text("Your rating")
                    .font(.system(.title,design: .rounded))
                    //.foregroundColor(Color("SimpsonBlueDark"))
                    .foregroundColor(.black)
                Image("donut")
                    .resizable()
                    .frame(width: 37, height: 32)
            }
            
            
           Chart(episodeViewModel.dataToBarChart) {
                
                BarMark(x: .value("Season", $0.season),
                        y: .value("Average Rating", $0.average), width: 22
                )
                .foregroundStyle(colors[$0.season-1])
            }
                    
                  /*  RuleMark(y:.value("", season.average))
                        .foregroundStyle(Color.mint)
                        .lineStyle(StrokeStyle(lineWidth: 1,dash: [5]))
                        .annotation(alignment: .leading) {
                            Text("\(season.average)")
                                .foregroundColor(Color.gray)
                        } */
      
            .frame(height: 200)
            //.chartXAxis(false)
            .chartPlotStyle { plotContent in
                  plotContent
                      .background(Color("SimpsonYellow").gradient)
              }
            
            .chartYScale(domain: 0...5.5)
            .chartXScale(domain:0.5...10.5)
            .chartXAxis {
                AxisMarks( values: [1,2,3,4,5,6,7,8,9,10]) {
                        AxisValueLabel()
                }
            }
            
            .chartYAxis {
                AxisMarks( values: [1,2,3,4,5]){
                    AxisGridLine()
                    //AxisTick()
                    AxisValueLabel(centered: false)
                }
            }
            .chartXAxisLabel("Seasons")
            .chartYAxisLabel("Average")
            
        }
        .padding([.trailing,.leading])
    }
}

struct SeasonForBarCharts: Identifiable{
    let id = UUID()
    var season: Int
    var average: Double
}
