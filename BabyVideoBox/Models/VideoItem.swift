//
//  VideoItem.swift
//  BabyVideoBox
//
//  视频模型 + 分类模型 + 内置示例数据（全部国内 CDN 视频直链，可在线播放）
//

import Foundation
import SwiftUI

// 单个视频
struct VideoItem: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let videoURL: URL?
    let gradientColors: [Color]
}

// 视频分类
struct VideoCategory: Identifiable, Hashable {
    let id: String
    let name: String
    let icon: String
    let color: Color
    let videos: [VideoItem]
}

// MARK: - 内置分类与视频（护眼柔和配色，视频源均为国内 CDN）
let sampleCategories: [VideoCategory] = [
    VideoCategory(
        id: "cartoon",
        name: "动画片",
        icon: "film.fill",
        color: Color(red: 1.0, green: 0.76, blue: 0.55),
        videos: [
            VideoItem(title: "快乐动画一", videoURL: URL(string: "http://1810000000.vod2.myqcloud.com/b64e98acvodcq1810000000/c20be6785285890809599844312/f0.mp4"), gradientColors: [.orange, .pink]),
            VideoItem(title: "快乐动画二", videoURL: URL(string: "http://1810000000.vod2.myqcloud.com/b64e98acvodcq1810000000/f69747475285890810007930755/f0.mp4"), gradientColors: [.red, .orange])
        ]
    ),
    VideoCategory(
        id: "song",
        name: "儿歌",
        icon: "music.note",
        color: Color(red: 0.72, green: 0.85, blue: 1.0),
        videos: [
            VideoItem(title: "儿歌旋律一", videoURL: URL(string: "https://sf1-cdn-tos.huoshanstatic.com/obj/media-fe/xgplayer_doc_video/mp4/xgplayer-demo-360p.mp4"), gradientColors: [.blue, .cyan]),
            VideoItem(title: "儿歌旋律二", videoURL: URL(string: "https://sf1-cdn-tos.huoshanstatic.com/obj/media-fe/xgplayer_doc_video/mp4/xgplayer-demo-480p.mp4"), gradientColors: [.teal, .blue])
        ]
    ),
    VideoCategory(
        id: "ocean",
        name: "海洋世界",
        icon: "water.waves",
        color: Color(red: 0.6, green: 0.85, blue: 0.9),
        videos: [
            VideoItem(title: "海洋乐园", videoURL: URL(string: "https://sf1-cdn-tos.huoshanstatic.com/obj/media-fe/xgplayer_doc_video/mp4/xgplayer-demo-720p.mp4"), gradientColors: [.cyan, .blue])
        ]
    ),
    VideoCategory(
        id: "animal",
        name: "动物乐园",
        icon: "pawprint.fill",
        color: Color(red: 0.9, green: 0.8, blue: 0.6),
        videos: [
            VideoItem(title: "动物世界", videoURL: URL(string: "http://viapi-test.oss-cn-shanghai.aliyuncs.com/viapi-3.0domepic/videoenhan/SuperResolveVideo/SuperResolveVideo1.mp4"), gradientColors: [.brown, .orange])
        ]
    ),
    VideoCategory(
        id: "nature",
        name: "大自然",
        icon: "leaf.fill",
        color: Color(red: 0.72, green: 0.9, blue: 0.62),
        videos: [
            VideoItem(title: "自然风光", videoURL: URL(string: "http://1810000000.vod2.myqcloud.com/b64e98acvodcq1810000000/edeb76835285890810014330867/f0.mp4"), gradientColors: [.green, .mint])
        ]
    ),
    VideoCategory(
        id: "story",
        name: "故事屋",
        icon: "book.fill",
        color: Color(red: 0.95, green: 0.8, blue: 0.9),
        videos: [
            VideoItem(title: "趣味故事", videoURL: URL(string: "http://1810000000.vod2.myqcloud.com/b64e98acvodcq1810000000/bec21e445285890810010546287/f0.mp4"), gradientColors: [.pink, .purple])
        ]
    ),
    VideoCategory(
        id: "brain",
        name: "益智乐园",
        icon: "puzzlepiece.fill",
        color: Color(red: 1.0, green: 0.9, blue: 0.62),
        videos: [
            VideoItem(title: "益智小课堂", videoURL: URL(string: "http://viapi-test.oss-cn-shanghai.aliyuncs.com/viapi-3.0domepic/videoenhan/AdjustVideoColor/AdjustVideoColor1.mp4"), gradientColors: [.yellow, .orange]),
            VideoItem(title: "认知启蒙", videoURL: URL(string: "http://viapi-test.oss-cn-shanghai.aliyuncs.com/viapi-3.0domepic/videoenhan/ChangeVideoSize/ChangeVideoSize1.mp4"), gradientColors: [.yellow, .green])
        ]
    ),
    VideoCategory(
        id: "english",
        name: "英语启蒙",
        icon: "abc",
        color: Color(red: 0.8, green: 0.76, blue: 0.95),
        videos: [
            VideoItem(title: "英语动画", videoURL: URL(string: "http://viapi-test.oss-cn-shanghai.aliyuncs.com/viapi-3.0domepic/videoenhan/EraseVideoLogo/EraseVideoLogo1.mp4"), gradientColors: [.indigo, .purple])
        ]
    ),
    VideoCategory(
        id: "family",
        name: "亲子时光",
        icon: "heart.fill",
        color: Color(red: 1.0, green: 0.75, blue: 0.75),
        videos: [
            VideoItem(title: "亲子陪伴", videoURL: URL(string: "http://viapi-test.oss-cn-shanghai.aliyuncs.com/viapi-3.0domepic/videoenhan/MergeVideoFace/MergeVideoFace1.mp4"), gradientColors: [.pink, .red]),
            VideoItem(title: "温馨时光", videoURL: URL(string: "http://viapi-test.oss-cn-shanghai.aliyuncs.com/viapi-3.0domepic/videoenhan/EraseVideoSubtitles/EraseVideoSubtitles1.mp4"), gradientColors: [.purple, .pink])
        ]
    )
]
