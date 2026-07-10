# Error Message 检视清单

## Overview

用于检查 ErrMsg 宏修改是否合规，重点关注 **error_code.json / error_code_meta.h 双源文本质量**、**宏参数数量匹配**、**ErrMsg 语法问题**和**参数类型**。

## 1. error_code.json 校验

### 校验项 — error_code.json 与 error_code_meta.h 双源同步校验
（1）新增或修改错误码时，**必须同时更新两处**并保持一致：

| 文件 | 用途 | 消费方 |
|------|------|--------|
| `src/dfx/error_manager/error_code.json` | 外部错误码元数据 | `ErrorManager::ATCReportErrMessage`（ATC / 外部上报路径） |
| `src/runtime/core/inc/common/error_code_meta.h` → `RUNTIME_ERROR_CODE_TABLE` | X-Macro 元数据表 | `GetParamNames()` / `PrintErrMsgToLog()` |

（2）ErrMessage 模板**必须完全一致**（含标点、空格）
（3）Arglist 参数名与参数数量**必须完全一致**
（4）如仅更新一处而遗漏另一处，会导致 ATC 上报与运行时打屏消息不一致，或参数数量校验失败

### 校验项 — ErrMessage 文本校验

（1）首字母未大写：第一个英文字母应大写（占位符除外）
（2）末尾句号缺失：完整句子末尾应有句号；最后 `%s` 是独立 `extend_info` 且模板无句号时属于设计选择
（3）`%s` 数量与 Arglist 不匹配：ErrMessage 中 `%s` 数量必须等于 Arglist 参数数量

### 校验项 — suggestion 校验

（1）缺少 suggestion
（2）suggestion 中，多条信息不使用换行符 `\n`，应使用空格分隔，如有特殊情况则特殊处理
（3）编号后缺空格：`1.`/`2.` 后应有空格
（4）统一使用 N/A：`NA` → `N/A`
（5）首字母未大写：第一个英文字母应大写
（6）末尾句号缺失：完整句子末尾应有句号；N/A 不需要
（7）语法错误：主谓一致、时态、介词、拼写

## 2. 修改点使用宏 + 错误码校验

### 校验项 — 参数数量校验

在 `error_code_meta.h` 的 `RUNTIME_ERROR_CODE_TABLE` 中，每个 EE/EH 错误码均有 Arglist 参数，表示当前错误码所需传入的参数。如传入参数数量错误，ErrMsg 打屏上报会失败。

参数数量计算规则：

```
有效参数数量 == GetParamNames(ErrorCode) 的大小
```

`PrintErrMsgToLog` 在参数数量不匹配时会直接 return 并打印警告日志。

**EE 层宏参数计算规则：**

（1）最底层外部错误码打屏宏 `RT_LOG_OUTER_MSG_IMPL`，不自动添加任何参数

（2）自动前置函数名的宏 `RT_LOG_OUTER_MSG_WITH_FUNC` 及再次封装后的宏，自动添加 `__func__` 作第一个参数。**有效参数 = 1 + len(args)**。勿手动重复传 `__func__`。`RT_LOG_OUTER_MSG_WITH_FUNC_DESC` 及其封装宏（如 `RT_LOG_OUTER_MSG_INVALID_PARAM_WITH_DESC`）行为类似，但自动添加的是调用者传入的 `funcDesc` 而非 `__func__`。

（3）专用宏为简化使用，通常自动处理通用参数，有效参数要根据实际情况计算。如 `RT_LOG_OUTER_MSG_INVALID_PARAM` 宏为 EE1003 专用，展开链为：

```
RT_LOG_OUTER_MSG_INVALID_PARAM(parm, expect)
  → RT_LOG_OUTER_MSG_WITH_FUNC(EE1003, (parm), #parm, expect)
    → RT_LOG_OUTER_MSG_IMPL(EE1003, __func__, (parm), #parm, expect)
```

