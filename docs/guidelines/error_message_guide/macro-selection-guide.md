# Error Message 上报宏使用规范

本文档用于说明 ErrMsg 上报宏的参数风格、控制流特性、适用场景和选择规则，帮助开发者根据错误码与业务场景选择正确的上报宏。

---

## 背景知识

### 错误记录的两种方式

Runtime 代码中存在两种错误记录方式：

1. **RT_LOG 日志**：通过 `RT_LOG_*` 宏记录日志，仅写入日志文件，调用方无法程序化获取。

2. **ErrMsg 上报**：通过 ErrorManager 上报结构化错误信息，调用方可程序化获取。

### ErrMsg 的完整流程

```
错误发生 → 调用上报宏 → ErrorManager 存储错误 → 调用方获取错误信息
```

- **上报**：代码中调用 ErrMsg 上报宏（如 `COND_RETURN_AND_MSG_OUTER`）
- **存储**：宏最终调用 ErrorManager 的核心函数，将错误信息存储到线程局部存储
- **获取**：
  - 内部调用方：通过 `GetErrMgrErrorMessage()` 或 `GetRawErrorMessages()` 获取
  - 外部用户：通过 `aclGetRecentErrMsg()` 接口获取

### 错误码格式

错误码格式为 6 位字符串：**E + 模块标识 + 4 位数字**

| 模块标识 | 模块名称 | 示例错误码 |
|---------|---------|-----------|
| E | Runtime | EE1001, EE9999 |
| H | ACL | EH0007, EH9999 |
| I | HCCL | EI9999 |
| L | Driver | EL9999 |
| K | Profiling | EK9999 |
| Z | 算子公共错误码和算子API执行接口接口错误码 | EZ9999 |

### 两类错误

- **内部错误**（错误码后四位为 9999）：无 JSON 模板，仅记录原始消息，用于内部逻辑错误。例如 EE9999、EI9999、EL9999。
- **外部错误**（错误码后四位为 0001~8999）：有 JSON 模板（定义在 `error_code.json`），包含 title/cause/solution，面向用户展示。例如 EE1001、EH0007。

### 四个核心上报函数

代码中封装了大量 ErrMsg 上报宏，这些宏最终都会调用 ErrorManager 的四个核心函数：

1. **`ReportInterErrMessage()`**：上报内部错误（EX9999），直接存储原始消息
2. **`ReportErrMessage()`**：上报外部错误（EX0001~EX8999），通过 args_map 填充 JSON 模板
3. **`ATCReportErrMessage()`**：上报外部错误，通过 key/value 向量填充 JSON 模板（与上一个功能相同，参数形式不同）
4. **`ReportErrMsgWithoutTpl()`**：上报用户自定义错误（EU0000~EU9999），无模板，直接存储消息

---

# 一、Runtime 模块（代码目录：`src/runtime/`）

---

## 1. 宏表格列定义

后续各节中的宏表格均使用以下列来描述每个宏的特性，各列的含义和可选值定义如下：

### 返回类型

| 值 | 含义 |
|----|------|
| rtError_t | 返回 Runtime 内部错误码 |
| void | 无返回值（`return;`） |
| ACL错误码(rt转换) | 调用 `GetRtExtErrCodeAndSetGlobalErr()` 将 rtError_t 转换为 ACL 外部错误码并设置全局错误码 |
| 无 | 仅上报或跳转，不通过 return 返回值 |

### 条件类型

| 值 | 含义 |
|----|------|
| 自定义条件 | 调用者传入任意布尔表达式（通常带 `unlikely()`） |
| 空指针 | 检查 `PTR == nullptr` |
| 零值 | 检查 `PARAM == 0U` |
| 错误码!=NONE | 检查 `ERRCODE != RT_ERROR_NONE` |
| 无条件 | 无条件上报（不检查条件） |

### PROC

| 值 | 含义 |
|----|------|
| 是 | 宏在上报前执行一段任意语句（如释放资源、关闭句柄等），对应宏名中通常含 `PROC` |
| 否 | 宏不执行前置语句 |

### GOTO

| 值 | 含义 |
|----|------|
| 是 | 宏在上报后执行 `goto LABEL` 跳转到错误处理标签，同时可能给 ERROR 变量赋值 |
| 否 | 宏不执行 goto |

### 设置全局错误码

| 值 | 含义 |
|----|------|
| 是 | 宏在上报时调用 `GetRtExtErrCodeAndSetGlobalErr()` 将 rtError_t 转换为 ACL 错误码并设置全局错误码 |
| 否 | 宏仅上报 ErrMsg，不设置全局错误码 |

### 推荐等级

