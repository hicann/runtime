# API 资料支撑情况表模板

## 用途

在 Step 5（编写 Runtime 调用框架代码）中，逐 API 填写此表，
记录每个 API 的文档覆盖情况和代码可写性。

## 表格格式

| API / 操作 | 文档位置 | 参数说明完整度 | 示例代码位置 | 资料来源 | 能否写出调用 |
|------------|----------|---------------|-------------|---------|-------------|
| aclInit | 有/无/不完整 | 完整/缺参数/无说明 | 有/无 | Runtime docs | 是/否/靠猜测 |
| aclrtSetDevice | 有/无/不完整 | 完整/缺参数/无说明 | 有/无 | Runtime docs | 是/否/靠猜测 |
| aclrtCreateStream | 有/无/不完整 | 完整/缺参数/无说明 | 有/无 | Runtime docs | 是/否/靠猜测 |
| aclrtMalloc | 有/无/不完整 | 完整/缺参数/无说明 | 有/无 | Runtime docs | 是/否/靠猜测 |
| aclrtMemcpy (H2D) | 有/无/不完整 | 完整/缺参数/无说明 | 有/无 | Runtime docs | 是/否/靠猜测 |
| aclCreateTensor | 有/无/不完整 | 完整/缺参数/无说明 | 有/无 | Runtime docs | **衔接重点** |
| aclCreateScalar | 有/无/不完整 | 完整/缺参数/无说明 | 有/无 | Runtime docs | **衔接重点**（如 $0 不需要 Scalar，标注为"不适用"） |
| $0GetWorkspaceSize | 有/无/不完整 | 完整/缺参数/无说明 | 有/无 | Runtime docs | **衔接重点** |
| $0 | 有/无/不完整 | 完整/缺参数/无说明 | 有/无 | Runtime docs | **衔接重点** |
| aclrtSynchronizeStream | 有/无/不完整 | 完整/缺参数/无说明 | 有/无 | Runtime docs | 是/否/靠猜测 |
| aclrtMemcpy (D2H) | 有/无/不完整 | 完整/缺参数/无说明 | 有/无 | Runtime docs | 是/否/靠猜测 |
| aclDestroyTensor | 有/无/不完整 | 完整/缺参数/无说明 | 有/无 | Runtime docs | **衔接重点** |
| aclDestroyScalar | 有/无/不完整 | 完整/缺参数/无说明 | 有/无 | Runtime docs | **衔接重点**（如 $0 不需要 Scalar，标注为"不适用"） |
| 结果验证 | 有/无/不完整 | - | 有/无 | Runtime docs | 是/否/靠猜测 |
| 资源释放 | 有/无/不完整 | 完整/缺参数/无说明 | 有/无 | Runtime docs | 是/否/靠猜测 |

## 填写说明

### 文档位置
- 记录具体文件路径，如 `docs/03_api_ref/aclrtMalloc.md`
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
- `Runtime example`：来自 Runtime 仓库 example/（含 quickstart 及其他示例）
- `推测`：基于经验推测

### 能否写出调用
- **是**：有充分文档支撑，可写出正确调用
- **否**：资料完全缺失，无法写出
- **靠猜测**：资料不完整，靠推测或从示例反推勉强写出
- **衔接重点**：标记为 aclnn 算子库与 Runtime 衔接区域的关键 API
- **不适用**：$0 不需要此 API（如不需要 Scalar 参数的算子）
