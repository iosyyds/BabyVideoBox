
Enter file contents here
//
//  VideoCardGridView.swift
//  BabyVideoBox
//  抖音风格全屏竖屏，上下滑动切换
//

import SwiftUI
import AVKit

struct VideoCardGridView: View {
    @State private var videos: [VideoItem] = sampleVideos
    @State private var currentIndex = 0

    var body: some View {
        TabView(selection: $currentIndex) {
            ForEach(Array(videos.enumerated()), id: \.element.id) { index, video in
                FullScreenVideoPage(video: video)
                    .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .edgesIgnoringSafeArea(.all)
    }
}

struct FullScreenVideoPage: View {
    let video: VideoItem
    @State private var player: AVPlayer?
    @State private var showUI = false

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: video.gradientColors),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)

            if let player = player {
                VideoPlayer(player: player)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation { showUI.toggle() }
                    }
            } else {
                VStack(spacing: 20) {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(2.5)
                    Text("加载中...")
                        .foregroundColor(.white)
                        .font(.title2)
                }
            }

            VStack {
                HStack {
                    Spacer()
                    Text(video.title)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.5), radius: 5)
                        .padding(.top, 60)
                    Spacer()
                }
                Spacer()
            }
            .opacity(showUI ? 1 : 0)
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
