//
//  FullScreenVideoPlayerView.swift
//  BabyVideoBox
//
//  全屏视频播放器 - 自动循环播放，适配网络视频
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
            // 黑色背景
            Color.black
                .edgesIgnoringSafeArea(.all)

            // 视频播放器
            if let player = player {
                VideoPlayer(player: player)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        onClose()
                    }
            } else {
                // 加载中提示
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
        .onAppear {
            setupPlayer()
        }
        .onDisappear {
            player?.pause()
        }
    }

    private func setupPlayer() {
        guard let url = video.videoURL else { return }
        let playerItem = AVPlayerItem(url: url)
        let newPlayer = AVPlayer(playerItem: playerItem)

        // 监听播放结束，实现自动循环
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

        // 静音模式下也能播放
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("音频会话设置失败: \(error)")
        }
    }
}
