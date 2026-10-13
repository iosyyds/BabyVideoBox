//
//  VideoItem.swift
//  BabyVideoBox
//

import Foundation
import SwiftUI

struct VideoItem: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let fileName: String
    let thumbnailName: String?

    static func loadAllVideos() -> [VideoItem] {
        var videos: [VideoItem] = []

        if let resourcePath = Bundle.main.resourcePath {
            do {
                let files = try FileManager.default.contentsOfDirectory(atPath: resourcePath)
                let videoFiles = files.filter { $0.lowercased().hasSuffix(".mp4") || $0.lowercased().hasSuffix(".mov") }

                for file in videoFiles.sorted() {
                    let fileName = (file as NSString).deletingPathExtension
                    let displayTitle = fileName.replacingOccurrences(of: "_", with: " ").replacingOccurrences(of: "-", with: " ")
                    videos.append(VideoItem(title: displayTitle, fileName: file, thumbnailName: nil))
                }
            } catch {
                print("加载视频失败: \(error)")
            }
        }

        if videos.isEmpty {
            for i in 1...4 {
                videos.append(VideoItem(title: "示例视频 \(i)", fileName: "sample\(i).mp4", thumbnailName: nil))
            }
        }

        return videos
    }
}