| 值 | 含义 |
|----|------|
| 推荐 | 主力宏，场景明确，新代码优先使用 |
| 特定场景 | 有明确适用场景，但不如推荐宏通用 |
| 谨慎使用 | 有约束或与推荐宏重叠，需确认后再用 |
| 禁止使用 | 存在设计缺陷，禁止在新代码中使用 |
---

## 2. 字符串格式说明

ErrMsg 宏有两种字符串传入方式，使用时必须区分：

### printf 风格（_INNER 宏使用）

`_INNER` 系列宏（如 `COND_RETURN_AND_MSG_INNER`）使用 printf 风格的 `format, ...` 参数。开发者直接传入格式化字符串和可变参数：

```cpp
COND_RETURN_AND_MSG_INNER(ptr == nullptr, RT_ERROR_INVALID_VALUE,
    "Init failed, devId=%u, size=%zu", devId, size);
```

**禁止**先用 `std::string` 拼接再传入：
```cpp
// 错误用法：会导致 .so 文件膨胀
std::string msg = "Init failed, devId=" + std::to_string(devId);
COND_RETURN_AND_MSG_INNER(ptr == nullptr, RT_ERROR_INVALID_VALUE, "%s", msg.c_str());
```

如需预格式化字符串（如消息内容需要动态拼接），必须使用 `RtFmtMsg` 函数：
```cpp
// 正确用法
COND_RETURN_AND_MSG_INNER(ptr == nullptr, RT_ERROR_INVALID_VALUE,
    "%s", RtFmtMsg("Init failed, devId=%u, reason=%s", devId, reason).c_str());
```

### 结构化参数风格（_OUTER 宏使用）

`_OUTER` 系列宏（如 `COND_RETURN_AND_MSG_OUTER`）使用结构化参数，每个参数由 `ErrorCodeProcess` 自动转换为 string，匹配 `error_code_meta.h` 中 X-macro 模板的 `%s` 占位符。参数个数必须与模板一致。

```cpp
COND_RETURN_AND_MSG_OUTER(ret != RT_ERROR_NONE, RT_ERROR_FEATURE_NOT_SUPPORT,
    ErrorCode::EE1006, __func__, "stream mode switching");
```

对于需要动态拼接的 reason 参数，同样**禁止**直接用 `std::string` 相加，应使用 `RtFmtMsg`：
```cpp
// 错误用法：会导致 .so 文件膨胀
COND_RETURN_AND_MSG_OUTER(..., ErrorCode::EE1016, __func__,
    "Changing stream " + std::to_string(id) + " is not supported");

// 正确用法
COND_RETURN_AND_MSG_OUTER(..., ErrorCode::EE1016, __func__,
    RtFmtMsg("Changing stream %u is not supported", id));
```

> **为什么禁止 `std::string` 相加？** `std::string` 拼接会在编译产物中生成大量临时字符串对象和模板实例化代码，导致 .so 文件显著膨胀。`RtFmtMsg` 使用栈上 `char[]` 缓冲区 + `snprintf`，编译产物更紧凑。

---

## 3. 外部错误码宏

外部错误码有 JSON 模板，用户可通过 `GetErrMgrErrorMessage()` 获取带 title/cause/solution 的格式化消息。

### EE1003 - Invalid_Argument（参数值校验）

参数值不合法时使用。宏自动注入 `__func__` 和参数名字符串，开发者只需传入参数值和期望值。

| 宏名 | 返回类型 | 条件类型 | PROC | GOTO | 设置全局错误码 | 推荐等级 | 替代宏 |
|------|---------|---------|------|------|--------------|---------|--------|
| COND_RETURN_AND_MSG_OUTER_WITH_PARAM | rtError_t | 自定义条件 | 否 | 否 | 否 | 推荐 | — |
| COND_RETURN_AND_MSG_OUTER_WITH_PARAM_NAME | rtError_t | 自定义条件 | 否 | 否 | 否 | 推荐 | — |
| ZERO_RETURN_AND_MSG_OUTER | rtError_t | 零值 | 否 | 否 | 否 | 推荐 | — |
| COND_RETURN_EXT_ERRCODE_AND_MSG_OUTER_WITH_PARAM | ACL错误码(rt转换) | 自定义条件 | 否 | 否 | 是 | 推荐 | — |
| COND_RETURN_EXT_ERRCODE_AND_MSG_OUTER_WITH_PARAM_NAME | ACL错误码(rt转换) | 自定义条件 | 否 | 否 | 是 | 推荐 | — |
| RT_LOG_OUTER_MSG_INVALID_PARAM | 无 | 无条件 | 否 | 否 | 否 | 特定场景 | — |

### EE1004 - Invalid_Argument_Null_Pointer

空指针检查专用。宏自动使用 `#PTR`（参数名字符串化），无需手动传入。

