# AGENTS.md

本文件为 agent 在此代码仓库中工作时提供指导。

## 项目概述

Runtime 是华为 CANN (Compute Architecture for Neural Networks) 的运行时组件，提供 Ascend NPU 运行时用户编程接口和运行时核心实现。

主要功能：
- **Runtime 组件**：设备管理、流管理、Event 管理、内存管理、任务调度等
- **维测功能组件**：
  - 性能调优（msprof）：采集和分析 AI 任务性能指标
  - 精度调试（adump）：Dump 算子/模型输入输出数据
  - 日志（log）：记录进程执行信息，支持故障诊断

## 构建命令

### 基础构建
```bash
# 构建运行时组件
bash build.sh

# 查看构建选项
bash build.sh --help
```

### 安装依赖
```bash
# 安装第三方依赖
bash install_deps.sh

# 下载第三方库（仅在本地网络不通时使用，网络通畅时不需要）
bash download_3rd_party.sh
```

## 目录结构

| 目录 | 用途 |
|------|------|
| `include/` | 对外发布的头文件 |
| `src/` | 源代码 |
| `src/acl/` | ACL 对外 API |
| `src/dfx/` | 维测功能模块 |
| `src/dfx/adump/` | 精度调试模块 |
| `src/dfx/msprof/` | 性能调优模块 |
| `src/dfx/log/` | 日志模块 |
| `src/runtime/` | Runtime 核心模块 |
| `tests/` | 单元测试 |
| `example/` | 样例代码 |
| `cmake/` | 构建配置 |

## 开发规范

### gitcode pr/issue 操作
@.claude/skills/default-skills/SKILL.md

### 代码风格
- 遵循 Google 开源代码规范
- 使用 .clang-format 格式化代码

## 短语
使用中文
