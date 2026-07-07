# Error Message 整改原则

本文档沉淀 Runtime/ACL Error Message 整改的整体原则，用于判断整改边界、用户错误与内部错误、参数来源、第一现场、防御性编程、重复结构化上报和打印格式等通用问题。错误码、宏选择和文案模板分别参考同目录下的专题规范。

## 核心原则

Error Message 整改的目标是提升用户可读性和问题定位效率：

- 用户错误指导用户自闭环，信息中应说明参数、实际值、期望值或明确原因。
- 内部错误精确定位内部失败点，信息中应说明函数、对象、返回码或关键上下文。
- 分析调用点时必须阅读上下文，理解错误发生的业务场景和触发原因，不能机械套用规则。
- 错误分类的核心判断依据是错误触发源和用户是否需要、是否能够理解并处理该错误。

## 整改边界

整改只处理结构化错误上报及其必要的宏/错误码/文案匹配，不改变业务行为。

允许整改：

- Runtime 中 `RT_LOG_OUTER_MSG_IMPL`、`RT_LOG_INNER_MSG` 及其封装链路的错误信息。
- Runtime 中直接使用 `REPORT_INPUT_ERROR`、`REPORT_INNER_ERROR` 的错误信息。
- ACL 中 `ReportInputError`、`ReportInnerError`、`ACL_LOG_INNER_ERROR` 的错误信息。
- 错误码选择和宏使用明显不合理的结构化错误上报点。

禁止事项：

- 不修改返回值，例如 `RT_ERROR_INVALID_PARAM`、`ACL_ERROR_INVALID_PARAM` 等保持原样。
- 不修改条件判断、流程控制和清理逻辑。
- 不修改普通日志级别，例如 `ERROR` 不改为 `WARN`、`DEBUG`。
- 不把普通日志机械改成结构化上报。
- 不因文案整改替换封装宏为底层宏；封装宏正确时优先只改宏参数或文案。

通常不整改：

- Runtime 的 `RT_LOG_ERROR`、`RT_LOG_DEBUG`、`RT_LOG_INFO`、`RT_LOG_WARNING` 等普通日志。
- ACL 的 `ACL_LOG_ERROR`、`ACL_LOG_DEBUG`、`ACL_LOG_INFO`、`ACL_LOG_WARN` 等普通日志。
- 防御性编程中仅用于内部诊断的日志。

## 用户错误与内部错误

用户错误与内部错误的核心判断问题是：用户能否通过修改参数、环境或调用方式自闭环。

用户错误：

- 错误由用户传入参数、用户配置、用户调用顺序或用户可控资源请求触发。
- 用户能够根据文档或错误信息调整自己的行为解决问题。
- 典型场景包括参数非法、空指针参数、路径非法、特性不支持、系统或设备不支持、API 调用序列错误、资源不足等。
- Runtime 使用用户类 EE 错误码并通过用户错误宏/接口上报；ACL 使用 EH 错误码并通过 `ReportInputError` 上报。

内部错误：

- 错误由 Runtime/ACL 内部状态、内部变量或内部逻辑异常触发。
- 用户无法通过修改 API 参数或调用方式直接解决，通常需要技术支持或内部定位。
- 典型场景包括内部状态异常、内部 buffer 操作失败、预期不应发生的防御性场景等。
- Runtime 内部错误主要使用 `EE9999` 或仅普通日志。

快速判断：

1. 错误参数是否来自用户传入或用户配置。
2. 用户能否通过修改自己的参数、环境或调用方式解决。
3. 错误信息能否指导用户自行闭环。

任一问题答案为“是”，通常按用户错误处理；如果全部为“否”，按内部错误处理。

示例：

```cpp
// 用户错误：priority 来自对外接口入参，用户可修改调用参数自闭环。
COND_RETURN_AND_MSG_OUTER_WITH_PARAM(priority > 2, RT_ERROR_INVALID_PARAM,
    priority, "[0, 2]");

// 内部错误：internalState 是 Runtime 内部状态，用户无法通过修改 API 参数直接解决。
COND_RETURN_AND_MSG_INNER(internalState == nullptr, RT_ERROR_INTERNAL_ERROR,
    "Internal error in %s: state is null", __func__);
```

## 参数来源判断

参数来源比函数名更重要。同一个系统调用失败，可能因为参数来源不同而归类不同。

- 公开 API 头文件中的接口参数视为用户参数。
- ACL Impl 层由公开 API 直接转发而来的形参视为用户参数。
- Impl 或 Runtime 内部私有函数的形参需要追溯调用链：来自公开接口参数则按用户参数，来自内部变量则按内部参数。
- 函数内部定义的临时变量、成员变量、内部状态对象通常按内部参数或内部状态处理。
- 系统调用或安全函数同时涉及用户参数和内部参数时，只要失败可由用户参数触发，通常按用户错误处理。