| 宏名 | 返回类型 | 条件类型 | PROC | GOTO | 设置全局错误码 | 推荐等级 | 替代宏 |
|------|---------|---------|------|------|--------------|---------|--------|
| NULL_PTR_RETURN_MSG_OUTER | rtError_t | 空指针 | 否 | 否 | 否 | 推荐 | — |
| PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE | ACL错误码(rt转换) | 空指针 | 否 | 否 | 是 | 推荐 | — |

### EE1010 - Execution_Error_Invalid_Context

stream/model/context 等对象的归属关系校验。宏自动注入 `__func__` 和对象名。

| 宏名 | 返回类型 | 条件类型 | PROC | GOTO | 设置全局错误码 | 推荐等级 | 替代宏 |
|------|---------|---------|------|------|--------------|---------|--------|
| COND_RETURN_AND_MSG_INVALID_CONTEXT | rtError_t | 自定义条件 | 否 | 否 | 否 | 推荐 | — |
| RT_LOG_OUTER_MSG_INVALID_CONTEXT | 无 | 无条件 | 否 | 否 | 否 | 特定场景 | — |

### EE1013 - Resource_Error_Insufficient_Host_Memory

内存分配失败专用。`bufSize` 为请求分配的内存大小。

| 宏名 | 返回类型 | 条件类型 | PROC | GOTO | 设置全局错误码 | 推荐等级 | 替代宏 |
|------|---------|---------|------|------|--------------|---------|--------|
| COND_PROC_RETURN_AND_MSG_ALLOC_FAILED | rtError_t | 自定义条件 | 是 | 否 | 否 | 推荐 | — |

### EE1017 - Invalid_Argument（预留参数校验）

预留参数校验使用。`param` 为参数名，`reason` 为不合法原因。

| 宏名 | 返回类型 | 条件类型 | PROC | GOTO | 设置全局错误码 | 推荐等级 | 替代宏 |
|------|---------|---------|------|------|--------------|---------|--------|
| COND_RETURN_AND_MSG_RESERVED_PARAM | rtError_t | 自定义条件 | 否 | 否 | 否 | 推荐 | — |
| RT_LOG_OUTER_MSG_RESERVED_PARAM | 无 | 无条件 | 否 | 否 | 否 | 特定场景 | — |

### EE1001 - Invalid_Argument

**禁止使用。** EE1001 错误码及其专用宏（`COND_RETURN_OUT_ERROR_MSG_CALL`、`COND_PROC_RETURN_OUT_ERROR_MSG_CALL`），禁止在新代码中使用，仅用于兜底逻辑。


### 通用外部错误码主力封装宏

适用于 EE1005~EE1021、EE2002、WE0001 等没有专用宏的外部错误码。调用者传入 `ErrorCode` 枚举值和对应参数。

| 宏名 | 返回类型 | 条件类型 | PROC | GOTO | 设置全局错误码 | 推荐等级 | 替代宏 |
|------|---------|---------|------|------|--------------|---------|--------|
| COND_RETURN_AND_MSG_OUTER | rtError_t | 自定义条件 | 否 | 否 | 否 | 推荐 | — |
| COND_RETURN_VOID_AND_MSG_OUTER | void | 自定义条件 | 否 | 否 | 否 | 推荐 | — |
| COND_PROC_RETURN_AND_MSG_OUTER | rtError_t | 自定义条件 | 是 | 否 | 否 | 推荐 | — |
| COND_PROC_RETURN_VOID_AND_MSG_OUTER | void | 自定义条件 | 是 | 否 | 否 | 推荐 | — |
| COND_GOTO_MSG_OUTER | 无 | 自定义条件 | 否 | 是 | 否 | 推荐 | — |
| COND_RETURN_EXT_ERRCODE_AND_MSG_OUTER | ACL错误码(rt转换) | 自定义条件 | 否 | 否 | 是 | 推荐 | — |
| COND_RETURN_EXT_WARNCODE_AND_MSG_OUTER | ACL错误码(rt转换) | 自定义条件 | 否 | 否 | 是 | 推荐 | — |
---

### 通用外部错误码底层上报宏

直接调用 ErrorManager 或底层日志接口。适用于高层宏无法满足需求的特殊场景；部分宏已有更好的替代方案，不应直接使用。

| 宏名 | 错误码填入方式 | 实际错误码 | 上报类型 | 推荐等级 | 替代宏 |
|------|--------------|-----------|---------|---------|--------|
| RT_LOG_OUTER_MSG | 显式输入 | 字符串错误码 | 外部 | 特定场景 | — |
| RT_LOG_OUTER_MSG_IMPL | 显式输入 | ErrorCode 枚举 | 外部 | 特定场景 | — |
| RT_LOG_OUTER_MSG_WITH_FUNC | 显式输入 | ErrorCode 枚举 | 外部 | 特定场景 | — |
| REPORT_INPUT_ERROR | 显式输入 | 字符串错误码 | 外部 | **不能直接使用** | — |
| REPORT_ENV_ERROR | 显式输入 | 字符串错误码 | 外部 | **不能直接使用** | — |
---

