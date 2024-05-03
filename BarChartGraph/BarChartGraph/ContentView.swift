//
//  ContentView.swift
//  BarChartGraph
//
//  Created by Cory Popp on 3/21/24.
//

import Charts
import SwiftUI

struct Video: Identifiable, Equatable {
    let id = UUID()
    let source: String
    var viewCount: Int
}

struct ContentView: View {
    
    @State var videos: [Video] = [
        .init(source: "SEO", viewCount: 122),
        .init(source: "Social", viewCount: 58),
        .init(source: "Direct", viewCount: 201),
        .init(source: "Other", viewCount: 48)
    ]
    @State var chartRange: ClosedRange = 0...220
    @State var goalLine: Int = 100
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 50) {
                generateChart
                
                Button() {
                    randomizeData()
                } label: {
                    Text("Randomize Data")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.pink)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .padding()
            .navigationTitle("Animated Bar Graph")
        }
    }
    
    var generateChart: some View {
        Chart {
            RuleMark(y: .value("Goal", goalLine))
                .foregroundStyle(.mint)
                .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                .annotation(alignment: .leading) {
                    Text("Goal")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .offset(x: 20, y: 0)
                }
            
            BarMark(
                x: .value("Source", ""),
                y: .value("Views", 0)
            )
            
            ForEach(videos) { video in
                BarMark(
                    x: .value("Source", video.source),
                    y: .value("Views", video.viewCount),
                    width: .automatic
                )
                .foregroundStyle(.pink.gradient)
                .cornerRadius(5)
            }
        }
        .frame(height: 400)
        .padding()
        .animation(.bouncy, value: videos)
        .chartYScale(domain: chartRange)
        .padding()
        .background {
            Color.white
                .cornerRadius(10)
        }
    }
    
    func randomizeData() {
        var highestValue: Int = 0
        
        for index in videos.indices {
            let randomValue = Int.random(in: 10...50)
            
            if randomValue > highestValue {
                highestValue = randomValue
            }
            
            videos[index].viewCount = randomValue
            chartRange = 0...(highestValue+5)
            goalLine = (highestValue-10)
        }
    }
}

#Preview {
    ContentView()
}
