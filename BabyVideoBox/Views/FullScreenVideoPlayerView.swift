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
    @State private var showCloseButton = false
    @State private var closeButtonTimer: Timer?

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            if let player = player {
                VideoPlayer(player: player).edgesIgnoringSafeArea(.all).onTapGesture {
                    withAnimation { showCloseButton.toggle() }
                    resetCloseButtonTimer()
                }
            } else {
                VStack(spacing: 20) {
                    ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .white)).scaleEffect(2)
                    Text("加载中...").foregroundColor(.white).font(.title2)
                }
            }

            if showCloseButton {
                VStack {
                    HStack {
                        Spacer()
                        Button(action: { player?.pause(); onClose() }) {
                            Image(systemName: "xmark.circle.fill").font(.system(size: 60)).foregroundColor(.white).shadow(color: .black.opacity(0.5), radius: 10)
                        }
                        .padding(.top, 50).padding(.trailing, 30)
                    }
                    Spacer()
                }
                .transition(.opacity)
            }
        }
        .statusBar(hidden: true)
        .onAppear {
            setupVideoPlayer()
            showCloseButton = true
            resetCloseButtonTimer()
        }
        .onDisappear { player?.pause(); closeButtonTimer?.invalidate() }
    }

    private func setupVideoPlayer() {
        guard let videoPath = Bundle.main.path(forResource: (video.fileName as NSString).deletingPathExtension, ofType: (video.fileName as NSString).pathExtension) else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { onClose() }
            return
        }

        let url = URL(fileURLWithPath: videoPath)
        let playerItem = AVPlayerItem(url: url)
        let newPlayer = AVPlayer(playerItem: playerItem)

        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: playerItem, queue: .main) { _ in
            newPlayer.seek(to: .zero)
            newPlayer.play()
        }

        self.player = newPlayer
        newPlayer.play()

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch { print("音频会话设置失败") }
    }

    private func resetCloseButtonTimer() {
        closeButtonTimer?.invalidate()
        closeButtonTimer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
            withAnimation { showCloseButton = false }
        }
    }
}