### API层兜底宏

**仅用于 rt 接口层的兜底打屏，其他场景禁用** 

**映射规则**：内部通过 `FuncErrorReason()` 的 switch 映射：

| rtError_t | 上报错误码 | 上报方式 |
|-----------|-----------|---------|
| RT_ERROR_INVALID_VALUE | EE1001 | RT_LOG_OUTER_MSG（printf） |
| RT_ERROR_CONTEXT_NULL | EE1001 | RT_LOG_OUTER_MSG（printf） |
| RT_ERROR_FEATURE_NOT_SUPPORT | EE1001 | RT_LOG_OUTER_MSG（printf） |
| RT_ERROR_INVALID_HANDLE | EE1017 | RT_LOG_OUTER_MSG_IMPL（独立参数） |
| RT_ERROR_STREAM_SYNC_TIMEOUT | EE1002 | RT_LOG_OUTER_MSG（printf） |
| default | EE9999 | RT_LOG_CALL_MSG(ERR_MODULE_GE) |

| 宏名 | 返回类型 | 条件类型 | PROC | GOTO | 设置全局错误码 | 推荐等级 | 替代宏 |
|------|---------|---------|------|------|--------------|---------|--------|
| ERROR_RETURN_WITH_EXT_ERRCODE | ACL错误码(rt转换) | 错误码!=NONE | 否 | 否 | 是 | 推荐 | — |
| REPORT_FUNC_ERROR_REASON | 无 | 无 | 否 | 否 | 否 | 不能直接使用 | ERROR_RETURN_WITH_EXT_ERRCODE |
---


## 4. 内部错误码宏

内部错误码无 JSON 模板。一次错误获取中首错只展示一条：优先取第一条外部错误码作为首错（带 title/cause/solution），其余全部进入 TraceBack；若本次上报全部为内部错误码，则第一条作为首错（格式 `XX9999: Inner Error!`），其余进入 TraceBack。

### _INNER 系列（EE9999）

映射到 EE9999（或 WE9999），适用于 Runtime 内部逻辑错误。使用 printf 风格格式化字符串。

**映射规则**：`_INNER` 后缀宏通过 `RT_LOG_LEVEL_TO_ERR_MSG[]` 数组映射：RT_LOG_ERROR → EE9999，RT_LOG_WARNING → WE9999，其他 → INVALID_HEAD（异常，不应使用）。

| 宏名 | 返回类型 | 条件类型 | PROC | GOTO | 设置全局错误码 | 推荐等级 | 替代宏 |
|------|---------|---------|------|------|--------------|---------|--------|
| NULL_STREAM_PTR_RETURN_MSG | rtError_t | 空指针 | 否 | 否 | 否 | 推荐 | — |
| NULL_PTR_RETURN_MSG | rtError_t | 空指针 | 否 | 否 | 否 | 推荐 | — |
| NULL_PTR_PROC_RETURN_ERROR_MSG_INNER | rtError_t | 空指针 | 是 | 否 | 否 | 推荐 | — |
| NULL_PTR_GOTO_MSG_INNER | 无 | 空指针 | 否 | 是 | 否 | 推荐 | — |
| ZERO_RETURN_MSG | rtError_t | 零值 | 否 | 否 | 否 | 谨慎使用 | COND_RETURN_AND_MSG_INNER 或 ZERO_RETURN_AND_MSG_OUTER |
| COND_RETURN_AND_MSG_INNER | rtError_t | 自定义条件 | 否 | 否 | 否 | 推荐 | — |
| COND_RETURN_VOID_AND_MSG_INNER | void | 自定义条件 | 否 | 否 | 否 | 推荐 | — |
| COND_AND_MSG_INNER | 无 | 自定义条件 | 否 | 否 | 否 | 推荐 | — |
| COND_PROC_RETURN_ERROR_MSG_INNER | rtError_t | 自定义条件 | 是 | 否 | 否 | 推荐 | — |
| COND_RETURN_ERROR_MSG_INNER | rtError_t | 自定义条件 | 否 | 否 | 否 | 谨慎使用 | COND_RETURN_AND_MSG_INNER |
| COND_GOTO_ERROR_MSG_AND_ASSIGN_INNER | 无 | 自定义条件 | 否 | 是 | 否 | 推荐 | — |
| COND_PROC_GOTO_MSG_INNER | 无 | 自定义条件 | 是 | 是 | 否 | 推荐 | — |
| ERROR_RETURN_MSG_INNER | rtError_t | 错误码!=NONE | 否 | 否 | 否 | 推荐 | — |
| ERROR_PROC_RETURN_MSG_INNER | rtError_t | 错误码!=NONE | 是 | 否 | 否 | 推荐 | — |
| ERROR_GOTO_MSG_INNER | 无 | 错误码!=NONE | 否 | 是 | 否 | 推荐 | — |
| ERROR_PROC_GOTO_MSG_INNER | 无 | 错误码!=NONE | 是 | 是 | 否 | 推荐 | — |
| COND_RETURN_EXT_ERRCODE_AND_MSG_INNER | ACL错误码(rt转换) | 自定义条件 | 否 | 否 | 是 | 推荐 | — |
### _CALL 系列（MODULE_TYPE 映射）

