//
//  VideoItem.swift
//  BabyVideoBox
//

import Foundation
import SwiftUI

struct VideoItem: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let videoURL: URL?
    let gradientColors: [Color]
}

let sampleVideos: [VideoItem] = [
    VideoItem(title: "彩虹世界", videoURL: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"), gradientColors: [.orange, .pink, .purple]),
    VideoItem(title: "可爱小兔子", videoURL: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"), gradientColors: [.green, .mint, .teal]),
    VideoItem(title: "太空冒险", videoURL: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4"), gradientColors: [.blue, .indigo, .purple]),
    VideoItem(title: "海洋世界", videoURL: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4"), gradientColors: [.cyan, .blue, .teal]),
    VideoItem(title: "花园派对", videoURL: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ToS.mp4"), gradientColors: [.pink, .orange, .yellow])
]
