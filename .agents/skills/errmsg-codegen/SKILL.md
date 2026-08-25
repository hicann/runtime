---
name: errmsg-codegen
description: "根据 Runtime error_code.json 中已有的错误码定义生成或更新错误码代码，包括 error_code_meta.h 中的 X-Macro 表行和 rt_error_code_test.cc 中的 UT 参数数据。当用户要求新增 EE/EH/W 类错误码、自动生成错误码代码、同步错误码元数据或补齐错误码 UT 数据时使用。"
---

# 错误码自动生成 Skill

## 触发场景

用户说「新增错误码」「自动生成错误码代码」→ 自动生成 X-Macro 表行 + UT 测试数据。

## 输入

用户提供一个错误码编号，如 `EE1021`。

### Step 1: 查找 JSON

使用 JSON 解析工具在 `src/dfx/error_manager/error_code.json` 中按 `ErrCode` 精确查找条目。仅当主配置不存在时，再检查 `src/conf/error_manager/error_code.json`。

如果找不到 → 提示用户先在 `error_code.json` 中补充该错误码定义，然后重试。

写入前检查目标错误码是否已存在于 X-Macro 表和 UT 数据中，避免生成重复条目。

### Step 2: 解析 JSON 条目

从 JSON 提取：

| JSON 字段 | 用途 | 示例 |
|-----------|------|------|
| `ErrCode` | 枚举名、字符串名 | `EE1021` |
| `ErrMessage` | 消息模板（不含 `ErrorCode=` 后缀） | `The argument is invalid.Reason: %s` |
| `Arglist` | 参数名列表（逗号分隔） | `extend_info` 或 `func,value,param,expect` |

### Step 3: 推导日志级别

- `ErrCode` 以 `W` 开头 → `DLOG_WARN`
- 其他 → `DLOG_ERROR`

### Step 4: 生成 X-Macro 表行

生成一行代码，格式：

```cpp
/* EEXXXX - ErrTitle */                                                       \
X(EEXXXX, "EEXXXX",                                                           \
  ("param1", "param2", ...),                                                  \
  "ErrMessage. ErrorCode=EEXXXX.\n",                                          \
  DLOG_ERROR)
```

**规则**：
- `Arglist` 中逗号分隔的参数名，每个用 `"param"` 包裹，整体用 `()` 包裹
- `Arglist` 为空时生成零参数形式，UT 参数个数使用 `0`
- `ErrMessage` 末尾追加 `. ErrorCode=EEXXXX.\n`
- 如果 `ErrMessage` 末尾已有句号，不加额外句号
- `ErrMessage` 中格式化占位符数量必须与 `Arglist` 参数数量一致

### Step 5: 插入表

在 `src/runtime/core/inc/common/error_code_meta.h` 的 `RUNTIME_ERROR_CODE_TABLE` 宏中，按仓库现有错误码排序规则插入到合适位置。目标错误码已存在时更新现有条目，不得重复插入。

### Step 6: 更新 UT 数据

在 `tests/ut/runtime/runtime/test/rt_error_code_test.cc` 的 `ErrorCodeTableParamCountMatchesMessageFormat` 测试的 `allCodes` 数组中按现有顺序插入或更新一行：

```cpp
{ErrorCode::EEXXXX, N},  // N = Arglist 中的参数个数
```

### Step 7: 验证

```bash
make -C build runtime_utest -j4 && ./build/tests/ut/runtime/runtime/runtime_utest --gtest_filter='*ErrorCodeTable*'
```

## 完整示例

用户输入「新增错误码 EE1021」：

**JSON 中**
```json
{
  "ErrCode": "EE1021",
  "ErrMessage": "Failed to process request. Reason: %s",
  "Arglist": "reason",
  "suggestion": { ... }
}
```

**生成代码插入 X-Macro 表**
```cpp
    /* EE1021 - Some_Error */                                                 \
    X(EE1021, "EE1021",                                                       \
      ("reason"),                                                             \
      "Failed to process request. Reason: %s. ErrorCode=EE1021.\n",           \
      DLOG_ERROR)
```

**更新 UT**
```cpp
{ErrorCode::EE1021, 1},
```
