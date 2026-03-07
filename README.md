# TipCalc Pro 💰

> 小费计算器 + AA 制分摊 - 聚餐结账神器

[![Platform](https://img.shields.io/badge/platform-iOS%2015.0+-blue.svg)](https://developer.apple.com/ios)
[![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)](https://swift.org)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

## 📱 应用简介

TipCalc Pro 是一款实用的小费计算器和 AA 制分摊工具，帮助您在聚餐、旅行等场景中快速计算账单分摊，避免尴尬的算账时刻。

**定价**：$0.99（一次性购买，无订阅）

## ✨ 核心功能

### 💵 小费计算
- 支持自定义小费比例（15%、18%、20% 等）
- 实时计算总金额
- 支持自定义金额

### 👥 AA 制分摊
- 支持多人分摊（2-20 人）
- 人均金额自动计算
- 支持不等额分摊

### 📊 计算明细
- 清晰展示金额构成
- 账单/小费/分摊一目了然
- 支持四舍五入调整

### 📜 历史记录
- 自动保存计算历史
- 快速查看过往账单
- 支持删除管理

### 🎨 精美界面
- 简洁直观的设计
- 大按钮易操作
- 支持深色模式

## 🛠️ 技术栈

| 技术 | 说明 |
|------|------|
| SwiftUI | 声明式 UI 框架 |
| UserDefaults | 本地数据存储 |
| Combine | 响应式数据绑定 |

## 📦 项目结构

```
TipCalcPro/
├── TipCalcProApp.swift
├── ContentView.swift
└── Assets.xcassets/
```

## 🚀 构建指南

### 环境要求
- macOS 13.0+
- Xcode 15.0+
- iOS 15.0+ SDK

### 构建步骤

```bash
# 1. 克隆仓库
git clone https://github.com/claws-x/tipcalc-pro.git
cd tipcalc-pro

# 2. 打开 Xcode 工程
open TipCalcPro.xcodeproj

# 3. 构建并运行
xcodebuild -project TipCalcPro.xcodeproj \
  -scheme TipCalcPro \
  -configuration Debug \
  -destination 'platform=iOS Simulator,name=iPhone 17' \
  build
```

## 📸 截图

> 截图待添加

| 主界面 | 分摊计算 | 历史记录 |
|--------|----------|----------|
| ![主界面](screenshots/home.png) | ![分摊](screenshots/split.png) | ![历史](screenshots/history.png) |

## 📋 隐私说明

- **无数据收集**：本应用不收集任何用户数据
- **本地存储**：所有数据存储在本地
- **无网络请求**：无需联网即可使用
- **无第三方 SDK**：无广告、无追踪

## 📄 许可证

MIT License - 详见 [LICENSE](LICENSE)

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📬 联系方式

- GitHub: [@claws-x](https://github.com/claws-x)
- 问题反馈：[Issues](https://github.com/claws-x/tipcalc-pro/issues)

---

**TipCalc Pro** - 算账不尴尬，聚餐更愉快 💰
