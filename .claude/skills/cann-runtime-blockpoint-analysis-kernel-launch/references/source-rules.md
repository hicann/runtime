# 知识来源边界规则

## 总体原则

断点分析的核心价值在于**真实还原新手体验**，因此必须严格限制知识来源，
确保发现的断点是开发者实际会遇到的阻塞，而非因为评估者使用了额外资料而跳过了问题。

## 知识来源矩阵

| 知识领域 | 允许的来源 | 禁止的来源 | 理由 |
|---------|-----------|-----------|------|
| Runtime API 用法 | **仅限**仓库 docs/ 和 example/ | 华为官网、CSDN、博客、Stack Overflow、CUDA/ROCm 经验推断 | 评估 Runtime 仓库文档是否自足 |
| AscendC 核函数编写 | **优先** `reference/asc-devkit/`，不足时向用户求助 | 外部网络、自行猜测 | 外源知识优先从 reference 仓库获取 |
| AscendC 核函数编译 | **优先** `reference/asc-devkit/`，不足时向用户求助 | 外部网络、自行猜测 | 外源知识优先从 reference 仓库获取 |
| aclnn 算子相关知识 | **优先** `reference/ops-nn/`、`reference/ops-transformer/`、`reference/ops-math/`，不足时向用户求助 | 外部网络、自行猜测 | 外源知识优先从 reference 仓库获取 |
| 其他非 Runtime 仓知识 | **优先** `reference/` 下查找，不足时向用户求助 | 外部网络、自行猜测 | 外源知识优先从 reference 仓库获取 |
| C/C++ 编程 | 角色已有技能 | — | 通用基础技能 |
| CMake 构建 | 角色已有技能 | — | 通用基础技能 |
| 异构计算概念 | 角色已有技能 | — | 通用基础概念 |

## 详细规则

### Runtime API（最严格）

- 只能从仓库根目录下的 `docs/` 和 `example/` 获取信息
- 不得使用华为官网的 Runtime API 文档
- 不得使用 CSDN、博客、论坛等第三方资料
- 不得凭借对 CUDA Runtime / ROCm HIP 的经验推断参数含义
- **不得**使用仓库根目录下的《AscendC算子开发指南》或其他非 docs/example/ 目录
- 遇到资料不足时，**必须记录为断点**，不得脑补

### 非 Runtime 仓知识（优先查 reference/，不足时向用户求助）

- AscendC 核函数编写、编译、tiling 等外源知识**优先从 `reference/` 目录获取**：
  - AscendC 编程指导 → `reference/asc-devkit/`
  - aclnn 算子信息 → `reference/ops-nn/`、`reference/ops-transformer/`、`reference/ops-math/`
- 如果 `reference/` 中找到了所需信息 → 标注 `[reference: 仓库名/文件路径]`，直接使用
- 如果 `reference/` 中未找到所需信息 → **暂停并向用户求助**
- **不得**使用外部网络搜索 AscendC 相关知识
- **不得**自行猜测或脑补外源知识
- `reference/` 中的信息和用户提供的外源知识均作为**权威输入**

### 不确定责任归属时

- 如果无法判断某知识是否属于 Runtime 仓库职责范围，**暂停并向用户确认**
- 提问格式："请确认 XXX 是否属于 Runtime 仓库的职责范围？"
- 用户回复后按其判定归类：
  - 属于 Runtime → 记录为 **Runtime 缺陷**（阻塞点或优化点）
  - 不属于 Runtime → 记录为**外源知识缺失**，优先从 `reference/` 查找，不足时向用户求助

### 推测性知识

- 在断点记录中可以注明推测，格式：`[推测] 根据对类似框架的经验，此处可能需要 XXX`
- 推测必须明确标记，不得当作确定信息使用
- 推测性代码用 `[UNKNOWN: 原因]` 占位，不计入代码产出
- 推测可帮助读者理解问题的可能解决方向

### 衔接区域

AscendC 与 Runtime 的交界处需要区分**语法定义**和**使用示例**：

**`<<<>>>` 内核调用符：**
- `<<<>>>` 的语法定义和参数语义（blockDim、l2ctrl/dynUBufSize/thread_num_per_block、stream 的含义和取值）→ **属于 AscendC（asc-devkit）**，从 `reference/asc-devkit/` 获取，记录为**外源知识缺失**
- `<<<>>>` 在 Runtime 示例中的使用方式（如 Runtime 仓库是否有调用示例）→ **属于 Runtime 仓**，记录为 **Runtime 缺陷**

**编译配置（`find_package(ASC)` 等）：**
- ASC 编译器本身的功能和用法 → **属于 AscendC（asc-devkit）**，记录为**外源知识缺失**
- Runtime 仓库是否提供了足够的构建方式说明或示例 → 视情况归类

**其他衔接区域：**
1. 先查 Runtime 仓库 docs/ 和 example/
2. 再查 `reference/` 下的外源知识仓库
3. 如果仍不确定责任归属，向用户确认
4. 按用户判定归类为 Runtime 缺陷或外源知识缺失

## 标注规范

| 标注 | 含义 | 示例 |
|------|------|------|
| `[Runtime docs]` | 信息来自 Runtime 仓库文档 | `aclrtSetDevice(deviceId) [Runtime docs: docs/03_api_ref/aclrtSetDevice.md]` |
| `[Runtime example]` | 信息来自 Runtime 仓库示例 | `参考 example/kernel/0_launch_kernel/main.cpp 第 15 行` |
| `[reference: 仓库名/路径]` | 信息来自 reference/ 下的外源知识仓库 | `核函数编写参考 [reference: asc-devkit/docs/xxx.md]` |
| `[用户提供]` | 信息来自用户提供的外源知识 | `核函数编写参考 [用户提供]` |
| `[推测]` | 基于经验的推测 | `[推测] 类似 CUDA 的 <<<gridDim, blockDim, stream>>>` |
| `[UNKNOWN: 原因]` | 无法确定的代码 | `[UNKNOWN: 文档未说明参数格式]` |
