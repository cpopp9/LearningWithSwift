//
//  ContentView.swift
//  AutoPlayVideo
//
//  Created by Cory Popp on 3/25/24.
//

import SwiftUI

struct ContentView: View {
    let videos: [Video] = [
        // https://www.pexels.com/video/fair-weather-day-854002/
        .init(videoID: "Weather Video 1"),
        // https://www.pexels.com/video/beautiful-weather-856572/
        .init(videoID: "Weather Video 2"),
        // https://www.pexels.com/search/videos/weather/?size=small
        .init(videoID: "Weather Video 3"),
        // https://www.pexels.com/video/rain-water-sliding-down-the-glass-window-surface-5197762/
        .init(videoID: "Weather Video 4"),
        // https://www.pexels.com/video/woman-waiting-for-a-taxi-855433/
        .init(videoID: "Weather Video 5"),
    ]
    
    @State var currentlyShownVideo: Video
    
    init() {
        self.currentlyShownVideo = videos[0]
    }
    
    var body: some View {
        TabView(selection: $currentlyShownVideo) {
            ForEach(videos, id: \.self) { video in
                VideoPlayerView(video: video, currentlyShowingVideo: $currentlyShownVideo)
            }
        }
        .tabViewStyle(PageTabViewStyle())
    }
}

#Preview {
    ContentView()
}