通过 MODULE_TYPE 映射到对应模块的内部错误码，适用于跨模块错误上报，标记错误来源。

**映射规则**：`_CALL` 后缀宏通过 `RT_MODULE_TYPE_TO_ERR_MSG[]` 数组映射：

| MODULE_TYPE | 映射错误码 | 说明 |
|-------------|-----------|------|
| ERR_MODULE_AICPU | E39999 | AI CPU 模块 |
| ERR_MODULE_DRV | EL9999 | 驱动模块 |
| ERR_MODULE_HCCL | EI9999 | HCCL 模块 |
| ERR_MODULE_GE | EE9999 | GE 模块（不推荐新增使用） |
| ERR_MODULE_PROFILE | EK9999 | Profiling 模块 |
| ERR_MODULE_TBE | EZ9999 | TBE 模块 |
| ERR_MODULE_SYSTEM | EE9999 | 系统模块 |
| ERR_MODULE_RTS | EE9999 | RTS 模块 |
| ERR_MODULE_FE | E29999 | FE 模块 |
| ERR_MODULE_AICPU_TIMEOUT | E30008 | AI CPU 超时 |
| ERR_MODULE_INVALID_ARGUMENT | EE1001 | 非法参数 |

| 宏名 | 返回类型 | 条件类型 | PROC | GOTO | 设置全局错误码 | 推荐等级 | 替代宏 |
|------|---------|---------|------|------|--------------|---------|--------|
| NULL_PTR_PROC_RETURN_ERROR_MSG_CALL | rtError_t | 空指针 | 是 | 否 | 否 | 特定场景 | — |
| NULL_PTR_GOTO_MSG_CALL | 无 | 空指针 | 否 | 是 | 否 | 特定场景 | — |
| COND_RETURN_ERROR_MSG_CALL | rtError_t | 自定义条件 | 否 | 否 | 否 | 特定场景 | — |
| COND_PROC_RETURN_ERROR_MSG_CALL | rtError_t | 自定义条件 | 是 | 否 | 否 | 特定场景 | — |
| COND_GOTO_ERROR_MSG_AND_ASSIGN_CALL | 无 | 自定义条件 | 否 | 是 | 否 | 特定场景 | — |
| COND_PROC_GOTO_MSG_CALL | 无 | 自定义条件 | 是 | 是 | 否 | 特定场景 | — |
| ERROR_RETURN_MSG_CALL | rtError_t | 错误码!=NONE | 否 | 否 | 否 | 特定场景 | — |
| ERROR_PROC_RETURN_MSG_CALL | rtError_t | 错误码!=NONE | 是 | 否 | 否 | 特定场景 | — |
| ERROR_GOTO_MSG_CALL | 无 | 错误码!=NONE | 否 | 是 | 否 | 特定场景 | — |
| ERROR_PROC_GOTO_MSG_CALL | 无 | 错误码!=NONE | 是 | 是 | 否 | 特定场景 | — |

### 内部错误码底层上报宏

直接调用 ErrorManager 或底层日志接口。适用于高层宏无法满足需求的特殊场景；部分宏已有更好的替代方案，不应直接使用。

| 宏名 | 错误码填入方式 | 实际错误码 | 上报类型 | 推荐等级 | 替代宏 |
|------|--------------|-----------|---------|---------|--------|
| RT_LOG_INNER_MSG | 映射 | RT_LOG_LEVEL | 内部 | 特定场景 | — |
| RT_LOG_CALL_MSG | 映射 | MODULE_TYPE | 内部 | 特定场景 | — |
| RT_LOG_CALL_MSG_NO_RT_LOG | 映射 | MODULE_TYPE | 内部 | **不能直接使用** | RT_LOG_CALL_MSG |
| REPORT_INNER_ERROR | 显式输入 | 字符串错误码 | 内部 | **不能直接使用** | RT_LOG_INNER_MSG |
| REPORT_CALL_ERROR | 显式输入 | 字符串错误码 | 内部 | **不能直接使用** | RT_LOG_CALL_MSG |

---

## 5. 快速选择指南

建议按照下面的方式选择符合自己要求的宏：