有效参数 = 3 + len(args)。EE1003 期望 4 个参数，可变参数应为 1 个（即期望值 expect）。`RT_LOG_OUTER_MSG_INVALID_PARAM_WITH_DESC(funcDesc, parm, expect)` 展开链相同，仅将 `__func__` 替换为 `funcDesc`。

**EH 层宏说明：**

EH 系列错误码（ACL 层）使用 `acl::AclErrorLogManager::ReportInputError` 上报，通过 key-value 字符串向量传参，不走 `RT_LOG_OUTER_MSG_*` 宏链。参数数量校验规则相同：传入的 value 数量必须等于 Arglist 参数数量。

### 校验项 — 参数值校验

（1）参数值避免使用 `std::string` 拼接方式：该方式创建临时变量会导致 so 变大，建议使用 `RtFmtMsg` 函数（定义于 `rt_log.h`）以格式化字符串方式传入宏

（2）末尾句号缺少或重复：通过结构化参数宏传入外部错误码时，参数是否需末尾句号取决于 ErrMessage 模板。

- 模板中 `%s` **之后有句号** → 传入参数**不加句号**（避免双句号 ".."）
- 模板中 `%s` **之后没有句号**，且参数是完整英文句子 → **应加句号**

## 3. 常见错误

### 3.1 WITH_FUNC 和手动 __func__ 重复

```
// ✗ WITH_FUNC 自动加 __func__，手动再传导致重复 → 参数=5，EE1011期望4
RT_LOG_OUTER_MSG_WITH_FUNC(ErrorCode::EE1011, __func__, ver, "ver", "msg");
// ✓ 只传可变参数 → 参数=1+3=4
RT_LOG_OUTER_MSG_WITH_FUNC(ErrorCode::EE1011, ver, "ver", "msg");
```

### 3.2 NA vs N/A

```
"suggestion": { "Solution": "NA" }    // ✗ 应使用 "N/A"
"suggestion": { "Solution": "N/A" }   // ✓
```

### 3.3 句号重复

```
// ✗ EE1011 的 ErrMessage 模板最后一个 %s 后有句号，reason 参数再加句号导致重复
COND_RETURN_AND_MSG_OUTER(trueStream->GetModelNum() == 0, RT_ERROR_STREAM_MODEL,
    ErrorCode::EE1011, __func__, 0, "trueStream->modelNum",
    "The stream is not bound to a model.");

// ✓ reason 参数不加句号
COND_RETURN_AND_MSG_OUTER(trueStream->GetModelNum() == 0, RT_ERROR_STREAM_MODEL,
    ErrorCode::EE1011, __func__, 0, "trueStream->modelNum",
    "The stream is not bound to a model");
```

> 注意：`COND_RETURN_AND_MSG_OUTER` 展开为 `RT_LOG_OUTER_MSG_IMPL`（不自动添加 `__func__`），因此此处手动传入 `__func__` 是正确的，与 3.1 的 WITH_FUNC 重复问题不同。

## 4. 源文件索引

| 文件 | 作用 |
|------|------|
| `src/runtime/core/inc/common/error_code_meta.h` | X-Macro 错误码元数据表 `RUNTIME_ERROR_CODE_TABLE`（GetParamNames / PrintErrMsgToLog 数据源） |
| `src/dfx/error_manager/error_code.json` | 外部错误码元数据（ATCReportErrMessage 数据源） |
| `src/runtime/core/inc/base.hpp` | 核心宏定义 + `ErrorCodeProcess` 模板函数 |
| `src/runtime/core/inc/common/rt_log.h` | `ErrorCode` 枚举 + `GetParamNames` / `PrintErrMsgToLog` / `RtFmtMsg` 声明 |
| `src/runtime/core/inc/common/error_message_manage.hpp` | `COND_*` 封装宏 + 专用宏 |
| `src/runtime/api/api_c.h` | API 层宏（含 `COND_RETURN_EXT_ERRCODE_AND_MSG_OUTER`） |
| `src/runtime/core/src/common/rt_log.cc` | `GetParamNames` + `PrintErrMsgToLog` + `DispatchErrMsg` 实现 |
