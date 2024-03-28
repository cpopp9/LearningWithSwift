//
//  VideoPlayerView.swift
//  AutoPlayVideo
//
//  Created by Cory Popp on 3/25/24.
//

import AVKit
import SwiftUI

struct VideoPlayerView: View {
    @State var player = AVPlayer()
    @Binding var currentlyShowingVideo: Video
    let video: Video
    
    init(video: Video, currentlyShowingVideo: Binding<Video>) {
        self.video = video
        self._currentlyShowingVideo = currentlyShowingVideo
    }
    
    var body: some View {
        VideoPlayer(player: player)
            .aspectRatio(1.78, contentMode: .fit)
            .onAppear {
                loadVideoFile()
                
                if currentlyShowingVideo == video {
                    DispatchQueue.main.async {
                        player.play()
                    }
                }
            }
            .onChange(of: currentlyShowingVideo) {
                if currentlyShowingVideo == video {
                    DispatchQueue.main.async {
                        player.play()
                    }
                } else {
                    player.pause()
                }
            }
    }
    
    func loadVideoFile() {
        guard let bundleID = Bundle.main.path(forResource: video.videoID, ofType: "mov") else { return }
        let videoURL = URL(filePath: bundleID)
        let playerItem = AVPlayerItem(url: videoURL)
        player.replaceCurrentItem(with: playerItem)
    }
}

#Preview {
    VideoPlayerView(video: Video(videoID: "Weather Video 1"), currentlyShowingVideo: .constant(Video(videoID: "Weather Video 1")))
}
