# README 生成模板

本文件是 Runtime 架构文档 README 的生成模板。模板内所有相对链接（如 `architecture.md`、`modules/runtime/runtime.md`）均以实际生成的 README 所在目录为基准，而非本模板文件所在目录。例如生成到仓库内 `docs/zh/design/` 时，`architecture.md` 解析为 `docs/zh/design/architecture.md`。

```markdown
# Runtime 架构文档

本文档集介绍 Runtime 架构设计，**面向希望为 Runtime 贡献代码的开发者**。

## 架构总览

| 文档 | 说明 |
|------|------|
| [architecture.md](architecture.md) | 系统架构总览 |

## 模块架构文档

| 文档 | 说明 |
|------|------|
| [modules/runtime/runtime.md](modules/runtime/runtime.md) | Runtime 全局管理 |
| [modules/device/device.md](modules/device/device.md) | Device 设备管理 |
| [modules/stream/stream.md](modules/stream/stream.md) | Stream 流管理 |
| ... | ... |

## 特性功能文档

| 文档 | 说明 |
|------|------|
| [features/snapshot.md](features/snapshot.md) | 程序快照特性功能 |
| [features/aclgraph.md](features/aclgraph.md) | ACL Graph特性功能 |
| ... | ... |

## 如何使用这些文档

### 阅读顺序建议

1. 先读 architecture.md 了解整体架构
2. 根据兴趣阅读对应模块文档或特性文档

### 不同角色的阅读路径

- **核心开发者**：architecture → runtime → device → stream → task
- **特性开发者**：architecture → feature
- **驱动适配者**：architecture → device → driver
- **性能优化者**：memory → stream → task

## 项目结构
```
runtime/
├── include/
├── src/
│   ├── acl/
│   └── runtime/
│       ├── api             # API 接口层
│       ├── core/src/       # 核心模型实现
│       │   ├── device/
│       │   ├── stream/
│       │   └── ...
│       ├── feature         # 功能特性实现
│       │   ├── aclgraph/
│       │   └── ...
│       ├── config          # 硬件差异配置
│       └── driver          # 驱动适配层
└── tests/
```
```