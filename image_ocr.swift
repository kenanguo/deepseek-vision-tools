#!/usr/bin/env swift
import Vision
import AppKit
import Foundation

guard CommandLine.arguments.count > 1 else {
    print("用法: image_ocr.swift <图片路径>")
    exit(1)
}

let imagePath = CommandLine.arguments[1]
guard let image = NSImage(contentsOfFile: imagePath),
      let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil) else {
    print("错误: 无法读取图片 \(imagePath)")
    exit(1)
}

let request = VNRecognizeTextRequest()
request.recognitionLevel = .accurate
request.recognitionLanguages = ["zh-Hans", "zh-Hant", "en", "ja", "ko"]
request.usesLanguageCorrection = true

let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
do {
    try handler.perform([request])
} catch {
    print("错误: OCR 失败 - \(error)")
    exit(1)
}

guard let observations = request.results, !observations.isEmpty else {
    print("未识别到文字")
    exit(0)
}

for obs in observations {
    let text = obs.topCandidates(1).first?.string ?? ""
    if !text.isEmpty {
        print(text)
    }
}
