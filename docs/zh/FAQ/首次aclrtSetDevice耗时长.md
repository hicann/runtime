# 首次aclrtSetDevice耗时长

## 问题现象描述

**现象1：业务进程首次调用aclrtSetDevice接口存在秒级时延**

业务进程首次调用 aclrtSetDevice 接口时耗时明显偏长（秒级时延），而后续再次调用同一接口耗时显著缩短（毫秒级）。

**现象2：多进程场景下各进程首次aclrtSetDevice耗时存在抖动**

多个业务进程并发调用 aclrtSetDevice 时，各进程的首次调用耗时不一致，存在明显抖动，部分进程耗时可能进一步增大。

**现象3：后续进程首次aclrtSetDevice耗时明显缩短**

当已有进程完成 aclrtSetDevice 后，新启动的业务进程首次调用 aclrtSetDevice 耗时显著降低，因为算子包搬移成果可在进程间共享。

## 可能原因

1. **算子包搬移开销**：首次 aclrtSetDevice 时需要将算子包从 Host 侧搬移到 Device 侧，涉及文件传输和部署，是主要耗时来源之一。
2. **aicpu_scheduler 进程拉起**：首次 aclrtSetDevice 时需要在 Device 侧为该业务进程拉起对应的 aicpu_scheduler 调度进程。各业务进程的 aicpu_scheduler 进程相互独立、不可共享，每个进程都会分别拉起自己的 aicpu_scheduler，进程创建和初始化带来额外耗时。
3. **并发与设备负载影响**：多进程并发调用 aclrtSetDevice 时，算子包搬移和 aicpu_scheduler 进程拉起受 Device 侧资源竞争和负载影响，导致接口耗时抖动。

## 处理步骤

### 原因1：算子包搬移开销

**解决方法**：
- 理解搬移机制：首次 aclrtSetDevice 时，Runtime 会将业务所需的算子包从 Host 侧传输到 Device 侧并部署，该过程涉及文件 I/O 和 Device 侧写入，耗时与算子包大小正相关。
- 利用搬移缓存：算子包搬移成功后会在 Device 侧缓存。如果不同业务进程使用的算子包版本一致，后续进程的首次 aclrtSetDevice 不涉及重复搬移，耗时显著缩短。
- 保持算子包版本一致：确保多个业务进程使用相同版本的 CANN 算子包，以最大化共享搬移缓存。
- 预热策略：在业务启动阶段安排一个轻量级进程优先执行 aclrtSetDevice，完成算子包搬移，后续业务进程即可享受加速效果。

### 原因2：aicpu_scheduler 进程拉起

**解决方法**：
- 理解拉起机制：aicpu_scheduler 是 Device 侧的 AICPU 任务调度进程，首次 aclrtSetDevice 时由 Runtime 自动为当前业务进程拉起，负责该进程的 AICPU 算子任务调度。进程创建、初始化和就绪确认均需要时间。
- 各业务进程的 aicpu_scheduler 进程相互独立、不可共享：每个业务进程首次 aclrtSetDevice 时都会分别拉起自己的 aicpu_scheduler 进程，该开销无法通过其他进程预热来消除。
- 如果对首次调用延迟敏感，可在业务初始化阶段提前调用 aclrtSetDevice 完成预热，将延迟前置到非关键路径。

### 原因3：并发与设备负载影响

**解决方法**：
- 避免高并发同时初始化：多业务进程同时调用 aclrtSetDevice 会导致算子包搬移和 aicpu_scheduler 拉起产生资源竞争，增加各进程的等待时间。
- 错峰初始化：合理安排各业务进程的启动时序，避免在同一时刻集中调用 aclrtSetDevice。
- 降低 Device 侧负载：在 aclrtSetDevice 调用前避免向 Device 下发大量计算任务，减少资源竞争对初始化耗时的影响。

## 相关 issue

暂无相关Issue。