```
我要上报的错误码是否有专用的宏？
├─ 是（EE1003/EE1004/EE1010/EE1013/EE1017，见第3节）
│   └─ 专用宏是否能满足我的场景？（根据 PROC/GOTO/返回类型/设置全局错误码 判断）
│       ├─ 是 → 使用专用宏
│       └─ 否
│           └─ 通用宏是否能满足我的场景？
│               ├─ 是 → 使用通用宏（见第3节「通用外部错误码主力封装宏」）
│               └─ 否 → 使用底层宏（见第3节「通用外部错误码底层上报宏」）
│
└─ 否（EE1001 禁止使用；EE1005~EE1021、EE2002、WE0001 等无专用宏）
    └─ 通用宏是否能满足我的场景？
        ├─ 是 → 使用通用宏（见第3节「通用外部错误码主力封装宏」）
        └─ 否 → 使用底层宏（见第3节「通用外部错误码底层上报宏」）
```

对于内部错误码（EE9999 / MODULE_TYPE 映射），选择方式类似：

```
我要上报内部错误码
├─ 当前代码属于 Runtime 自身模块 → 使用 _INNER 系列（见第4节）
│   └─ _INNER 主力宏是否能满足我的场景？
│       ├─ 是 → 使用 _INNER 主力宏
│       └─ 否 → 使用 _INNER 底层宏（见第4节「内部错误码底层上报宏」）
│
└─ 当前代码调用了其他模块（GE/DRV/HCCL 等），需要标记错误来源
    → 使用 _CALL 系列 + 对应 ERR_MODULE_xxx（见第4节）
```

对于 API 层兜底场景（仅用于 rt 接口层）：

```
我要在 rt API 入口函数中做兜底返回
└─ 使用 ERROR_RETURN_WITH_EXT_ERRCODE（见第3节「API层兜底宏」）
```

# 二、ACL 模块（代码目录：`src/acl/`）

> 组织原则：以 EH 错误码为主维度，专用宏优先于通用宏。

---

## 1. 宏表格列定义

后续各节中的宏表格均使用以下列来描述每个宏的特性，各列的含义和可选值定义如下：

### 返回类型

| 值 | 含义 |
|----|------|
| aclError | 返回 ACL 错误码（如 `ACL_ERROR_INVALID_PARAM`） |
| nullptr | 返回空指针 |
| void | 无返回值（`return;`） |
| 原始返回值 | 透传被调用函数的返回值（如 rtError_t、ge::Status） |
| 无 | 仅上报日志，不改变控制流 |

### 条件类型

| 值 | 含义 |
|----|------|
| 空指针 | 检查 `val == nullptr` |
| 参数值 | 检查参数值是否合法（范围、正负、等值等） |
| 返回值!=OK | 检查被调用函数的返回值是否非成功 |
| 自定义条件 | 调用者传入任意布尔表达式 |
| 无条件 | 无条件上报（不检查条件） |

### 上报 ErrMsg

| 值 | 含义 |
|----|------|
| EH00xx | 通过 `AclErrorLogManager::ReportInputError()` 上报预定义 EH 错误码 |
| EH9999 | 通过 `AclErrorLogManager::ReportInnerError()` 或 `ReportCallError()` 上报内部错误 |

---

## 2. EH 错误码参考

| 常量名 | 错误码 | 用途 |
|--------|--------|------|
| `INVALID_PARAM_MSG` | EH0001 | 非法参数（通用） |
| `INVALID_NULL_POINTER_MSG` | EH0002 | 空指针（通用） |
| `INVALID_PATH_MSG` | EH0003 | 非法路径 |
| `INVALID_FILE_MSG` | EH0004 | 非法文件 |
| `INVALID_AIPP_MSG` | EH0005 | 非法 AIPP 参数 |
| `UNSUPPORTED_FEATURE_MSG` | EH0006 | 不支持的功能 |
| `INVALID_VALUE_MSG` | EH0007 | 非法值（带期望值） |
| `NULL_POINTER_FUNC_MSG` | EH0008 | 空指针（函数参数） |
| `INVALID_PARAM_REASON_MSG` | EH0009 | 非法参数（带原因） |
| `ALLOC_MEMORY_FAILED_MSG` | EH0010 | 内存分配失败 |
| `UNSUPPORTED_SYSTEM_MSG` | EH0011 | 不支持的系统 |
| `INVALID_PARAM_NO_VALUE_MSG` | EH0012 | 非法参数（无值） |
| `STANDARD_FUNC_FAILED_MSG` | EH0013 | 标准函数调用失败 |
| （硬编码） | EH9999 | 内部错误/调用错误（兜底） |

---

## 3. 空指针检查宏（EH0008）

检查指针是否为 `nullptr`，满足时上报 EH0008 错误并返回。这是 ACL 层使用最频繁的宏族（472+ 处使用）。

