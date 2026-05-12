---
name: vision-tool
description: 读取图片内容——OCR提取文字、场景识别分类。基于macOS Vision框架，本地运行，无需API。当用户发送图片、截图、或提到"看看这个图""帮我读一下""截图里写了什么""这张图片是什么内容"时自动触发。
---

# Vision Tool

让不支持多模态的模型也能"看图"。基于 macOS Vision 框架，零依赖，本地运行。

## 脚本

两个 Swift 脚本，位于 `scripts/` 子目录：

### image_ocr.swift — OCR 文字提取

识别图片中的文字，支持中/英/日/韩。

```bash
swift scripts/image_ocr.swift <图片路径>
```

- 适用：截图、聊天记录、文章截图、文档扫描件
- 输出：纯文本，按识别顺序逐行输出

### image_describe.swift — 场景识别

识别图片场景分类 + 尺寸信息。

```bash
swift scripts/image_describe.swift <图片路径>
```

- 适用：判断图片大致内容（风景、人物、UI截图等）
- 输出：Top 5 场景标签 + 置信度百分比 + 图片尺寸

## 使用规则

1. **用户发图时**：先跑 `image_ocr.swift` 提取文字，再根据需要跑 `image_describe.swift` 判断场景
2. **截图类图片**：通常只需要 OCR，场景识别用处不大
3. **照片类图片**：先跑场景识别，再根据内容描述
4. **路径**：脚本相对于本 skill 目录，即 `~/.cola/skills/vision-tool/scripts/`
5. **编译**：Swift 脚本直接 `swift` 运行，不需要预编译
6. **底线**：如果脚本执行失败，如实告知用户"这张图我处理不了"，**绝不编造图片内容**
