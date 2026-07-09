<!-- ==================== HERO 区域 ==================== -->

<h1 align="center">CANN Runtime</h1>

<p align="center">
  <b>昇腾 AI 处理器轻量级运行时环境 · 端云一致 · 高性能推理</b><br>
  CANN Runtime 是昇腾 AI 处理器的核心运行时底座，它通过提供统一的 API，使得上层应用、AI 框架、加速库能够高效利用 AI 处理器的硬件计算资源。
</p>

---

<!-- ==================== 文档导航 ==================== -->
## 📚 文档导航

| 文档 | 定位与内容 | 入口 |
|------|-----------|------|
| **⚡ 快速入门** | 零基础起步，第一次接触 Runtime 的开发者。Runtime 简介 + 编程模型讲解，建议顺序阅读 | [Runtime 简介](quick_start/Runtime简介.md) · [编程模型](quick_start/Runtime编程模型.md) |
| **📖 编程指南** | 深度开发手册，已跑通入门阶段 Hello CANN 后需要深入理解原理的开发者。原理解析 + 示例代码 | [编程指南](dev_guide/00_dev_guide.md) |
| **📋 API 参考** | 接口字典，开发过程中随时查阅函数定义。函数签名 + 参数说明 + 返回值 | [头文件说明](api_ref/01_overview.md) · [API 参考](api_ref/README.md) |
| **🏗️ 架构指南** | 面向贡献者的架构文档。Runtime 整体架构、模块设计、核心组件解析 | [架构指南](design/README.md) |
| **📝 研发规范** | 面向贡献者的规范指南，包括设计文档模板、编码规范、测试规范、代码检视规则 | [研发规范与贡献指南](guidelines/README.md) |

---

<!-- ==================== 成长地图 ==================== -->
## 🗺️ 成长地图

按以下路径循序渐进，从环境准备到独立开发：

### 🌱 入门阶段

| 学习步骤 | 内容说明 | 入口 |
|---------|---------|------|
| **环境准备** | CANN 一键安装 | [CANN 一键安装](https://www.hiascend.com/cann/download) |
| **概念原理** | Runtime 核心概念与编程模型：Host-Device 架构、Context、Stream、同步异步、典型执行流程 | [Runtime 简介](quick_start/Runtime简介.md) · [编程模型](quick_start/Runtime编程模型.md) |
| **Hello CANN** | 第一个可运行的 Runtime 程序，完成最小计算闭环 | [Hello CANN](../../example/0_quickstart/0_hello_cann/README.md) |

---

### 🚀 进阶阶段

| 主题 | 核心内容 | 对应样例 |
|------|---------|---------|
| **初始化** | 包括环境初始化、设备资源配置、日志管理等 | [device_normal](../../example/1_basic_features/device/0_device_normal/README.md) |
| **内存管理** | 包括 Host 内存管理、Device 内存管理、多流同步内存、内存拷贝（同步异步）、物理内存共享 (pid) 等 | [h2d_sync_memory_copy](../../example/1_basic_features/memory/1_h2d_sync_memory_copy/README.md) |
| **异步任务** | 包括 Stream 管理、Event 管理、Kernel 加载与执行、内存语义同步等 | [simple_stream](../../example/1_basic_features/stream/0_simple_stream/README.md) |

---

### 🔥 高级阶段

| 主题 | 核心内容 | 对应样例 |
|------|---------|---------|
| **ACL Graph** | 包括单流捕获、跨流捕获、任务更新等 | [model_update](../../example/2_advanced_features/model_ri/1_model_update/README.md) |
| **多设备编程** | 包括跨 Device 数据交互、P2P 内存访问、多卡并行调度等 | [device_P2P](../../example/1_basic_features/device/2_device_P2P/README.md) |
| **进程间通信** | 包括 IPC Event 同步、IPC 内存共享（指定 PID/不指定 PID）等 | [ipc_event](../../example/2_advanced_features/ipcevent/0_ipcevent/README.md) · [ipc_memory](../../example/1_basic_features/memory/11_ipc_memory_withoutpid/README.md) |
| **性能调优** | 包括 Profiling 采集并落盘、获取网络模型中算子的性能数据、可视化展示原始性能数据解析结果等 | [create_config](../../example/5_performance/profiling/0_create_config/README.md) |

---

<!-- ==================== 常见问题 ==================== -->
## ❓ 常见问题

| 问题类型 | 典型场景 | 入口 |
|---------|---------|------|
| **入门阶段** | 初始化失败、Device 配置、版本兼容等入门常见问题 | [版本不匹配](FAQ/Runtime版本与CANN版本不匹配导致的问题.md) · [aclInit 失败](FAQ/aclInit初始化失败常见原因排查.md) · [aclrtSetDevice 失败](FAQ/aclrtSetDevice调用失败.md) · [默认机制](FAQ/如何理解默认Device和默认Stream机制.md) |
| **基础开发** | 内存管理、Stream 同步、数据复制等基础 API 使用问题 | [内存申请失败](FAQ/aclrtMalloc内存申请失败常见原因.md) · [Stream 下发失败](FAQ/aclrtMemcpyAsync在错误的Stream上下发失败.md) · [内存策略](FAQ/如何选择合适的内存分配策略.md) · [同步机制](FAQ/Stream同步与Event同步的区别与选择.md) |
| **进阶场景** | 多设备编程、ACL Graph、进程通信等复杂场景问题 | [多Device Stream](FAQ/多Device场景下Stream跨Device下发失败.md) · [ACL Graph 任务提交](FAQ/ACLGraph捕获过程中任务提交限制.md) · [IPC 页表对齐](FAQ/进程间IPC内存共享的页表对齐要求.md) · [P2P 配置失败](FAQ/跨DeviceP2P数据交互配置失败.md) |
| **错误排查** | 错误码解读、算子异常、日志定位等诊断方法 | [异步错误码](FAQ/如何获取和解读Runtime异步错误码.md) · [算子输出异常](FAQ/算子执行输出全0的常见原因排查.md) · [遇错即停定位](FAQ/遇错即停模式下错误定位方法.md) · [plog 日志定位](FAQ/如何通过plog日志定位Device侧异常.md) |

---

<!-- ==================== 底部链接 ==================== -->
<p align="center">
  <b>相关资源</b><br>
  <a href="https://www.hiascend.com">昇腾社区</a> ·
  <a href="../../example/README.md">Runtime 样例仓库</a> ·
  <a href="https://www.hiascend.com/document">完整文档中心</a>
</p>

<p align="center">
  <sub>CANN Runtime 文档 | 华为昇腾</sub>
</p>