| 宏名 | 返回类型 | 条件类型 | 上报 ErrMsg | 推荐等级 | 替代宏 |
|------|---------|---------|------------|---------|--------|
| ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT | ACL_ERROR_INVALID_PARAM | 空指针 | EH0008 | 推荐 | — |
| ACL_REQUIRES_NOT_NULL_RET_INPUT_REPORT | 调用者指定 | 空指针 | EH0008 | 推荐 | — |
| ACL_REQUIRES_NOT_NULL_RET_NULL_INPUT_REPORT | nullptr | 空指针 | EH0008 | 推荐 | — |
| ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT_WITH_PRAM_NAME | ACL_ERROR_INVALID_PARAM | 空指针 | EH0008 | 特定场景 | — |

**说明**：
- `ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT` 是首选宏，返回 `ACL_ERROR_INVALID_PARAM` 并上报 EH0008
- `_WITH_PRAM_NAME` 变体用于参数名与变量名不同的场景

---

## 4. 参数值校验宏（EH0007 / EH0009 / EH0012）

### EH0007 - 非法值（带期望值）

参数值不合法时使用。宏自动注入 `__func__`、参数值、参数名和期望值。

| 宏名 | 返回类型 | 条件类型 | 上报 ErrMsg | 推荐等级 | 替代宏 |
|------|---------|---------|------------|---------|--------|
| ACL_CHECK_INVALID_VALUE_WITH_EXPECT | ACL_ERROR_INVALID_PARAM | 参数值（取反） | EH0007 | 推荐 | — |
| ACL_CHECK_INVALID_VALUE_WITH_EXPECT_RET | 调用者指定 | 参数值（取反） | EH0007 | 推荐 | — |
| ACL_CHECK_INVALID_VALUE_WITH_DESC | 调用者指定 | 参数值（取反） | EH0007 | 特定场景 | — |
| ACL_REQUIRES_PARAM_EQUAL_REPORT | ACL_ERROR_INVALID_PARAM | 参数值（不等） | EH0007 | 推荐 | — |
| ACL_REQUIRES_POSITIVE_REPORT | ACL_ERROR_INVALID_PARAM | 参数值（<=0） | EH0007 | 推荐 | — |

**说明**：
- `ACL_CHECK_INVALID_VALUE_WITH_EXPECT` 系列的条件是**取反**的：`if (!(condition))` 表示条件不满足时报错
- `ACL_REQUIRES_PARAM_EQUAL_REPORT` 用于参数必须等于某个特定值的场景
- `ACL_REQUIRES_POSITIVE_REPORT` 用于参数必须为正数的场景

### EH0009 - 非法参数（带原因）

参数非法且需要详细说明原因时使用。

| 宏名 | 返回类型 | 条件类型 | 上报 ErrMsg | 推荐等级 | 替代宏 |
|------|---------|---------|------------|---------|--------|
| ACL_CHECK_INVALID_PARAM_WITH_REASON | ACL_ERROR_INVALID_PARAM | 自定义条件 | EH0009 | 推荐 | — |
| ACL_CHECK_INVALID_PARAM_WITH_REASON_RET | 调用者指定 | 自定义条件 | EH0009 | 推荐 | — |
| ACL_CHECK_INVALID_PARAM_WITH_REASON_DESC_RET | 调用者指定 | 自定义条件 | EH0009 | 特定场景 | — |
| ACL_CHECK_RESERVED_PARAM_REPORT_RET | 调用者指定 | 参数值（不等） | EH0009 | 推荐 | — |

**说明**：
- `ACL_CHECK_RESERVED_PARAM_REPORT_RET` 专用于预留参数校验（参数必须等于某个值，如 `flags == 0`）
- `ACL_CHECK_INVALID_PARAM_WITH_REASON_DESC_RET` 用于参数名和参数值需要手动传入（非 `#param` 字符串化）的场景

### EH0012 - 非法参数（无值）

参数非法但不需要展示参数值时使用。

| 宏名 | 返回类型 | 条件类型 | 上报 ErrMsg | 推荐等级 | 替代宏 |
|------|---------|---------|------------|---------|--------|
| ACL_CHECK_INVALID_PARAM_NO_VALUE | ACL_ERROR_INVALID_PARAM | 自定义条件（取反） | EH0012 | 推荐 | — |

---

## 5. 文件校验宏（EH0004）

文件路径无效或文件打开失败时使用。

| 宏名 | 返回类型 | 条件类型 | 上报 ErrMsg | 推荐等级 | 替代宏 |
|------|---------|---------|------------|---------|--------|
| ACL_CHECK_INVALID_FILE_MSG_RET | 调用者指定 | 自定义条件 | EH0004 | 推荐 | — |
| ACL_CHECK_FILE_OPEN_FAILED | 调用者指定 | 自定义条件（取反） | EH0004 | 推荐 | — |

