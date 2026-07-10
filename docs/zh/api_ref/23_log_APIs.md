# 23. 日志接口

本章节描述日志接口，用于记录模块产生的日志并校验调测日志级别。

- [使用须知](#使用须知)
- [`void AlogRecord(uint32_t moduleId, uint32_t logType, int32_t level, const char *fmt, ...)`](#AlogRecord)：用于记录各模块产生的日志。
- [`int32_t AlogCheckDebugLevel(uint32_t moduleId, int32_t level)`](#AlogCheckDebugLevel)：用于校验调测日志级别。
- [`void acllogRecord(int32_t moduleId, int32_t level, const char *fmt, ...)`](#acllogRecord)：用于记录用户模块产生的日志。
- [`void acllogVaList(int32_t moduleId, int32_t level, const char *fmt, va_list list)`](#acllogVaList)：用于通过va_list记录用户模块产生的日志。
- [`int32_t acllogCheckDebugLevel(int32_t moduleId, int32_t logLevel)`](#acllogCheckDebugLevel)：用于校验用户模块调测日志级别。
- [`int32_t acllogRegisterCallback(acllogRecordCallback callbackFunc, void *userData, uint32_t outputLogType, acllogCallbackHandle *callbackHandle)`](#acllogRegisterCallback)：用于注册设备plog日志回调函数。
- [`int32_t acllogUnregisterCallback(acllogCallbackHandle callback)`](#acllogUnregisterCallback)：用于取消注册设备plog日志回调函数。
- [`数据类型定义`](#数据类型定义)：日志级别、日志类型和模块ID等数据类型定义。

<br>
<br>
<br>

<a id="使用须知"></a>

## 使用须知

该部分接口仅在定制开发CANN组件场景下使用。本文介绍这部分接口的功能、参数等，仅为了便于您了解这部分接口在CANN开放代码中的作用，进而更好地使用或修改CANN开放代码。

涉及的日志接口头文件和库文件路径：

- include的头文件所在路径：${INSTALL_DIR}/include/base/alog_pub.h，该头文件中已包含log_types.h
- 日志回调接口头文件所在路径：${INSTALL_DIR}/include/base/acl_log.h
- 依赖的库文件路径：${INSTALL_DIR}/lib64/libascendalog.so

用户自定义模块可使用`acl_log.h`中的`acllogRecord`、`acllogVaList`和`acllogCheckDebugLevel`接口记录日志。用户moduleId范围为`0xff00`~`0xffff`（65280~65535）。该范围内的moduleId会在日志中按十进制ID记录，不转换为moduleName字符串。CANN内部模块moduleId范围为`0x0000`~`0x00ff`（0~255）。

${INSTALL_DIR}请替换为CANN软件安装后文件存储路径。以root用户安装为例，安装后文件默认存储路径为：/usr/local/Ascend/cann。

<br>
<br>
<br>

<a id="AlogRecord"></a>

## AlogRecord

```c
void AlogRecord(uint32_t moduleId, uint32_t logType, int32_t level, const char *fmt, ...)
```

### 产品支持情况

| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 函数功能

>**须知：** 
>该接口将在后续版本中废弃，不建议用户使用，以防止引发兼容性问题。

用于记录各模块产生的日志。

### 参数说明

| 参数 | 输入/输出 | 说明 |
| --- | --- | --- |
| moduleId | 输入 | 模块ID，枚举值请参见[数据类型定义](#数据类型定义)。 |
| logType | 输入 | 本条日志类型，枚举值请参见[数据类型定义](#数据类型定义)。传入其他值视作调试日志。 |
| level | 输入 | 本条日志级别，宏定义请参见[数据类型定义](#数据类型定义)。<br> 说明： 运行日志不会记录debug级别日志，DLOG_TYPE_RUN和DLOG_DEBUG不可组合使用。 |
| fmt | 输入 | 待打印的内容。<br><br>  - 接口不校验内容合法性。<br>  - 单条日志最大长度为1024字节，超出则会截断。 |

### 返回值

无。

### 调用示例

```c
AlogRecord(SLOG, DLOG_TYPE_RUN, DLOG_INFO, "test run log");
```

<br>
<br>
<br>

<a id="AlogCheckDebugLevel"></a>

## AlogCheckDebugLevel

```c
int32_t AlogCheckDebugLevel(uint32_t moduleId, int32_t level)
```

### 产品支持情况

| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 函数功能

>**须知：** 
>该接口将在后续版本中废弃，不建议用户使用，以防止引发兼容性问题。

用于校验调测日志级别。

### 参数说明

| 参数 | 输入/输出 | 说明 |
| --- | --- | --- |
| moduleId | 输入 | 模块ID，枚举值请参见[数据类型定义](#数据类型定义)。 |
| level | 输入 | 日志级别，宏定义请参见[数据类型定义](#数据类型定义)。 |

### 返回值

返回调测日志级别校验结果。

1：级别校验通过

0：级别校验不通过

### 调用示例

```c
if(AlogCheckDebugLevel(SLOG, DLOG_INFO) == 1) {
    AlogRecord(SLOG, DLOG_TYPE_DEBUG, DLOG_INFO, "test debug log");
}
```

<br>
<br>
<br>

<a id="acllogRecord"></a>

## acllogRecord

```c
void acllogRecord(int32_t moduleId, int32_t level, const char *fmt, ...)
```

### 产品支持情况

| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 函数功能

用于记录用户模块产生的日志。

### 参数说明

| 参数 | 输入/输出 | 说明 |
| --- | --- | --- |
| moduleId | 输入 | 用户模块ID，取值范围为`0xff00`~`0xffff`。该范围内的ID在日志中按十进制记录，不转换为moduleName字符串。 |
| level | 输入 | 本条日志级别，宏定义请参见[数据类型定义](#数据类型定义)。 |
| fmt | 输入 | 待打印的内容。接口不校验内容合法性。单条日志最大长度为1024字节，超出则会截断。 |

### 返回值

无。

### 调用示例

```c
acllogRecord(0xff00, DLOG_INFO, "user module log");
```

<br>
<br>
<br>

<a id="acllogVaList"></a>

## acllogVaList

```c
void acllogVaList(int32_t moduleId, int32_t level, const char *fmt, va_list list)
```

### 产品支持情况

| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 函数功能

用于通过`va_list`记录用户模块产生的日志。

### 参数说明

| 参数 | 输入/输出 | 说明 |
| --- | --- | --- |
| moduleId | 输入 | 用户模块ID，取值范围为`0xff00`~`0xffff`。该范围内的ID在日志中按十进制记录，不转换为moduleName字符串。 |
| level | 输入 | 本条日志级别，宏定义请参见[数据类型定义](#数据类型定义)。 |
| fmt | 输入 | 待打印的内容。接口不校验内容合法性。单条日志最大长度为1024字节，超出则会截断。 |
| list | 输入 | 可变参数列表。 |

### 返回值

无。

### 调用示例

```c
static void LogUserModule(int32_t moduleId, int32_t level, const char *fmt, ...)
{
    va_list list;
    va_start(list, fmt);
    acllogVaList(moduleId, level, fmt, list);
    va_end(list);
}

LogUserModule(0xff00, DLOG_INFO, "user module log");
```

<br>
<br>
<br>

<a id="acllogCheckDebugLevel"></a>

## acllogCheckDebugLevel

```c
int32_t acllogCheckDebugLevel(int32_t moduleId, int32_t logLevel)
```

### 产品支持情况

| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 函数功能

用于校验用户模块调测日志级别。

### 参数说明

| 参数 | 输入/输出 | 说明 |
| --- | --- | --- |
| moduleId | 输入 | 用户模块ID，取值范围为`0xff00`~`0xffff`。 |
| logLevel | 输入 | 日志级别，宏定义请参见[数据类型定义](#数据类型定义)。 |

### 返回值

返回调测日志级别校验结果。

1：级别校验通过

0：级别校验不通过

### 调用示例

```c
if (acllogCheckDebugLevel(0xff00, DLOG_INFO) == 1) {
    acllogRecord(0xff00, DLOG_INFO, "test debug log");
}
```

<br>
<br>
<br>

<a id="acllogRegisterCallback"></a>

## acllogRegisterCallback

```c
int32_t acllogRegisterCallback(acllogRecordCallback callbackFunc, void *userData, uint32_t outputLogType, acllogCallbackHandle *callbackHandle)
```

### 产品支持情况

| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 函数功能

用于注册设备plog日志回调函数。注册成功后，设备侧上报的plog日志在原有落盘流程前触发回调。

支持注册多个回调函数，最多支持16个。回调函数的返回值会被忽略，不影响plog原有落盘流程，也不影响其他已注册回调函数执行。

>**须知：**
>该接口仅对设备plog report上报链路生效，不覆盖普通Host侧AlogRecord/DlogRecord日志。

### 参数说明

| 参数 | 输入/输出 | 说明 |
| --- | --- | --- |
| callbackFunc | 输入 | 回调函数，类型请参见[数据类型定义](#数据类型定义)。不允许传入NULL。 |
| userData | 输入 | 用户自定义数据。该数据会在触发回调时通过回调函数的userData参数传回。允许传入NULL。 |
| outputLogType | 输入 | 回调接收的日志输出类型，枚举值请参见[数据类型定义](#数据类型定义)。 |
| callbackHandle | 输出 | 注册成功后返回的回调句柄，用于取消注册。不允许传入NULL。 |

### 返回值

返回回调注册结果。

0：注册成功

-1：注册失败。失败场景包括callbackFunc为NULL、callbackHandle为NULL、outputLogType非法、已注册回调函数数量达到16个。

### 调用示例

```c
static int32_t LogCallback(void *userData, uint32_t outputLogType, const char *logContent, size_t length)
{
    (void)userData;
    (void)outputLogType;
    printf("%.*s", (int)length, logContent);
    return 0;
}

acllogCallbackHandle handle = 0;
int32_t ret = acllogRegisterCallback(LogCallback, NULL, OUTPUT_TYPE_BOTH, &handle);
```

<br>
<br>
<br>

<a id="acllogUnregisterCallback"></a>

## acllogUnregisterCallback

```c
int32_t acllogUnregisterCallback(acllogCallbackHandle callback)
```

### 产品支持情况

| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 函数功能

用于取消注册设备plog日志回调函数。取消注册成功后，对应回调函数不再被调用。

### 参数说明

| 参数 | 输入/输出 | 说明 |
| --- | --- | --- |
| callback | 输入 | 通过[acllogRegisterCallback](#acllogRegisterCallback)接口注册成功后返回的回调句柄。 |

### 返回值

返回回调取消注册结果。

0：取消注册成功

-1：取消注册失败。失败场景包括callback为无效句柄或未注册句柄。

### 调用示例

```c
int32_t ret = acllogUnregisterCallback(handle);
```

<br>
<br>
<br>

<a id="数据类型定义"></a>

## 数据类型定义

日志级别宏定义：

```c
#define DLOG_DEBUG 0x0      // debug level id
#define DLOG_INFO  0x1      // info level id
#define DLOG_WARN  0x2      // warning level id
#define DLOG_ERROR 0x3      // error level id
```

日志类型枚举：

```c
enum {
    DLOG_TYPE_DEBUG = 0,    // 调试日志
    DLOG_TYPE_RUN = 1,      // 运行日志
    DLOG_TYPE_MAX           // 无效值
};
```

日志回调输出类型枚举：

```c
typedef enum {
    OUTPUT_TYPE_DEBUG = 0,  // 调试日志
    OUTPUT_TYPE_RUN = 1,    // 运行日志
    OUTPUT_TYPE_BOTH = 2,   // 调试日志和运行日志
    OUTPUT_TYPE_MAX         // 无效值
} acllogOutputLogType;
```

日志回调句柄类型：

```c
typedef uintptr_t acllogCallbackHandle;
```

日志回调函数类型：

```c
typedef int32_t (*acllogRecordCallback)(
    void *userData, uint32_t outputLogType, const char *logContent, size_t length);
```

参数说明：

| 参数 | 说明 |
| --- | --- |
| userData | 用户注册回调函数时传入的自定义数据。 |
| outputLogType | 当前触发回调的日志输出类型，取值为OUTPUT_TYPE_DEBUG、OUTPUT_TYPE_RUN或OUTPUT_TYPE_BOTH。 |
| logContent | 日志内容。 |
| length | 日志内容长度，单位为Byte。 |

module id 枚举：

```c
enum {
    SLOG = 0,               /* Slog module */
    IDEDD = 1,              /* IDE daemon device */
    HCCL = 3,               /* HCCL */
    FMK = 4,                /* Adapter */
    DVPP = 6,               /* DVPP */
    RUNTIME = 7,            /* Runtime */
    CCE = 8,                /* CCE */
    HDC = 9,                /* HDC */
    DRV = 10,               /* Driver */
    DEVMM = 22,             /* Dlog memory management */
    KERNEL = 23,            /* Kernel */
    LIBMEDIA = 24,          /* Libmedia */
    CCECPU = 25,            /* aicpu schedule */
    ROS = 27,               /* ROS */
    HCCP = 28,
    ROCE = 29,
    TEFUSION = 30,
    PROFILING =31,
    DP = 32,                /* Data Preprocess */
    APP = 33,               /* User Application */
    TS = 34,                /* Task Schedule */
    TSDUMP = 35,
    AICPU = 36,
    LP = 37,                /* Low Power */
    TDT = 38,               /* tsdaemon or aicpu schedule */
    FE = 39,
    MD = 40,
    MB = 41,
    ME = 42,
    IMU = 43,
    IMP = 44,
    GE = 45,                /* Fmk */
    CAMERA = 47,
    ASCENDCL = 48,
    TEEOS = 49,
    ISP = 50,
    SIS = 51,
    HSM = 52,
    DSS = 53,
    PROCMGR = 54,           /* Process Manager, Base Platform */
    BBOX = 55,
    AIVECTOR = 56,
    TBE = 57,
    FV = 58,
    TUNE = 60,
    HSS = 61,               /* helper */
    FFTS = 62,
    OP = 63,
    UDF = 64,
    HICAID = 65,
    TSYNC = 66,
    AUDIO = 67,
    TPRT = 68,
    ASCENDCKERNEL = 69,
    ASYS = 70,
    ATRACE = 71,
    RTC = 72,
    SYSMONITOR = 73,
    AML = 74,
    ADETECT = 75,
    INVLID_MOUDLE_ID = 76   /* add new module before INVLID_MOUDLE_ID */ 
};
```
