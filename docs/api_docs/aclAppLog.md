# aclAppLog

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

将日志记录到日志文件中。

acl接口还提供了ACL\_APP\_LOG宏，封装aclAppLog接口，推荐用户调用ACL\_APP\_LOG宏，传入日志级别、日志描述、fmt中的可变参数。日志文件的详细说明，请参见《日志参考》。

```
#define ACL_APP_LOG(level, fmt, ...) \
    aclAppLog(level, __FUNCTION__, __FILE__, __LINE__, fmt, ##__VA_ARGS__)
```

## 函数原型

```
void aclAppLog(aclLogLevel logLevel, const char *func, const char *file, uint32_t line, const char *fmt, ...)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| logLevel | 输入 | 日志级别。<br>typedef enum {<br>   ACL_DEBUG = 0,<br>   ACL_INFO = 1,<br>   ACL_WARNING = 2,<br>   ACL_ERROR = 3,<br>} aclLogLevel; |
| func | 输入 | 表示用户在哪个接口中调用aclAppLog接口，固定配置为__FUNCTION__ |
| file | 输入 | 表示用户在哪个文件中调用aclAppLog接口，固定配置为__FILE__ |
| line | 输入 | 表示用户在哪一行中调用aclAppLog接口，固定配置为__LINE__ |
| fmt | 输入 | 日志描述。<br>在调用格式化函数时，fmt中参数的类型、个数必须与实际参数类型、个数保持一致。 |
| ... | 输入 | fmt中的可变参数，根据日志内容添加。 |

## 返回值说明

无

## 调用示例

```
//若fmt中存在可变参数，需提前定义
uint32_t modelId = 1;
ACL_APP_LOG(ACL_INFO, "load model success, modelId is %u", modelId);
```