不要只依据 `memcpy_s`、`malloc`、驱动接口等函数名判断错误类别，应结合参数来源、调用层级和用户可控性判断。

## 第一现场原则

第一现场是错误发生的最初位置，即直接错误源。

第一现场通常具备以下特征：

- 直接调用失败或异常条件首次成立的位置。
- 错误不是简单从下层函数返回。
- 当前上下文最清楚失败对象、参数、返回码和原因。

处理原则：

- 例外：aclrt/rt 对外接口函数返回错误码的路径上，入口函数作为用户可见的错误上报边界，不适用第一现场原则和重复结构化上报去重原则。即使下层已经对同一错误上报 ErrMsg，入口函数仍需要再次上报 ErrMsg，以保证对外接口存在接口级错误信息。
- 除上述例外场景外，错误源头应打印足够定位的日志；返回错误码时原则上应同时上报 ErrMsg。
- 如果当前函数只是接收下层返回的错误码，且下层已经上报同一错误，当前函数只需返回错误码并按需打印普通日志。
- 多层调用链中，同一错误只在最合适的第一现场进行结构化上报。
- 上报内部错误的源头也需要保留可定位上下文，避免只在外层打印泛化失败信息。

示例：

```cpp
// 第一现场：malloc 直接失败，当前上下文最清楚 size 和返回结果。
void *ptr = malloc(size);
if (ptr == nullptr) {
    RT_LOG_ERROR("Failed to allocate %zu bytes memory.", size);
    COND_PROC_RETURN_AND_MSG_ALLOC_FAILED(ptr == nullptr, RT_ERROR_MEMORY_ALLOCATION,
        (void)0, std::to_string(size));
}

// 非第一现场：错误从下层返回，且下层已经上报同一错误。
rtError_t ret = AllocateMemory(size, &ptr);
if (ret != RT_SUCCESS) {
    RT_LOG_ERROR("AllocateMemory failed with error %d.", ret);
    return ret;
}
```

## 防御性编程

防御性编程是理论上不应出现的异常场景，通常上层已经校验，或内部约定保证条件不会成立。

判断依据：

- 上游函数已经校验并拦截该错误。
- 内部模块间约定保证参数或状态有效。
- 代码逻辑保证该条件理论上不会成立。
- 检查条件更接近内部断言或兜底保护。

处理原则：

- 防御性编程场景只打印普通日志，不上报结构化错误。
- 不把防御性检查包装成用户错误。
- 如果防御性检查实际位于用户可见入口，或用户输入可直接触发，则不按防御性场景处理，应按用户错误上报。

示例：

```cpp
// 上层函数已校验并保证 stream != nullptr。
rtError_t ProcessStreamInternal(rtStream_t stream) {
    if (stream == nullptr) {
        // 防御性编程：理论上不应出现，仅保留普通日志。
        RT_LOG_ERROR("Unexpected null stream in internal function %s.", __func__);
        return RT_ERROR_INTERNAL_ERROR;
    }
    // ... 业务逻辑
    return RT_SUCCESS;
}

// 对外入口：用户传入 nullptr 可直接触发，需要上报 ErrMsg。
rtError_t rtProcessStream(rtStream_t stream) {
    NULL_PTR_RETURN_MSG_OUTER(stream, RT_ERROR_INVALID_PARAM);
    return ProcessStreamInternal(stream);
}
```

## 重复结构化上报

除 aclrt/rt 对外接口入口例外外，同一个错误不应在调用链中多次结构化上报。

检查方法：

1. 定位当前结构化上报点。
2. 追溯当前函数的上层调用和下层返回路径。
3. 确认同一错误是否已在更接近源头的位置上报。
4. 除 aclrt/rt 对外接口入口例外外，如果已经上报，当前调用点仅返回错误码并按需打印普通日志。

判断原则：

- aclrt/rt 对外接口入口例外按“第一现场原则”章节的例外条款处理。
- 上层已对同一错误上报时，当前函数不重复上报。
- 下层已对同一错误上报时，上层不重复包装为新的结构化错误。
- 不同错误源或不同失败分支应分别保证有 ErrMsg；对下层已上报的路径不重复上报，对遗漏上报的路径可在上层补充上报。
- 当前函数直接产生错误且下层未上报时，当前函数作为第一现场上报。
- 驱动接口或底层模块已完成内部处理时，例如驱动内存相关错误按既有 `DRV_MALLOC_ERROR_PROCESS` 或`DRV_ERROR_PROCESS`等专用处理方式执行时，外部调用侧避免重复结构化上报。

