# API 资料支撑情况表模板

## 用途

在 Step 5（编写 Runtime 调用框架代码）中，逐 API 填写此表，
记录每个 API 的文档覆盖情况和代码可写性。

## 表格格式

| API / 操作 | 文档位置 | 参数说明完整度 | 示例代码位置 | 资料来源 | 能否写出调用 |
|------------|----------|---------------|-------------|---------|-------------|
| AscendC 核函数编写 | - | - | example/kernel_func/ | 用户提供 | 是/否 |
| 核函数编译（ASC 编译器） | - | - | example/ CMakeLists | 用户提供 | 是/否 |
| aclInit | 有/无/不完整 | 完整/缺参数/无说明 | 有/无 | Runtime docs | 是/否/靠猜测 |
| aclrtSetDevice | 有/无/不完整 | 完整/缺参数/无说明 | 有/无 | Runtime docs | 是/否/靠猜测 |
| aclrtCreateStream | 有/无/不完整 | 完整/缺参数/无说明 | 有/无 | Runtime docs | 是/否/靠猜测 |
| aclrtMallocHost | 有/无/不完整 | 完整/缺参数/无说明 | 有/无 | Runtime docs | 是/否/靠猜测 |
| aclrtMalloc | 有/无/不完整 | 完整/缺参数/无说明 | 有/无 | Runtime docs | 是/否/靠猜测 |
| aclrtMemcpy (H2D) | 有/无/不完整 | 完整/缺参数/无说明 | 有/无 | Runtime docs | 是/否/靠猜测 |
| `<<<>>>` 内核调用符语法 | 有/无/不完整 | 完整/缺参数/无说明 | 有/无 | Runtime docs | **衔接重点** |
| blockDim 参数含义 | 有/无/不完整 | 完整/缺参数/无说明 | 有/无 | Runtime docs | **衔接重点** |
| l2ctrl 参数含义 | 有/无/不完整 | 完整/缺参数/无说明 | 有/无 | Runtime docs | **衔接重点** |
| aclrtSynchronizeStream | 有/无/不完整 | 完整/缺参数/无说明 | 有/无 | Runtime docs | 是/否/靠猜测 |
| aclrtMemcpy (D2H) | 有/无/不完整 | 完整/缺参数/无说明 | 有/无 | Runtime docs | 是/否/靠猜测 |
| 结果验证 | 有/无/不完整 | - | 有/无 | Runtime docs | 是/否/靠猜测 |
| 资源释放（aclrtFree 等） | 有/无/不完整 | 完整/缺参数/无说明 | 有/无 | Runtime docs | 是/否/靠猜测 |
| aclrtResetDevice | 有/无/不完整 | 完整/缺参数/无说明 | 有/无 | Runtime docs | 是/否/靠猜测 |
| aclFinalize | 有/无/不完整 | 完整/缺参数/无说明 | 有/无 | Runtime docs | 是/否/靠猜测 |

## 填写说明

### 文档位置
- 记录具体文件路径，如 `docs/03_api_ref/aclInit.md`
- 如无文档，填 `无`

### 参数说明完整度
- **完整**：所有参数的类型、含义、取值范围均有说明
- **缺参数**：部分参数有说明，但关键参数缺失
- **无说明**：仅有函数签名，无参数说明

### 示例代码位置
- 记录具体文件路径和行号
- 如无示例，填 `无`

### 资料来源
- `Runtime docs`：来自 Runtime 仓库 docs/
- `Runtime example`：来自 Runtime 仓库 example/
- `用户提供`：来自用户提供的外源知识

### 能否写出调用
- **是**：有充分文档支撑，可写出正确调用
- **否**：资料完全缺失，无法写出
- **靠猜测**：资料不完整，靠推测勉强写出
- **衔接重点**：标记为 AscendC 与 Runtime 衔接区域的关键 API
