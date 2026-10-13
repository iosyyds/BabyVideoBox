//
//  VideoCardGridView.swift
//  BabyVideoBox
//

import SwiftUI

struct VideoCardGridView: View {
    @State private var videos: [VideoItem] = []
    @State private var selectedVideo: VideoItem?
    @State private var isPlayingFullScreen = false

    let columns = [GridItem(.flexible(), spacing: 20), GridItem(.flexible(), spacing: 20)]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(videos) { video in
                        VideoCardView(video: video) {
                            selectedVideo = video
                            isPlayingFullScreen = true
                        }
                    }
                }
                .padding(20)
            }
            .navigationTitle("宝宝视频")
            .navigationBarTitleDisplayMode(.large)
            .background(LinearGradient(gradient: Gradient(colors: [Color(red: 0.95, green: 0.97, blue: 1.0), Color(red: 0.9, green: 0.95, blue: 1.0)]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all))
        }
        .onAppear { videos = VideoItem.loadAllVideos() }
        .fullScreenCover(isPresented: $isPlayingFullScreen) {
            if let video = selectedVideo {
                FullScreenVideoPlayerView(video: video) { isPlayingFullScreen = false }
            }
        }
    }
}

struct VideoCardView: View {
    let video: VideoItem
    let onTap: () -> Void
    @State private var isPressed = false

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 0) {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color(red: 0.4, green: 0.7, blue: 1.0), Color(red: 0.2, green: 0.5, blue: 0.9)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    Image(systemName: "play.circle.fill").font(.system(size: 80)).foregroundColor(.white).shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                }
                .frame(height: 180).clipped()

                Text(video.title).font(.system(size: 18, weight: .bold)).foregroundColor(.primary).lineLimit(2).multilineTextAlignment(.center).padding(12).frame(maxWidth: .infinity).background(Color.white)
            }
            .background(Color.white).cornerRadius(20).shadow(color: .black.opacity(0.15), radius: 15, x: 0, y: 8).scaleEffect(isPressed ? 0.95 : 1.0).animation(.easeInOut(duration: 0.15), value: isPressed)
        }
        .buttonStyle(PlainButtonStyle()).onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { p in isPressed = p }, perform: {})
    }
}
