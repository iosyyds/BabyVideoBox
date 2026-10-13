//
//  VideoCardGridView.swift
//  BabyVideoBox
//  首页：九宫格分类（护眼绿色系）+ 分类视频列表 + 全屏循环播放
//

import SwiftUI
import AVKit
import AVFoundation

// MARK: - 首页：九宫格分类（护眼绿色系）
struct HomeView: View {
    @State private var selectedCategory: VideoCategory?

    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        NavigationView {
            ZStack {
                // 护眼绿色渐变背景
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.93, green: 0.98, blue: 0.95),
                        Color(red: 0.85, green: 0.95, blue: 0.90)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)

                ScrollView {
                    VStack(spacing: 26) {
                        // 品牌区
                        HStack(spacing: 14) {
                            Image(systemName: "play.rectangle.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.white)
                                .padding(10)
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [.orange, .pink]),
                                                   startPoint: .topLeading,
                                                   endPoint: .bottomTrailing)
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .shadow(color: Color.orange.opacity(0.3), radius: 6, x: 0, y: 3)

                            VStack(alignment: .leading, spacing: 4) {
                                Text("宝宝视频")
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundColor(Color(red: 0.15, green: 0.35, blue: 0.25))
                                Text("保护眼睛的儿童动画")
                                    .font(.system(size: 15))
                                    .foregroundColor(Color(red: 0.35, green: 0.55, blue: 0.45))
                            }
                            Spacer()
                        }
                        .padding(.top, 16)

                        // 分类九宫格
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(sampleCategories) { category in
                                Button {
                                    selectedCategory = category
                                } label: {
                                    CategoryCardView(category: category)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }

                        // 底部提示
                        HStack(spacing: 6) {
                            Image(systemName: "eye.fill")
                                .font(.system(size: 12))
                                .foregroundColor(Color(red: 0.45, green: 0.65, blue: 0.55))
                            Text("点击分类，看喜欢的动画 · 护眼模式")
                                .font(.system(size: 13))
                                .foregroundColor(Color(red: 0.45, green: 0.65, blue: 0.55))
                        }
                        .padding(.bottom, 24)
                    }
                    .padding(.horizontal, 16)
                }
            }
            .navigationBarHidden(true)
            .fullScreenCover(item: $selectedCategory) { category in
                CategoryVideoListView(category: category)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

// 分类卡片
struct CategoryCardView: View {
    let category: VideoCategory

    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                RoundedRectangle(cornerRadius: 22)
                    .fill(category.color)
                    .frame(height: 92)
                    .shadow(color: category.color.opacity(0.4), radius: 6, x: 0, y: 3)

                Image(systemName: category.icon)
                    .font(.system(size: 38))
                    .foregroundColor(.white)
            }

            Text(category.name)
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(Color(red: 0.2, green: 0.4, blue: 0.3))
        }
    }
}

// MARK: - 分类视频列表
struct CategoryVideoListView: View {
    let category: VideoCategory
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedVideo: VideoItem?

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.93, green: 0.98, blue: 0.95),
                    Color(red: 0.85, green: 0.95, blue: 0.90)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)

            VStack(spacing: 0) {
                // 顶部导航
                HStack(spacing: 12) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color(red: 0.2, green: 0.4, blue: 0.3))
                            .padding(12)
                            .background(Color.white.opacity(0.85))
                            .clipShape(Circle())
                    }

                    Image(systemName: category.icon)
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                        .padding(8)
                        .background(category.color)
                        .clipShape(RoundedRectangle(cornerRadius: 10))

                    Text(category.name)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Color(red: 0.15, green: 0.35, blue: 0.25))

                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)

                // 视频大卡片列表
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(category.videos) { video in
                            Button {
                                selectedVideo = video
                            } label: {
                                VideoCardView(video: video)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    .padding(.bottom, 24)
                }
            }
        }
        .fullScreenCover(item: $selectedVideo) { video in
            FullScreenVideoPage(video: video)
        }
    }
}

// 视频卡片
struct VideoCardView: View {
    let video: VideoItem

    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: video.gradientColors),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .frame(width: 108, height: 76)
                .clipShape(RoundedRectangle(cornerRadius: 16))

                Image(systemName: "play.circle.fill")
                    .font(.system(size: 34))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.2), radius: 3)
            }

            VStack(alignment: .leading, spacing: 6) {
                Text(video.title)
                    .font(.system(size: 19, weight: .semibold))
                    .foregroundColor(Color(red: 0.2, green: 0.4, blue: 0.3))
                Text("点击播放")
                    .font(.system(size: 13))
                    .foregroundColor(Color(red: 0.5, green: 0.7, blue: 0.6))
            }
            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(Color(red: 0.5, green: 0.7, blue: 0.6))
        }
        .padding(16)
        .background(Color.white.opacity(0.9))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.06), radius: 8, x: 0, y: 4)
    }
}

// MARK: - 全屏播放页（自动循环）
struct FullScreenVideoPage: View {
    let video: VideoItem
    @Environment(\.presentationMode) var presentationMode
    @State private var player: AVPlayer?

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            if let player = player {
                VideoPlayer(player: player)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
            } else {
                VStack(spacing: 20) {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(2)
                    Text("正在加载...")
                        .foregroundColor(.white)
                        .font(.title3)
                }
            }

            // 顶部返回按钮
            VStack {
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 36))
                            .foregroundColor(.white.opacity(0.85))
                            .shadow(color: .black.opacity(0.4), radius: 4)
                    }
                    .padding(.top, 50)
                    .padding(.leading, 16)
                    Spacer()
                }
                Spacer()
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

        // 播放结束自动循环
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
