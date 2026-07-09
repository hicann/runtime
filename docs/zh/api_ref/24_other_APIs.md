# 24. 其他接口

本章节描述 CANN Runtime 的其他辅助接口，包括版本查询、数据类型转换、平台硬件信息查询等。

- [`void aclAppLog(aclLogLevel logLevel, const char *func, const char *file, uint32_t line, const char *fmt, ...)`](#aclapplog)：将日志记录到日志文件中。
- [`size_t aclDataTypeSize(aclDataType dataType)`](#aclDataTypeSize)：获取aclDataType数据的大小，单位Byte。
- [`float aclFloat16ToFloat(aclFloat16 value)`](#aclFloat16ToFloat)：将[aclFloat16](25-05_Typedefs.md#aclFloat16)类型的数据转换为float（指float32）类型的数据。
- [`aclFloat16 aclFloatToFloat16(float value)`](#aclFloatToFloat16)：将float（指float32）类型的数据转换为[aclFloat16](25-05_Typedefs.md#aclFloat16)类型的数据。
- [`aclError aclrtGetVersion(int32_t *majorVersion, int32_t *minorVersion, int32_t *patchVersion)`](#aclrtGetVersion)：查询接口版本号，acl接口版本号命名采用：A.B.C模式，其中，A表示有不兼容修改，B表示新增接口，C表示bug修复。（废弃接口，请使用aclSysGetVersion接口）
- [`aclError aclsysGetCANNVersion(aclCANNPackageName name, aclCANNPackageVersion *version)`](#aclsysGetCANNVersion)：查询CANN软件包版本号。
- [`aclError aclGetCannAttributeList(const aclCannAttr **cannAttrList, size_t *num)`](#aclGetCannAttributeList)：查询运行环境中CANN软件和对应AI处理器支持的特性列表。
- [`aclError aclGetCannAttribute(aclCannAttr cannAttr, int32_t *value)`](#aclGetCannAttribute)：查询运行环境是否支持指定的CANN特性。
- [`aclError aclGetDeviceCapability(uint32_t deviceId, aclDeviceInfo deviceInfo, int64_t *value)`](#aclGetDeviceCapability)：查询运行环境中对应Device的硬件规格大小。
- [`aclError aclrtCacheLastTaskOpInfo(const void * const infoPtr, const size_t infoSize)`](#aclrtCacheLastTaskOpInfo)：基于捕获方式构建模型运行实例场景下，把指定内存中的算子信息按照infoSize大小缓存到当前线程中最后下发的任务上。
- [`aclError aclrtCacheLastTaskExtendInfo(const char* const extendInfoPtr, const size_t infoSize)`](#aclrtCacheLastTaskExtendInfo)：将指定内存中的自定义扩展信息按照infoSize大小缓存到当前线程中最后下发的任务上。
- [`aclError aclrtProfTrace(void *userdata, int32_t length, aclrtStream stream)`](#aclrtProfTrace)：支持用户在网络指定位置下发自定义的Profiling打点。异步接口。
- [`aclError aclsysGetVersionNum(char *pkgName, int32_t *versionNum)`](#aclsysGetVersionNum)：根据软件包名称查询版本号，版本号是数值类型，通过计算各包安装目录下version.info文件中的version字段的主、次、补丁等版本信息的权重得出。
- [`aclError aclsysGetVersionStr(char *pkgName, char *versionStr)`](#aclsysGetVersionStr)：根据软件包名称查询版本号，版本号是字符串类型，与各包安装目录下version.info文件中的version保持一致。
- [`aclError aclplatformGetDeviceInfo(aclplatformDevInfo infoType, char *value, uint32_t maxLen)`](#aclplatformGetDeviceInfo)：查询对应AI处理器型号的硬件信息。
- [`aclError aclplatformGetInstructionInfo(aclplatformCoreType type, const char *instruction, char *value, uint32_t maxLen)`](#aclplatformGetInstructionInfo)：根据核类型查询指定指令的相关属性信息。
- [`aclError aclrtCreateStreamV2(aclrtStream *stream, const aclrtStreamConfigHandle *handle)`](#aclrtCreateStreamV2)：创建Stream，支持创建Stream时增加Stream配置。
- [`aclError aclrtSetStreamConfigOpt(aclrtStreamConfigHandle *handle, aclrtStreamConfigAttr attr, const void *attrValue, size_t valueSize)`](#aclrtSetStreamConfigOpt)：设置Stream配置对象中的各属性的取值。
- [`aclError aclrtSubscribeHostFunc(uint64_t hostFuncThreadId, aclrtStream exeStream)`](#aclrtSubscribeHostFunc)：调用本接口注册处理Stream上回调函数的线程（线程需由用户自行创建）。
- [`aclError aclrtProcessHostFunc(int32_t timeout)`](#aclrtProcessHostFunc)：等待指定时间后，触发回调处理，由[aclrtSubscribeHostFunc](#aclrtSubscribeHostFunc)接口指定的线程处理回调。
- [`aclError aclrtUnSubscribeHostFunc(uint64_t hostFuncThreadId, aclrtStream exeStream)`](#aclrtUnSubscribeHostFunc)：与[aclrtSubscribeHostFunc](#aclrtSubscribeHostFunc)接口配合使用，调用模型执行接口后，调用本接口取消线程注册，Stream上的回调函数不再由指定线程处理。

## aclAppLog

### 产品支持情况

<!-- npu="950" id1730 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1730 -->
<!-- npu="A3" id1731 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1731 -->
<!-- npu="910b" id1732 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1732 -->
<!-- npu="310b" id1733 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1733 -->
<!-- npu="310p" id1734 -->
- Atlas 推理系列产品：支持
<!-- end id1734 -->
<!-- npu="910" id1735 -->
- Atlas 训练系列产品：支持
<!-- end id1735 -->
<!-- npu="IPV350" id1736 -->
- IPV350：不支持
<!-- end id1736 -->
<!-- @ref: runtime/res/docs/zh/api_ref/24_other_APIs_res.md#id1 -->

### 功能说明

将日志记录到日志文件中。

acl接口还提供了ACL\_APP\_LOG宏，封装aclAppLog接口，推荐用户调用ACL\_APP\_LOG宏，传入日志级别、日志描述、fmt中的可变参数。

```c
#define ACL_APP_LOG(level, fmt, ...) \
    aclAppLog(level, __FUNCTION__, __FILE__, __LINE__, fmt, ##__VA_ARGS__)
```

### 函数原型

```c
void aclAppLog(aclLogLevel logLevel, const char *func, const char *file, uint32_t line, const char *fmt, ...)
```

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| logLevel | 输入 | 日志级别。<br>typedef enum {<br>   ACL_DEBUG = 0,<br>   ACL_INFO = 1,<br>   ACL_WARNING = 2,<br>   ACL_ERROR = 3,<br>} aclLogLevel; |
| func | 输入 | 表示用户在哪个接口中调用aclAppLog接口，固定配置为__FUNCTION__ |
| file | 输入 | 表示用户在哪个文件中调用aclAppLog接口，固定配置为__FILE__ |
| line | 输入 | 表示用户在哪一行中调用aclAppLog接口，固定配置为__LINE__ |
| fmt | 输入 | 日志描述。<br>在调用格式化函数时，fmt中参数的类型、个数必须与实际参数类型、个数保持一致。 |
| ... | 输入 | fmt中的可变参数，根据日志内容添加。<br>单条日志最大长度为1024字节，超过则会截断。 |

### 返回值说明

无

### 调用示例

```c
// 若fmt中存在可变参数，需提前定义
uint32_t modelId = 1;
ACL_APP_LOG(ACL_INFO, "load model success, modelId is %u", modelId);
```

<br>
<br>
<br>

<a id="aclDataTypeSize"></a>

## aclDataTypeSize

```c
size_t aclDataTypeSize(aclDataType dataType)
```

### 产品支持情况

<!-- npu="950" id239 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id239 -->
<!-- npu="A3" id240 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id240 -->
<!-- npu="910b" id241 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id241 -->
<!-- npu="310b" id242 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id242 -->
<!-- npu="310p" id243 -->
- Atlas 推理系列产品：支持
<!-- end id243 -->
<!-- npu="910" id244 -->
- Atlas 训练系列产品：支持
<!-- end id244 -->
<!-- npu="IPV350" id245 -->
- IPV350：不支持
<!-- end id245 -->
<!-- @ref: runtime/res/docs/zh/api_ref/24_other_APIs_res.md#id2 -->

### 功能说明

获取aclDataType数据的大小，单位Byte。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| dataType | 输入 | 指定要获取大小的aclDataType数据。类型定义请参见[aclDataType](25-02_Enumerations.md#aclDataType)。 |

### 返回值说明

返回aclDataType数据的大小，单位Byte。

<br>
<br>
<br>

<a id="aclFloat16ToFloat"></a>

## aclFloat16ToFloat

```c
float aclFloat16ToFloat(aclFloat16 value)
```

### 产品支持情况

<!-- npu="950" id2507 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2507 -->
<!-- npu="A3" id2508 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2508 -->
<!-- npu="910b" id2509 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2509 -->
<!-- npu="310b" id2510 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2510 -->
<!-- npu="310p" id2511 -->
- Atlas 推理系列产品：支持
<!-- end id2511 -->
<!-- npu="910" id2512 -->
- Atlas 训练系列产品：支持
<!-- end id2512 -->
<!-- npu="IPV350" id2513 -->
- IPV350：不支持
<!-- end id2513 -->
<!-- @ref: runtime/res/docs/zh/api_ref/24_other_APIs_res.md#id3 -->

### 功能说明

将[aclFloat16](25-05_Typedefs.md#aclFloat16)类型的数据转换为float（指float32）类型的数据。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| value | 输入 | 待转换的数据。类型定义请参见[aclFloat16](25-05_Typedefs.md#aclFloat16)。 |

### 返回值说明

转换后的数据。

<br>
<br>
<br>

<a id="aclFloatToFloat16"></a>

## aclFloatToFloat16

```c
aclFloat16 aclFloatToFloat16(float value)
```

### 产品支持情况

<!-- npu="950" id3102 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3102 -->
<!-- npu="A3" id3103 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3103 -->
<!-- npu="910b" id3104 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3104 -->
<!-- npu="310b" id3105 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id3105 -->
<!-- npu="310p" id3106 -->
- Atlas 推理系列产品：支持
<!-- end id3106 -->
<!-- npu="910" id3107 -->
- Atlas 训练系列产品：支持
<!-- end id3107 -->
<!-- npu="IPV350" id3108 -->
- IPV350：不支持
<!-- end id3108 -->
<!-- @ref: runtime/res/docs/zh/api_ref/24_other_APIs_res.md#id4 -->

### 功能说明

将float（指float32）类型的数据转换为[aclFloat16](25-05_Typedefs.md#aclFloat16)类型的数据。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| value | 输入 | 待转换的数据。 |

### 返回值说明

转换后的数据。

**注意**，由于C语言无float16类型，此处返回值使用uint16\_t对数据进行存储。若用户需要打印，需自行将uint16\_t解释成float16进行打印，或者转成float进行打印。

<br>
<br>
<br>

<a id="aclrtGetVersion"></a>

## aclrtGetVersion（废弃）

```c
aclError aclrtGetVersion(int32_t *majorVersion, int32_t *minorVersion, int32_t *patchVersion)
```

**须知：此接口后续版本会废弃，请使用aclSysGetVersion接口。**

### 产品支持情况

<!-- npu="950" id477 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id477 -->
<!-- npu="A3" id478 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id478 -->
<!-- npu="910b" id479 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id479 -->
<!-- npu="310b" id480 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id480 -->
<!-- npu="310p" id481 -->
- Atlas 推理系列产品：支持
<!-- end id481 -->
<!-- npu="910" id482 -->
- Atlas 训练系列产品：支持
<!-- end id482 -->
<!-- npu="IPV350" id483 -->
- IPV350：支持
<!-- end id483 -->
<!-- @ref: runtime/res/docs/zh/api_ref/24_other_APIs_res.md#id5 -->

### 功能说明

查询接口版本号，acl接口版本号命名采用：A.B.C模式，其中，A表示有不兼容修改，B表示新增接口，C表示bug修复。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| majorVersion | 输出 | 主版本号的指针，从1开始，如果出现接口的不兼容变更时，加1。 |
| minorVersion | 输出 | 次版本号的指针，从0开始，按照迭代周期，有新增接口时加1。 |
| patchVersion | 输出 | 补丁版本号的指针，从0开始，表示本版本仅解决了问题。<br>在majorVersion、minorVersion不变的情况下加1；但majorVersion、minorVersion增加的时候，patchVersion一般为0。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclsysGetCANNVersion"></a>

## aclsysGetCANNVersion（废弃）

```c
aclError aclsysGetCANNVersion(aclCANNPackageName name, aclCANNPackageVersion *version)
```

**须知：此接口后续版本会废弃，请使用[aclsysGetVersionStr](#aclsysGetVersionStr)、[aclsysGetVersionNum](#aclsysGetVersionNum)接口。**

### 产品支持情况

<!-- npu="950" id3179 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3179 -->
<!-- npu="A3" id3180 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3180 -->
<!-- npu="910b" id3181 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3181 -->
<!-- npu="310b" id3182 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id3182 -->
<!-- npu="310p" id3183 -->
- Atlas 推理系列产品：支持
<!-- end id3183 -->
<!-- npu="910" id3184 -->
- Atlas 训练系列产品：支持
<!-- end id3184 -->
<!-- npu="IPV350" id3185 -->
- IPV350：支持
<!-- end id3185 -->
<!-- @ref: runtime/res/docs/zh/api_ref/24_other_APIs_res.md#id6 -->

### 功能说明

查询CANN软件包版本号。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| name | 输入 | 指定要查询的软件包。类型定义请参见[aclCANNPackageName](25-02_Enumerations.md#aclCANNPackageName)。<br>若指定要查询的软件包没有安装，则本接口返回报错。 |
| version | 输出 | CANN软件包版本号。类型定义请参见[aclCANNPackageVersion](25-04_Structs.md#aclCANNPackageVersion)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclGetCannAttributeList"></a>

## aclGetCannAttributeList

```c
aclError aclGetCannAttributeList(const aclCannAttr **cannAttrList, size_t *num)
```

### 产品支持情况

<!-- npu="950" id141 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id141 -->
<!-- npu="A3" id142 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id142 -->
<!-- npu="910b" id143 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id143 -->
<!-- npu="310b" id144 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id144 -->
<!-- npu="310p" id145 -->
- Atlas 推理系列产品：支持
<!-- end id145 -->
<!-- npu="910" id146 -->
- Atlas 训练系列产品：支持
<!-- end id146 -->
<!-- npu="IPV350" id147 -->
- IPV350：支持
<!-- end id147 -->
<!-- @ref: runtime/res/docs/zh/api_ref/24_other_APIs_res.md#id7 -->

### 功能说明

查询运行环境中CANN软件和对应AI处理器支持的特性列表。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| cannAttrList | 输出 | 用于保存运行环境支持的特性枚举数组。类型定义请参见[aclCannAttr](25-02_Enumerations.md#aclCannAttr)。<br>用户无需提前申请内存，应用进程退出时，内存自动释放。 |
| num | 输出 | 用于保存支持的特性数量，与cannAttrList数组长度保持一致。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclGetCannAttribute"></a>

## aclGetCannAttribute

```c
aclError aclGetCannAttribute(aclCannAttr cannAttr, int32_t *value)
```

### 产品支持情况

<!-- npu="950" id1149 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1149 -->
<!-- npu="A3" id1150 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1150 -->
<!-- npu="910b" id1151 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1151 -->
<!-- npu="310b" id1152 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1152 -->
<!-- npu="310p" id1153 -->
- Atlas 推理系列产品：支持
<!-- end id1153 -->
<!-- npu="910" id1154 -->
- Atlas 训练系列产品：支持
<!-- end id1154 -->
<!-- npu="IPV350" id1155 -->
- IPV350：支持
<!-- end id1155 -->
<!-- @ref: runtime/res/docs/zh/api_ref/24_other_APIs_res.md#id8 -->

### 功能说明

查询运行环境是否支持指定的CANN特性。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| cannAttr | 输入 | 特性列表枚举值，一次查询可指定其中一项。类型定义请参见[aclCannAttr](25-02_Enumerations.md#aclCannAttr)。 |
| value | 输出 | 是否支持：<br><br>  - 1：支持<br>  - 0：不支持 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclGetDeviceCapability"></a>

## aclGetDeviceCapability

```c
aclError aclGetDeviceCapability(uint32_t deviceId, aclDeviceInfo deviceInfo, int64_t *value)
```

### 产品支持情况

<!-- npu="950" id1373 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1373 -->
<!-- npu="A3" id1374 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1374 -->
<!-- npu="910b" id1375 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1375 -->
<!-- npu="310b" id1376 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1376 -->
<!-- npu="310p" id1377 -->
- Atlas 推理系列产品：支持
<!-- end id1377 -->
<!-- npu="910" id1378 -->
- Atlas 训练系列产品：支持
<!-- end id1378 -->
<!-- npu="IPV350" id1379 -->
- IPV350：支持
<!-- end id1379 -->
<!-- @ref: runtime/res/docs/zh/api_ref/24_other_APIs_res.md#id9 -->

### 功能说明

查询运行环境中对应Device的硬件规格大小。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| deviceId | 输入 | Device ID。<br>用户调用[aclrtGetDeviceCount](04_device_management.md#aclrtGetDeviceCount)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)] |
| deviceInfo | 输入 | 指定Device上的硬件规格类型。类型定义请参见[aclDeviceInfo](25-02_Enumerations.md#aclDeviceInfo)。 |
| value | 输出 | 硬件规格值。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtCacheLastTaskOpInfo"></a>

## aclrtCacheLastTaskOpInfo

```c
aclError aclrtCacheLastTaskOpInfo(const void * const infoPtr, const size_t infoSize)
```

### 产品支持情况

<!-- npu="950" id1121 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1121 -->
<!-- npu="A3" id1122 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1122 -->
<!-- npu="910b" id1123 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1123 -->
<!-- npu="310b" id1124 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id1124 -->
<!-- npu="310p" id1125 -->
- Atlas 推理系列产品：支持
<!-- end id1125 -->
<!-- npu="910" id1126 -->
- Atlas 训练系列产品：不支持
<!-- end id1126 -->
<!-- npu="IPV350" id1127 -->
- IPV350：不支持
<!-- end id1127 -->
<!-- @ref: runtime/res/docs/zh/api_ref/24_other_APIs_res.md#id10 -->

### 功能说明

基于捕获方式构建模型运行实例场景下，把指定内存中的算子信息按照infoSize大小缓存到当前线程中最后下发的任务上。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| infoPtr | 输入 | 缓存信息内存地址指针，此处是Host内存 |
| infoSize | 输入 | 缓存信息内存大小，取值范围：(0, 64K]，单位Byte。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 接口调用流程

本接口需与以下其它关键接口配合使用，以便控制后续采集性能数据时附带算子信息：

1. 调用[aclmdlRICaptureBegin](15_model_running_instance__management.md#aclmdlRICaptureBegin)接口开始捕获任务。
2. 调用[aclrtSetStreamAttribute](06_stream_management.md#aclrtSetStreamAttribute)接口开启算子信息缓存开关。
3. 下发算子执行任务，例如调用[aclrtLaunchKernelWithConfig](14_kerne_loading_and_execution.md#aclrtLaunchKernelWithConfig)接口。
4. 调用[aclrtGetStreamAttribute](06_stream_management.md#aclrtGetStreamAttribute)接口获取算子信息缓存开关是否开启。

    只有在捕获状态下，且通过[aclrtSetStreamAttribute](06_stream_management.md#aclrtSetStreamAttribute)接口开启了算子信息缓存开关，此处的[aclrtGetStreamAttribute](06_stream_management.md#aclrtGetStreamAttribute)接口才能获取到算子信息缓存开关已开启的状态，后续才可以缓存算子信息。

5. 调用[aclrtCacheLastTaskOpInfo](#aclrtCacheLastTaskOpInfo)接口缓存算子信息。
6. 再次调用[aclrtSetStreamAttribute](06_stream_management.md#aclrtSetStreamAttribute)接口关闭算子信息缓存开关。
7. 调用[aclmdlRICaptureEnd](15_model_running_instance__management.md#aclmdlRICaptureEnd)接口结束任务捕获。
8. 开启采集性能数据（参见[Profiling数据采集接口](19-01_Profiling数据采集接口.md)章节下的接口）后，调用[aclmdlRIExecuteAsync](15_model_running_instance__management.md#aclmdlRIExecuteAsync)接口执行推理。

    在此过程中，采集的性能数据会附带算子信息。

9. 最后，调用[aclmdlRIDestroy](15_model_running_instance__management.md#aclmdlRIDestroy)接口销毁模型运行实例时，算子缓存信息也会被一并释放。

<br>
<br>
<br>

<a id="aclrtCacheLastTaskExtendInfo"></a>

## aclrtCacheLastTaskExtendInfo

```c
aclError aclrtCacheLastTaskExtendInfo(const char* const extendInfoPtr, const size_t infoSize)
```

### 产品支持情况

<!-- npu="950" id1212 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1212 -->
<!-- npu="A3" id1213 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1213 -->
<!-- npu="910b" id1214 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1214 -->
<!-- npu="310b" id1215 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id1215 -->
<!-- npu="310p" id1216 -->
- Atlas 推理系列产品：支持
<!-- end id1216 -->
<!-- npu="910" id1217 -->
- Atlas 训练系列产品：不支持
<!-- end id1217 -->
<!-- npu="IPV350" id1218 -->
- IPV350：不支持
<!-- end id1218 -->
<!-- @ref: runtime/res/docs/zh/api_ref/24_other_APIs_res.md#id11 -->

### 功能说明

将指定内存中的自定义扩展信息按照infoSize大小缓存到当前线程中最后下发的任务上。后续可以通过调用[aclmdlRIDebugJsonPrint](15_model_running_instance__management.md#aclmdlRIDebugJsonPrint)接口将自定义扩展信息以JSON格式导出到文件中，然后，通过tracing方式（例如chrome://tracing/）查看。
当前仅支持在捕获模型（请参见[aclmdlRICaptureBegin](15_model_running_instance__management.md#aclmdlRICaptureBegin)接口）或构建模型运行实例（请参见[aclmdlRIBuildBegin](15_model_running_instance__management.md#aclmdlRIBuildBegin)接口）的场景下使用。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| extendInfoPtr | 输入 | 指向自定义扩展信息内存地址的指针，此处是Host内存。`extendInfoPtr`指向的内存中的内容应为使用UTF-8编码的JSON格式字符串。非UTF-8编码的JSON格式字符串在后续调用[aclmdlRIDebugJsonPrint](15_model_running_instance__management.md#aclmdlRIDebugJsonPrint)接口时可能导致未定义的行为。 |
| infoSize | 输入 | 自定义扩展信息内存大小，单位Byte。取值范围：(0, 4K]，当`infoSize`大于4K时，仅缓存前4K字节。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtProfTrace"></a>

## aclrtProfTrace

```c
aclError aclrtProfTrace(void *userdata, int32_t length, aclrtStream stream)
```

### 产品支持情况

<!-- npu="950" id106 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id106 -->
<!-- npu="A3" id107 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id107 -->
<!-- npu="910b" id108 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id108 -->
<!-- npu="310b" id109 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id109 -->
<!-- npu="310p" id110 -->
- Atlas 推理系列产品：支持
<!-- end id110 -->
<!-- npu="910" id111 -->
- Atlas 训练系列产品：支持
<!-- end id111 -->
<!-- npu="IPV350" id112 -->
- IPV350：不支持
<!-- end id112 -->
<!-- @ref: runtime/res/docs/zh/api_ref/24_other_APIs_res.md#id12 -->

### 功能说明

支持用户在网络指定位置下发自定义的Profiling打点。异步接口。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| userdata | 输入 | 自定义信息。 |
| length | 输入 | userdata的长度，单位Byte。<br>length建议配置为18字节；如果未满18字节，将会自动在数据末尾补0到18字节；如果超过18字节，接口会校验报错返回。 |
| stream | 输入 | 指定执行打点任务的Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclsysGetVersionNum"></a>

## aclsysGetVersionNum

```c
aclError aclsysGetVersionNum(char *pkgName, int32_t *versionNum)
```

### 产品支持情况

<!-- npu="950" id764 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id764 -->
<!-- npu="A3" id765 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id765 -->
<!-- npu="910b" id766 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id766 -->
<!-- npu="310b" id767 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id767 -->
<!-- npu="310p" id768 -->
- Atlas 推理系列产品：支持
<!-- end id768 -->
<!-- npu="910" id769 -->
- Atlas 训练系列产品：支持
<!-- end id769 -->
<!-- npu="IPV350" id770 -->
- IPV350：不支持
<!-- end id770 -->
<!-- @ref: runtime/res/docs/zh/api_ref/24_other_APIs_res.md#id13 -->

### 功能说明

根据软件包名称查询版本号，版本号是数值类型，通过计算各包安装目录下version.info文件中的version字段的主、次、补丁等版本信息的权重得出。

获取数值类型的版本号并进行比较，数值较大的表示版本发布时间较新，可用于了解版本发布的先后顺序，以及在代码中根据版本区分不同的接口调用逻辑等。

<!-- npu="950,A3,910b,910,310p,310b" id1 -->
当前发布的版本包括商用版和社区版，其中商用版为符合商用标准的正式版本，社区版则是正式发布前的预发布版本。预发布版本分为alpha内部测试版、beta公开测试版和rc（Release Candidate）候选发布版。对于同一基础版本号，其版本号数值按以下顺序递增：alpha版本 < beta版本 < rc版本 < 商用版本。例如：9.0.0-alpha.1 < 9.0.0-alpha.2 < 9.0.0-beta.1 < 9.0.0-beta.2 < 9.0.0-rc.1 < 9.0.0-rc.2 < 9.0.0 < 9.0.1。
<!-- end id1 -->

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| pkgName | 输入 | 软件包名称。<br>CANN包名称与\${INSTALL_DIR}/share/info下的目录名称保持一致。${INSTALL_DIR}请替换为CANN软件安装后文件存储路径。以root用户安装为例，安装后文件默认存储路径为：/usr/local/Ascend/cann。<br>驱动包名称为driver。<br>固件包名称为firmware。 |
| versionNum | 输出 | 数值类型的版本号。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclsysGetVersionStr"></a>

## aclsysGetVersionStr

```c
aclError aclsysGetVersionStr(char *pkgName, char *versionStr)
```

### 产品支持情况

<!-- npu="950" id1177 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1177 -->
<!-- npu="A3" id1178 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1178 -->
<!-- npu="910b" id1179 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1179 -->
<!-- npu="310b" id1180 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1180 -->
<!-- npu="310p" id1181 -->
- Atlas 推理系列产品：支持
<!-- end id1181 -->
<!-- npu="910" id1182 -->
- Atlas 训练系列产品：支持
<!-- end id1182 -->
<!-- npu="IPV350" id1183 -->
- IPV350：不支持
<!-- end id1183 -->
<!-- @ref: runtime/res/docs/zh/api_ref/24_other_APIs_res.md#id14 -->

### 功能说明

根据软件包名称查询版本号，版本号是字符串类型，与各包安装目录下version.info文件中的version保持一致。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| pkgName | 输入 | 软件包名称。<br>CANN包名称与\${INSTALL_DIR}/share/info下的目录名称保持一致。${INSTALL_DIR}请替换为CANN软件安装后文件存储路径。以root用户安装为例，安装后文件默认存储路径为：/usr/local/Ascend/cann。<br>驱动包名称为driver。<br>固件包名称为firmware。 |
| versionStr | 输出 | 版本号。<br>建议用户声明一个长度为ACL_PKG_VERSION_MAX_SIZE的字符数组，用于存放版本号。例如：char versionStr[ACL_PKG_VERSION_MAX_SIZE] = {0};<br>ACL_PKG_VERSION_MAX_SIZE宏的定义如下：<br>#define ACL_PKG_VERSION_MAX_SIZE  128 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclplatformGetDeviceInfo"></a>

## aclplatformGetDeviceInfo

```c
aclError aclplatformGetDeviceInfo(aclplatformDevInfo infoType, char *value, uint32_t maxLen);
```

### 产品支持情况

<!-- npu="950" id1926 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1926 -->
<!-- npu="A3" id1927 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1927 -->
<!-- npu="910b" id1928 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1928 -->
<!-- npu="310b" id1929 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1929 -->
<!-- npu="310p" id1930 -->
- Atlas 推理系列产品：支持
<!-- end id1930 -->
<!-- npu="910" id1931 -->
- Atlas 训练系列产品：支持
<!-- end id1931 -->
<!-- npu="IPV350" id1932 -->
- IPV350：不支持
<!-- end id1932 -->
<!-- @ref: runtime/res/docs/zh/api_ref/24_other_APIs_res.md#id15 -->

### 功能说明

查询对应AI处理器型号的硬件信息。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| infoType | 输入 | 要查询的设备硬件信息类型。类型定义请参见[aclplatformDevInfo](25-02_Enumerations.md#aclplatformDevInfo)。 |
| value | 输出 | 用于接收查询结果的字符缓冲区指针。返回内容以字符串形式给出，数值类信息（如大小、数量、频率）以十进制字符串表示。 |
| maxLen | 输入 | 用户申请的用于存放value的最大内存长度，单位Byte。<br>若实际结果超出此长度，接口将返回错误。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclplatformGetInstructionInfo"></a>

## aclplatformGetInstructionInfo

```c
aclError aclplatformGetInstructionInfo(aclplatformCoreType type,
                                        const char *instruction,
                                        char *value,
                                        uint32_t maxLen);
```

### 产品支持情况

<!-- npu="950" id3508 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3508 -->
<!-- npu="A3" id3509 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3509 -->
<!-- npu="910b" id3510 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3510 -->
<!-- npu="310b" id3511 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id3511 -->
<!-- npu="310p" id3512 -->
- Atlas 推理系列产品：支持
<!-- end id3512 -->
<!-- npu="910" id3513 -->
- Atlas 训练系列产品：支持
<!-- end id3513 -->
<!-- npu="IPV350" id3514 -->
- IPV350：不支持
<!-- end id3514 -->
<!-- @ref: runtime/res/docs/zh/api_ref/24_other_APIs_res.md#id16 -->

### 功能说明

根据指定的核类型，查询某条指令的相关属性信息。

该接口适用于查询当前NPU架构对特定指令的支持情况，以便应用程序根据查询结果选择合适的算法路径或特性开关。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| type | 输入 | 要查询的核类型。类型定义请参见[aclplatformCoreType](25-02_Enumerations.md#aclplatformCoreType)。 |
| instruction | 输入 | 要查询的指令名称字符串，如"Intrinsic_vexp"、"Intrinsic_vln"。<br>指令集可以参考对应AI处理器的配置文件，在${INSTALL_DIR}/{arch-os}/data/platform_config/目录下。<br>${INSTALL_DIR}请替换为CANN软件安装后文件存储路径。以root用户安装为例，安装后文件默认存储路径为：/usr/local/Ascend/cann。<br>{arch-os}中arch表示操作系统架构，os表示操作系统。 |
| value | 输出 | 用于接收查询结果的字符缓冲区指针。返回内容以字符串形式给出。 |
| maxLen | 输入 | 用户申请的用于存放value的最大内存长度，单位Byte。<br>若实际结果超出此长度，接口将返回错误。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtCreateStreamV2"></a>

## aclrtCreateStreamV2

```c
aclError aclrtCreateStreamV2(aclrtStream *stream, const aclrtStreamConfigHandle *handle)
```

### 产品支持情况

<!-- npu="950" id2304 -->
- Ascend 950PR/Ascend 950DT：不支持
<!-- end id2304 -->
<!-- npu="A3" id2305 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：不支持
<!-- end id2305 -->
<!-- npu="910b" id2306 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：不支持
<!-- end id2306 -->
<!-- npu="310b" id2307 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id2307 -->
<!-- npu="310p" id2308 -->
- Atlas 推理系列产品：不支持
<!-- end id2308 -->
<!-- npu="910" id2309 -->
- Atlas 训练系列产品：不支持
<!-- end id2309 -->
<!-- npu="IPV350" id2310 -->
- IPV350：支持
<!-- end id2310 -->
<!-- @ref: runtime/res/docs/zh/api_ref/24_other_APIs_res.md#id17 -->

### 功能说明

创建Stream，支持创建Stream时增加Stream配置。

本接口需要配合其它接口一起使用，创建Stream，接口调用顺序如下：

1. 调用[aclrtCreateStreamConfigHandle](25-03_Operation_APIs.md#aclrtCreateStreamConfigHandle)接口创建Stream配置对象。
2. 多次调用[aclrtSetStreamConfigOpt](#aclrtSetStreamConfigOpt)接口设置配置对象中每个属性的值。
3. 调用aclrtCreateStreamV2接口创建Stream。
4. Stream使用完成后，调用[aclrtDestroyStreamConfigHandle](25-03_Operation_APIs.md#aclrtDestroyStreamConfigHandle)接口销毁Stream配置对象，调用[aclrtDestroyStream](06_stream_management.md#aclrtDestroyStream)接口销毁Stream。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输出 | Stream的指针。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |
| handle | 输入 | Stream配置对象的指针。类型定义请参见[aclrtStreamConfigHandle](25-03_Operation_APIs.md#aclrtStreamConfigHandle)。<br>与[aclrtSetStreamConfigOpt](#aclrtSetStreamConfigOpt)中的handle保持一致。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtSetStreamConfigOpt"></a>

## aclrtSetStreamConfigOpt

```c
aclError aclrtSetStreamConfigOpt(aclrtStreamConfigHandle *handle, aclrtStreamConfigAttr attr, const void *attrValue, size_t valueSize)
```

### 产品支持情况

<!-- npu="950" id120 -->
- Ascend 950PR/Ascend 950DT：不支持
<!-- end id120 -->
<!-- npu="A3" id121 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：不支持
<!-- end id121 -->
<!-- npu="910b" id122 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：不支持
<!-- end id122 -->
<!-- npu="310b" id123 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id123 -->
<!-- npu="310p" id124 -->
- Atlas 推理系列产品：不支持
<!-- end id124 -->
<!-- npu="910" id125 -->
- Atlas 训练系列产品：不支持
<!-- end id125 -->
<!-- npu="IPV350" id126 -->
- IPV350：支持
<!-- end id126 -->
<!-- @ref: runtime/res/docs/zh/api_ref/24_other_APIs_res.md#id18 -->

### 功能说明

设置Stream配置对象中的各属性的取值。

本接口需要配合其它接口一起使用，创建Stream，接口调用顺序如下：

1. 调用[aclrtCreateStreamConfigHandle](25-03_Operation_APIs.md#aclrtCreateStreamConfigHandle)接口创建Stream配置对象。
2. 多次调用aclrtSetStreamConfigOpt接口设置配置对象中每个属性的值。
3. 调用[aclrtCreateStreamV2](#aclrtCreateStreamV2)接口创建Stream。
4. Stream使用完成后，调用[aclrtDestroyStreamConfigHandle](25-03_Operation_APIs.md#aclrtDestroyStreamConfigHandle)接口销毁Stream配置对象，调用[aclrtDestroyStream](06_stream_management.md#aclrtDestroyStream)接口销毁Stream。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| handle | 输出 | Stream配置对象的指针。类型定义请参见[aclrtStreamConfigHandle](25-03_Operation_APIs.md#aclrtStreamConfigHandle)。<br>需提前调用[aclrtCreateStreamConfigHandle](25-03_Operation_APIs.md#aclrtCreateStreamConfigHandle)接口创建该对象。 |
| attr | 输入 | 指定需设置的属性。类型定义请参见[aclrtStreamConfigAttr](25-02_Enumerations.md#aclrtStreamConfigAttr)。 |
| attrValue | 输入 | 指向属性值的指针，attr对应的属性取值。<br>如果属性值本身是指针，则传入该指针的地址。 |
| valueSize | 输入 | attrValue部分的数据长度。<br>用户可使用C/C++标准库的函数sizeof(*attrValue)查询数据长度。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtSubscribeHostFunc"></a>

## aclrtSubscribeHostFunc

```c
aclError aclrtSubscribeHostFunc(uint64_t hostFuncThreadId, aclrtStream exeStream)
```

### 产品支持情况

<!-- npu="950" id2311 -->
- Ascend 950PR/Ascend 950DT：不支持
<!-- end id2311 -->
<!-- npu="A3" id2312 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：不支持
<!-- end id2312 -->
<!-- npu="910b" id2313 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：不支持
<!-- end id2313 -->
<!-- npu="310b" id2314 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id2314 -->
<!-- npu="310p" id2315 -->
- Atlas 推理系列产品：不支持
<!-- end id2315 -->
<!-- npu="910" id2316 -->
- Atlas 训练系列产品：不支持
<!-- end id2316 -->
<!-- npu="IPV350" id2317 -->
- IPV350：支持
<!-- end id2317 -->
<!-- @ref: runtime/res/docs/zh/api_ref/24_other_APIs_res.md#id19 -->

### 功能说明

调用本接口注册处理Stream上回调函数的线程（线程需由用户自行创建）。

<!-- npu="IPV350" id2 -->
**使用场景：**模型中有CPU算子、且调用aclmdlExecuteV2或aclmdlExecuteAsyncV2接口执行模型推理时，由于IPV350上的内存限制，无法支撑CPU算子的调度框架，因此需配合aclrtSubscribeHostFunc、[aclrtProcessHostFunc](#aclrtProcessHostFunc)、[aclrtUnSubscribeHostFunc](#aclrtUnSubscribeHostFunc)接口完成CPU算子调度，完成模型推理。
<!-- end id2 -->

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| hostFuncThreadId | 输入 | 指定线程的ID。 |
| exeStream | 输入 | 指定Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。<br>不支持传NULL，否则返回报错。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

- 支持多次调用aclrtSubscribeHostFunc接口给多个Stream（仅支持同一Device内的多个Stream）注册同一个处理回调函数的线程。
- 为确保Stream内的任务按调用顺序执行，不支持调用aclrtSubscribeHostFunc接口给同一个Stream注册多个处理回调函数的线程。

<br>
<br>
<br>

<a id="aclrtProcessHostFunc"></a>

## aclrtProcessHostFunc

```c
aclError aclrtProcessHostFunc(int32_t timeout)
```

### 产品支持情况

<!-- npu="950" id2465 -->
- Ascend 950PR/Ascend 950DT：不支持
<!-- end id2465 -->
<!-- npu="A3" id2466 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：不支持
<!-- end id2466 -->
<!-- npu="910b" id2467 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：不支持
<!-- end id2467 -->
<!-- npu="310b" id2468 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id2468 -->
<!-- npu="310p" id2469 -->
- Atlas 推理系列产品：不支持
<!-- end id2469 -->
<!-- npu="910" id2470 -->
- Atlas 训练系列产品：不支持
<!-- end id2470 -->
<!-- npu="IPV350" id2471 -->
- IPV350：支持
<!-- end id2471 -->
<!-- @ref: runtime/res/docs/zh/api_ref/24_other_APIs_res.md#id20 -->

### 功能说明

等待指定时间后，触发回调处理，由[aclrtSubscribeHostFunc](#aclrtSubscribeHostFunc)接口指定的线程处理回调。

线程需由用户提前自行创建，并自定义线程函数，在线程函数内调用本接口，等待指定时间后通过系统内部进行算子计算。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| timeout | 输入 | 超时时间，单位为ms。<br>取值范围：<br><br>  - -1：表示无限等待<br>  - 大于0（不包含0）：表示等待的时间 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtUnSubscribeHostFunc"></a>

## aclrtUnSubscribeHostFunc

```c
aclError aclrtUnSubscribeHostFunc(uint64_t hostFuncThreadId, aclrtStream exeStream)
```

### 产品支持情况

<!-- npu="950" id2283 -->
- Ascend 950PR/Ascend 950DT：不支持
<!-- end id2283 -->
<!-- npu="A3" id2284 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：不支持
<!-- end id2284 -->
<!-- npu="910b" id2285 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：不支持
<!-- end id2285 -->
<!-- npu="310b" id2286 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id2286 -->
<!-- npu="310p" id2287 -->
- Atlas 推理系列产品：不支持
<!-- end id2287 -->
<!-- npu="910" id2288 -->
- Atlas 训练系列产品：不支持
<!-- end id2288 -->
<!-- npu="IPV350" id2289 -->
- IPV350：支持
<!-- end id2289 -->
<!-- @ref: runtime/res/docs/zh/api_ref/24_other_APIs_res.md#id21 -->

### 功能说明

与[aclrtSubscribeHostFunc](#aclrtSubscribeHostFunc)接口配合使用，调用模型执行接口后，调用本接口取消线程注册，Stream上的回调函数不再由指定线程处理。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| hostFuncThreadId | 输入 | 指定线程的ID。 |
| exeStream | 输入 | 指定Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。<br>不支持传NULL，否则返回报错。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。
