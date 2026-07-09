# Runtime 架构文档

本文档集介绍 CANN Runtime 架构设计，**面向希望为 Runtime 贡献代码的开发者**。

## 架构总览

| 文档 | 说明 |
|------|------|
| [architecture.md](architecture.md) | 系统架构总览，介绍 Runtime 整体设计和核心组件 |

## 模块架构文档

| 文档 | 说明 |
|------|------|
| [modules/runtime/runtime.md](modules/runtime/runtime.md) | Runtime 全局管理，单例模式和资源管理 |
| [modules/device/device.md](modules/device/device.md) | Device 设备管理，设备初始化、状态管理、错误处理 |
| [modules/stream/stream.md](modules/stream/stream.md) | Stream 流管理，任务队列和同步机制 |
| [modules/task/task.md](modules/task/task.md) | Task 任务管理，任务类型和执行流程 |
| [modules/context/context.md](modules/context/context.md) | Context 上下文管理，与 Device/Stream 的关系 |
| [modules/memory/memory.md](modules/memory/memory.md) | Memory 内存管理，内存池和分配策略 |
| [modules/kernel/kernel.md](modules/kernel/kernel.md) | Kernel 核函数管理，二进制加载与执行 |
| [modules/event/event.md](modules/event/event.md) | Event 事件管理，同步机制 |

## 特性文档

| 文档 | 说明 |
|------|------|
| [features/aclgraph.md](features/aclgraph.md) | ACL Graph 特性，流捕获和模型构建 |
| [features/snapshot.md](features/snapshot.md) | Snapshot 特性，进程状态保存和恢复 |
| [features/fusion.md](features/fusion.md) | Fusion 特性，算子融合执行 |

---

## 如何使用这些文档

### 阅读顺序建议

1. **新手入门**：先读 [architecture.md](architecture.md) 了解整体架构
2. **模块开发**：根据兴趣阅读对应模块文档
3. **特性开发**：参考 features/ 目录下的特性文档

### 不同角色的阅读路径

- **Runtime 核心开发者**：architecture → runtime → device → stream → task
- **驱动适配开发者**：architecture → device → stream
- **性能优化开发者**：memory → stream → task
- **特性开发者**：architecture → 对应 feature 文档

---

## 项目结构

```
runtime/
├── api/                    # API 接口层
│   ├── api.hpp             # Runtime API 定义
│   ├── api_c_*.cc          # C 语言接口实现
│   └── api_impl/           # API 版本实现
├── core/
│   ├── inc/                # 内部头文件
│   └── src/                # 核心实现
│       ├── runtime.cc      # Runtime 全局管理
│       ├── device/         # Device 模块
│       ├── stream/         # Stream 模块
│       ├── task/           # Task 模块
│       ├── context/        # Context 模块
│       ├── kernel/         # Kernel 模块
│       ├── event/          # Event 模块
│       ├── engine/         # Engine 调度
│       ├── memory/         # Memory 模块
│       ├── profiler/       # Profiler 性能分析
│       ├── launch/         # Kernel Launch
│       ├── notify/         # Notify 通知
│       ├── dfx/            # DFX 功能
│       └── api_impl/       # API 实现
├── driver/                 # 驱动适配层
│   ├── v100/               # v100 版本驱动
│   ├── v200/               # v200 版本驱动
│   └── v201/               # v201 版本驱动
├── feature/                # 特性功能实现
│   ├── aclgraph/           # ACL Graph 流捕获
│   ├── snapshot/           # Snapshot 进程快照
│   ├── model/              # Model 模型管理
│   ├── soma/               # SOMA 特性
│   ├── ccu/                # CCU 特性
│   ├── cntnotify/          # Count Notify
│   ├── xpu/                # XPU 特性
│   ├── fusion/             # Fusion 融合
│   ├── dqs/                # DQS 特性
│   └── ffts/               # FFTS 特性
├── config/                 # 硬件差异配置
│   ├── as31xm1/            # AS31XM1 芯片配置
│   ├── bs9sx1a/            # BS9SX1A 芯片配置
│   ├── 910_B_93/           # 910B 芯片配置
│   └── ...                 # 其他芯片配置
├── inc/                    # 公共头文件
│   ├── device/             # Device 相关头文件
│   └── sqe/                # SQE 相关头文件
└── cmake/                  # 构建配置
```

---

_本文档遵循开源仓架构文档模版格式。_
