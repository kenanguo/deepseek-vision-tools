# DeepSeek Vision Tools

让不支持多模态的 DeepSeek 模型也能"看"图片。基于 macOS 内置 Vision 框架，无需额外安装。

> 适用于 DeepSeek V4等任何不支持图片输入的 AI 模型。

## 文件

- `image_ocr.swift` — 图片文字识别（OCR），支持中英日韩
- `image_describe.swift` — 图片场景识别（分类）

## 安装

```bash
chmod +x image_ocr.swift image_describe.swift
```

macOS 自带 Swift，无需安装任何依赖。

## 使用

```bash
# 识别图片中的文字
./image_ocr.swift 图片路径.png

# 识别图片场景（咖啡馆、户外、文档等）
./image_describe.swift 图片路径.png
```

## AI 如何调用

在 DeepSeek 或其他 AI 中：
1. 用户发图 → Agent 调 `image_ocr.swift` 读文字
2. 调 `image_describe.swift` 识别场景
3. 两个结果组合起来就是完整的图片描述

## 原理

直接调用 macOS Vision 框架（VNRecognizeTextRequest / VNClassifyImageRequest），不依赖第三方 API，本地运行，隐私安全。
