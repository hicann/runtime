# 知识来源边界规则

## 总体原则

断点分析的核心价值在于**真实还原新手体验**，因此必须严格限制知识来源，
确保发现的断点是开发者实际会遇到的阻塞，而非因为评估者使用了额外资料而跳过了问题。

## 知识来源矩阵

| 知识领域 | 允许的来源 | 禁止的来源 | 理由 |
|---------|-----------|-----------|------|
| Runtime API 用法 | **仅限**仓库 docs/ 和 example/ | 华为官网、CSDN、博客、Stack Overflow、CUDA/ROCm 经验推断 | 评估 Runtime 仓库文档是否自足 |
| 两段式调用范式 / workspace / executor 概念 | **直接查** `references/aclnn-two-phase-calling.md` 和 `reference/ops-math/docs/zh/context/两段式接口.md` | 期望 Runtime docs/ 包含、华为官网、CSDN、自行猜测 | 属于 aclnn 知识，非 Runtime 仓职责 |
| aclnn 算子库 API | **优先**查 `reference/ops-nn/`、`reference/ops-transformer/`、`reference/ops-math/`，不足时向用户求助 | 华为官网、CSDN、博客、自行猜测 | aclnn 调用路径是评估对象的一部分，外源知识优先从 reference 仓库获取 |
| Tensor/Scalar API | **优先**仓库 docs/ 和 example/，不足时查 `reference/` 下相关仓库，仍不足时向用户求助 | 华为官网、CSDN、博客、自行猜测 | 数据描述 API 是调用链的关键环节 |
| AscendC 相关知识 | **优先** `reference/asc-devkit/`，不足时向用户求助 | 外部网络、自行猜测 | 外源知识优先从 reference 仓库获取 |
| 其他非 Runtime 仓知识 | **优先** `reference/` 下查找，不足时向用户求助 | 外部网络、自行猜测 | 外源知识优先从 reference 仓库获取 |
| C/C++ 编程 | 角色已有技能 | — | 通用基础技能 |
| CMake 构建 | 角色已有技能 | — | 通用基础技能 |
| 异构计算概念 | 角色已有技能 | — | 通用基础概念 |

## 详细规则

### Runtime API（最严格）

- 只能从仓库根目录下的 `docs/` 和 `example/` 获取信息
- 不得使用华为官网的 Runtime API 文档
- 不得使用 CSDN、博客、论坛等第三方资料
- 不得凭借对 CUDA Runtime / PyTorch C++ API 的经验推断参数含义
- 遇到资料不足时，**必须记录为断点**，不得脑补

### 非 Runtime 仓知识（优先查 reference/，不足时向用户求助）

- aclnn 算子签名、参数含义等知识**优先从 `reference/` 目录获取**：
  - aclnn 算子信息 → `reference/ops-nn/`、`reference/ops-transformer/`、`reference/ops-math/`
  - AscendC 编程指导 → `reference/asc-devkit/`
- Tensor/Scalar API 先查 Runtime 仓库 docs/example/，不足时查 `reference/` 下相关仓库
- 如果 `reference/` 中找到了所需信息 → 标注 `[reference: 仓库名/文件路径]`，直接使用
- 如果 `reference/` 中未找到所需信息 → **暂停并向用户求助**
- **不得**使用外部网络搜索相关知识
- **不得**自行猜测或脑补外源知识
- `reference/` 中的信息和用户提供的外源知识均作为**权威输入**

### 推测性知识

- 在断点记录中可以注明推测，格式：`[推测] 根据对类似框架的经验，此处可能需要 XXX`
- 推测必须明确标记，不得当作确定信息使用
- 推测性代码用 `[UNKNOWN: 原因]` 占位，不计入代码产出
- 推测可帮助读者理解问题的可能解决方向

### 衔接区域

aclnn 算子库与 Runtime 的交界处，按知识归属分别处理：

**属于 aclnn 知识（非 Runtime 范畴），直接从 `reference/` 查找：**
- 两段式调用范式（GetWorkspaceSize → Execute 概念） → `references/aclnn-two-phase-calling.md`、`reference/ops-math/docs/zh/context/两段式接口.md`
- workspace / executor 概念 → `references/aclnn-two-phase-calling.md`
- aclnnStatus 错误码 → `reference/ops-*/` 下查找
- aclnn 头文件和链接库说明 → `references/aclnn-two-phase-calling.md` 或 `reference/ops-*/docs/`

**属于 opbase 知识（非 Runtime 范畴），先查 Runtime example/ 再查 `reference/`：**
- Tensor/Scalar 创建 API（aclCreateTensor、aclCreateScalar） → 先查 `example/quickstart/main.cpp` 获取用法示例，不足时查 `reference/`

**以上均不属于 Runtime 缺陷**，如果 Runtime 仓库中缺少这些内容的文档，记录为**外源知识缺失**（不计入整改项）。Runtime 仓库可以（但不是必须）提供指向外源文档的指引链接。

## 标注规范

| 标注 | 含义 | 示例 |
|------|------|------|
| `[Runtime docs]` | 信息来自 Runtime 仓库文档 | `aclrtSetDevice(deviceId) [Runtime docs: docs/03_api_ref/aclrtSetDevice.md]` |
| `[Runtime example]` | 信息来自 Runtime 仓库示例 | `参考 example/quickstart/main.cpp 第 42 行` |
| `[reference: 仓库名/路径]` | 信息来自 reference/ 下的外源知识仓库 | `aclnnAdd 签名参考 [reference: ops-nn/docs/aclnn_add.md]` |
| `[用户提供]` | 信息来自用户提供的外源知识 | `算子签名参考 [用户提供]` |
| `[推测]` | 基于经验的推测 | `[推测] 类似 PyTorch 的 torch.add` |
| `[UNKNOWN: 原因]` | 无法确定的代码 | `[UNKNOWN: 文档未说明 strides 计算方式]` |
