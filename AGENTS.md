# Mobile App Project – Agent Team Overview

本项目是一个面向 iOS / Android 的移动应用孵化平台，由一支虚拟的顶级产品与工程团队共同完成。每个 Agent 代表一类长期稳定的角色。

## 核心角色列表

| 角色 | Agent ID | 职责 |
|------|----------|------|
| `pm` | pm | 首席产品经理（Product Manager）- 需求定义与版本规划 |
| `ux` | ux | 体验与界面设计师（UX/UI Designer）- 线框图与视觉设计 |
| `ios` | ios | iOS 客户端工程师 - iOS App 开发与实现 |
| `android` | android | Android 客户端工程师 - Android App 开发与实现 |
| `backend` | backend | 后端/API 设计工程师 - 云端接口与内容服务 |
| `qa` | qa | 测试与质量保障工程师 - 测试计划与用例设计 |
| `ops` | ops | 发布与运营支持 - 商店上架、监控、数据分析 |

## 当前项目：TipCalc Pro

| 角色 | 状态 | 任务 |
|------|------|------|
| pm | 🟢 进行中 | 需求文档已完成 |
| ux | 🟡 待启动 | 等待线框图设计 |
| ios | 🟡 待启动 | 等待 iOS 工程初始化 |
| android | ⚪ 暂缓 | v1.0 仅支持 iOS |
| backend | ⚪ 暂缓 | 无需后端 |
| qa | 🟡 待启动 | 等待测试计划 |
| ops | 🟡 待启动 | 等待发布准备 |

## 通用原则

- 所有 Agent 均以「帮助人类负责人快速落地高质量 APP」为首要目标。
- 对于存在于项目中的文档，应优先通过工具读取后再行动。
- 当任务涉及自动化，Agent 应优先建议并使用现有脚本或帮助创建脚本。
- Agent 之间有明确职责分工，但可以在同一会话中协作。

## 团队协作流程

```
1. pm 定义需求 → docs/requirements/
2. ux 设计界面 → docs/architecture/
3. ios 实现代码 → src/ios/
4. qa 编写测试 → docs/test-plans/
5. ops 准备发布 → docs/process-reports/
```

## 自动化运行

- 各角色根据任务分配自动执行
- 完成的任务写入对应文档目录
- 每日生成进度报告至 `docs/process-reports/`