示例：

```cpp
// 第一现场：底层函数直接发现 malloc 失败并上报。
rtError_t AllocateMemoryInternal(size_t size, void **ptr) {
    *ptr = malloc(size);
    if (*ptr == nullptr) {
        COND_PROC_RETURN_AND_MSG_ALLOC_FAILED(*ptr == nullptr, RT_ERROR_MEMORY_ALLOCATION,
            (void)0, std::to_string(size));
    }
    return RT_SUCCESS;
}

// 中间层：下层已上报同一错误时，不重复结构化上报。
rtError_t CreateBufferInternal(size_t size, Buffer *buf) {
    void *ptr = nullptr;
    rtError_t ret = AllocateMemoryInternal(size, &ptr);
    if (ret != RT_SUCCESS) {
        RT_LOG_ERROR("Failed to allocate memory for buffer in %s.", __func__);
        return ret;
    }
    // ... 业务逻辑
    return RT_SUCCESS;
}

// 对外入口例外：入口函数是用户可见上报边界，即使下层已上报也需要再次上报接口级 ErrMsg。
rtError_t rtCreateBuffer(size_t size, rtBuffer_t *buffer) {
    Buffer buf;
    rtError_t ret = CreateBufferInternal(size, &buf);
    if (ret != RT_SUCCESS) {
        RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1013, std::to_string(size));
        return ret;
    }
    // ... 业务逻辑
    return RT_SUCCESS;
}
```

## 打印格式规范

Error Message 打印格式应遵循以下规范，确保信息清晰、规范、易于用户理解。

### 枚举值打印规范

**规则1：用户传入枚举值的打印**

用户传入的枚举参数，使用枚举转字符串函数打印，格式为 `枚举名(数值)`：
- 合法值示例：`GLOBAL(0)`、`THREAD_LOCAL(1)`、`RELAXED(2)`
- 非法值（不在枚举定义中）示例：`UNKNOWN(100)`，必须同时打印数值

**规则2：期望值（合法取值范围）的描述**

| 期望值类型 | 描述方式 | 示例 |
|-----------|---------|------|
| 连续区间 `[a, b)` 或 `[a, b]` | 保留原始区间描述 | `[0, 10]` |
| 离散枚举值（1个或多个具体枚举值） | 用 `枚举名(数值)` 格式，与规则1保持一致 | `RELAXED(2)` 或 `GLOBAL(0) THREAD_LOCAL(1)` |

**规则3：芯片类型（chipType）的打印**

芯片类型（chipType）属于内部枚举，不适用规则1的枚举转字符串格式，仅保留数值打印，不打印枚举名描述。

```cpp
// src/runtime/api/api_c_standard_soc.cc:593
COND_RETURN_EXT_ERRCODE_AND_MSG_OUTER((priority != RT_STREAM_GREATEST_PRIORITY) &&
    (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_STREAM_CREATE_PRIORITY_GREATEST)),
    RT_ERROR_INVALID_VALUE, ErrorCode::EE1011, __func__, StreamPriorityToString(priority).c_str(), "priority",
    "The priority can be set to RT_STREAM_GREATEST_PRIORITY only when chipType is " + std::to_string(CHIP_DC) +
    ". The actual chipType is " + std::to_string(chipType));
```

### 参数名打印规范

用户入参需打印参数名和参数值或地址，确保用户能准确定位问题参数。

### 专有名词打印规范

专有名词需使用正确的大小写和格式，保持原文不拆分、统一格式。

常见专有名词：
- AI CPU
- ACL Graph
- SQ/CQ
- IPC Notify

### ID 类参数打印规范

`stream id`、`model id` 等标识符打印格式：
- `stream (stream_id=%d)`
- `model (model_id=%d)`

### 内部函数名打印规范

内部函数名按照功能描述打印，避免直接打印函数名，以便用户理解。

示例：
- 推荐：`Failed to allocate memory for internal buffer.`
- 不推荐：`Malloc failed.`

### EE9999/EH9999 句式规范

内部错误（EE9999/EH9999）建议使用 `Failed to` 句式，清晰描述失败的操作。

示例：`Failed to allocate memory for internal buffer.`

### 句式完整性规范

使用一句完整的句式表达报错信息：
- 首字母大写
- 根据错误码类型决定句式末尾是否加句号

### 错误信息 Reason 描述规范

ErrMessage 中的 `Reason: %s` 部分用于补充说明错误发生的具体原因，应遵循以下规范：

- Reason 应简洁描述失败的具体原因，避免重复 ErrMessage 已表达的信息
- 不仅说明问题原因，还应给出用户可执行的解决措施
- Reason 内容应与上下文一致，帮助用户理解失败根因