**说明**：
- `ACL_CHECK_FILE_OPEN_FAILED` 自动获取 `strerror(errno)` 作为失败原因
- `ACL_CHECK_INVALID_FILE_MSG_RET` 需要手动传入 reason

---

## 6. 内存分配校验宏（EH0010）

内存分配失败时使用。

| 宏名 | 返回类型 | 条件类型 | 上报 ErrMsg | 推荐等级 | 替代宏 |
|------|---------|---------|------------|---------|--------|
| ACL_CHECK_MALLOC_RESULT_REPORT_RET | 调用者指定 | 空指针 | EH0010 | 推荐 | — |

**说明**：
- 上报 EH0010（带 buf_size），返回类型由调用者指定（可以是 nullptr 或错误码）

---

## 7. 内部错误上报宏（EH9999）

上报 EH9999 内部错误码。

### 仅上报（不改变控制流）

| 宏名 | 返回类型 | 条件类型 | 推荐等级 |
|------|---------|---------|---------|
| ACL_LOG_INNER_ERROR / ACL_LOG_CALL_ERROR | 无 | 无条件 | 推荐 |

**说明**：
- 两个宏实现完全相同（均调用 `AclErrorLogManager::ReportInnerError()` → `REPORT_INNER_ERR_MSG("EH9999", ...)`）

### 条件检查 + 上报 + 返回

| 宏名 | 返回类型 | 条件类型 | 推荐等级 |
|------|---------|---------|---------|
| ACL_CHECK_WITH_INNER_MESSAGE_AND_RETURN | 调用者指定 | 自定义条件（取反） | 推荐 |
| ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT | ACL_ERROR_INVALID_PARAM | 空指针 | 特定场景 |
| ACL_CHECK_MALLOC_RESULT | ACL_ERROR_BAD_ALLOC | 空指针 | 特定场景 |
| ACL_REQUIRES_EQ | ACL_ERROR_INVALID_PARAM | 参数值（不等） | 特定场景 |
| ACL_REQUIRES_LE | ACL_ERROR_INVALID_PARAM | 参数值（大于） | 特定场景 |

**说明**：
- `ACL_CHECK_WITH_INNER_MESSAGE_AND_RETURN`：条件取反（`if (!(exp))`），通用性最强
- `ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT`：空指针检查 + EH9999，如需上报 EH0008 请用第 3 节宏
- `ACL_CHECK_MALLOC_RESULT`：内存分配失败，固定返回 `ACL_ERROR_BAD_ALLOC`，如需上报 EH0010 请用 `ACL_CHECK_MALLOC_RESULT_REPORT_RET`

### 返回值检查 + 上报 + 透传

| 宏名 | 返回类型 | 条件类型 | 推荐等级 |
|------|---------|---------|---------|
| ACL_REQUIRES_OK_WITH_INNER_MESSAGE | 原始返回值 | 返回值!=OK | 推荐 |
| ACL_REQUIRES_CALL_RTS_OK | 原始返回值 | 返回值!=NONE | 推荐 |
| ACL_REQUIRES_CALL_GE_OK | 原始返回值 | 返回值!=ge::SUCCESS | 推荐 |
| ACL_REQUIRES_EOK | ACL_ERROR_FAILURE | 返回值!=EOK | 推荐 |

**说明**：
- `ACL_REQUIRES_CALL_RTS_OK` 对 `ACL_ERROR_RT_FEATURE_NOT_SUPPORT` 特殊处理：仅打 WARN 日志，不上报 ErrMsg；其他失败情况上报 EH9999
- `ACL_REQUIRES_EOK` 用于安全函数（memcpy_s 等），固定返回 `ACL_ERROR_FAILURE`

---

## 8. 快速选择指南

```
我要上报的错误码是否有专用的宏？
├─ 是（空指针→EH0008，参数值→EH0007/EH0009/EH0012，文件→EH0004，内存→EH0010，见第3~6节）
│   └─ 专用宏是否能满足我的场景？（根据返回类型/条件类型判断）
│       ├─ 是 → 使用专用宏
│       └─ 否 → 手动调用 AclErrorLogManager::ReportInputError()（见下方说明） 或者 开发新的宏
│
└─ 否（EH0001/EH0003/EH0006/EH0011/EH0013 等无专用宏）
    └─ 手动调用 AclErrorLogManager::ReportInputError()（见下方说明） 或者 开发新的宏
```

**用法示例**：
```cpp
acl::AclErrorLogManager::ReportInputError(acl::INVALID_PATH_MSG,
    std::vector<const char *>({"path", "reason"}),
    std::vector<const char *>({path, "file not found"}));
```


