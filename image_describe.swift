#!/usr/bin/env swift
import Vision
import AppKit
import Foundation

guard CommandLine.arguments.count > 1 else {
    print("用法: image_describe.swift <图片路径>")
    exit(1)
}

let imagePath = CommandLine.arguments[1]
guard let image = NSImage(contentsOfFile: imagePath),
      let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil) else {
    print("错误: 无法读取图片 \(imagePath)")
    exit(1)
}

// 图片分类
let classifyRequest = VNClassifyImageRequest()
let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])

do {
    try handler.perform([classifyRequest])
} catch {
    print("错误: 图片分类失败 - \(error)")
    exit(1)
}

if let results = classifyRequest.results, !results.isEmpty {
    let topResults = results.sorted { $0.confidence > $1.confidence }.prefix(5)
    print("=== 场景识别 (置信度) ===")
    for r in topResults {
        let pct = Int(r.confidence * 100)
        print("\(r.identifier) (\(pct)%)")
    }
} else {
    print("=== 场景识别 ===\n未识别到场景")
}

// 图片基本信息
let width = Int(image.size.width)
let height = Int(image.size.height)
print("\n尺寸: \(width)×\(height)")
