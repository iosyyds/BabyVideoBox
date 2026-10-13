
Enter file contents here
//
//  FullScreenVideoPlayerView.swift
//  BabyVideoBox
//

import SwiftUI
import AVKit
import AVFoundation

struct FullScreenVideoPlayerView: View {
    let video: VideoItem
    let onClose: () -> Void

    @State private var player: AVPlayer?

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            if let player = player {
                VideoPlayer(player: player)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture { onClose() }
            } else {
                VStack(spacing: 20) {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(2)
                    Text("加载中...")
                        .foregroundColor(.white)
                        .font(.title2)
                }
            }
        }
        .statusBar(hidden: true)
        .onAppear { setupPlayer() }
        .onDisappear { player?.pause() }
    }

    private func setupPlayer() {
        guard let url = video.videoURL else { return }
        let playerItem = AVPlayerItem(url: url)
        let newPlayer = AVPlayer(playerItem: playerItem)

        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: playerItem,
            queue: .main
        ) { _ in
            newPlayer.seek(to: .zero)
            newPlayer.play()
        }

        self.player = newPlayer
        newPlayer.play()
    }
}
