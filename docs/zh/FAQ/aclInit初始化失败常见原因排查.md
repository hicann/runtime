# aclInit初始化失败常见原因排查

## 问题现象描述

**现象1：调用aclInit接口返回参数错误码**

调用 aclInit 接口时返回 ACL_ERROR_RT_PARAM_INVALID（错误码 107000），表示参数无效。

报错日志示例如下：
```
aclInit failed, ret = 107000
```

**现象2：调用aclInit接口返回重复初始化错误码**

调用 aclInit 接口时返回 ACL_ERROR_REPEAT_INITIALIZE（错误码 100002），表示重复初始化错误。

报错日志示例如下：
```
aclInit failed, ret = 100002, repeat initialize
```

**现象3：配置文件解析失败**

aclInit 接口传入的配置文件路径错误或格式不正确，导致解析失败。

报错日志示例如下：
```
Failed to parse config file: /path/to/acl.json
```

## 可能原因

1. **配置文件路径不存在或权限不足**：aclInit 接口传入的配置文件路径错误，或文件不可读。
2. **json 配置格式错误**：配置文件括号层级超限（最多10层）、字段拼写错误、格式不符合 json 规范。
3. **多次 aclInit 调用配置不一致**：重复调用 aclInit 时，配置必须保持一致，否则后续调用可能报错或配置无效。

## 处理步骤

### 原因1：配置文件路径不存在或权限不足

**解决方法**：
- 使用绝对路径：传入完整的文件路径，例如 `/home/user/acl.json`
- 检查文件权限：确保文件可读，使用 `ls -l /path/to/acl.json` 查看权限
- 如果默认配置满足需求：传入 nullptr 或配置空 json 串 `{}`

示例代码：
```c
// 使用绝对路径
aclError ret = aclInit("/home/user/config/acl.json");

// 使用默认配置（传入 nullptr）
aclError ret = aclInit(nullptr);

// 使用空配置（传入空 json）
// acl.json 内容：{}
aclError ret = aclInit("../acl.json");
```

### 原因2：json 配置格式错误

**解决方法**：
- 检查括号层级：json 文件内 `{` 层级最多10层，`[` 层级最多10层
- 验证字段拼写：参考 API 文档中的配置示例
- 使用 json 验证工具：在线 json 验证器检查格式正确性

典型配置示例：
```json
{
    "defaultDevice":{
        "default_device":"0"
    }
}
```

### 原因3：多次 aclInit 调用配置不一致

**解决方法**：
- 保持配置一致：每次调用 aclInit 时使用相同的配置文件路径和内容
- 忽略重复初始化错误：aclInit 重复调用会返回 ACL_ERROR_REPEAT_INITIALIZE，可忽略该错误继续业务处理
- 成对调用初始化和去初始化：支持重复初始化和去初始化，时序为 `aclInit → 业务处理 → aclFinalize → aclInit → 业务处理 → aclFinalize`

示例代码：
```c
// 正确的重复初始化方式
aclError ret1 = aclInit(nullptr);  // 首次初始化
// ... 业务处理 ...
aclError ret2 = aclFinalize();     // 去初始化

aclError ret3 = aclInit(nullptr);  // 再次初始化（配置一致）
// ... 业务处理 ...
aclError ret4 = aclFinalize();     // 再次去初始化
```

## 相关 issue

暂无相关Issue。