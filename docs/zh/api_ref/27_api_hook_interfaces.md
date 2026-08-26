# 27. API Hook接口

本章节描述CANN Runtime的API Hook接口，用于支持性能分析工具（如Profiling）通过注入Hook函数的方式拦截部分Runtime接口（这里指aclrt、aclmdlRI开头的接口，但不包含本章中的接口）。

- [`aclError aclrtApiInjectionSetFunc(const char* name, aclrtApiFunc func)`](#aclrtApiInjectionSetFunc)：将指定名称的Runtime接口的当前实现函数指针设置为指定的Hook函数。
- [`aclError aclrtApiInjectionGetFunc(const char* name, aclrtApiFunc* originFunc, aclrtApiFunc* currentFunc)`](#aclrtApiInjectionGetFunc)：获取指定名称的Runtime接口的原始实现函数指针和当前实现函数指针。

<a id="aclrtApiInjectionSetFunc"></a>

## aclrtApiInjectionSetFunc

```c
aclError aclrtApiInjectionSetFunc(const char* name, aclrtApiFunc func)
```

### 产品支持情况

<!-- npu="950" id3550 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3550 -->
<!-- npu="A3" id3551 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3551 -->
<!-- npu="910b" id3552 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3552 -->
<!-- npu="310b" id3553 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id3553 -->
<!-- npu="310p" id3554 -->
- Atlas 推理系列产品：支持
<!-- end id3554 -->
<!-- npu="910" id3555 -->
- Atlas 训练系列产品：支持
<!-- end id3555 -->
<!-- npu="IPV350" id3556 -->
- IPV350：不支持
<!-- end id3556 -->
<!-- @ref: runtime/res/docs/zh/api_ref/27_api_hook_res.md#id1 -->

### 功能说明

将指定名称的Runtime接口指向对应的Hook函数实现。设置后，调用该Runtime接口时将跳转到Hook函数执行。

可通过本接口注入Hook函数，实现对Runtime接口调用的拦截和统计。若需恢复原始行为，可调用本接口并传入原始函数指针。原始函数指针可通过[aclrtApiInjectionGetFunc](#aclrtApiInjectionGetFunc)获取。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| name | 输入 | Runtime接口名称，需与Runtime接口名称完全匹配，例如`"aclrtMemcpy"`。 |
| func | 输入 | Hook函数指针。类型定义请参见[aclrtApiFunc](25-05_Typedefs.md#aclrtApiFunc)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

- 本接口建议在调用对应的Runtime接口之前调用，需由用户保证接口调用的时序。
- aclrtApiInjectionSetFunc接口和aclrtApiInjectionGetFunc接口调用时，需由用户保证多线程调用时序。
- 当前支持Hook的接口范围为aclrt接口和aclmdlRI开头的接口，不支持aclInit、aclFinalize等接口。
- 对于不支持Hook功能的产品型号，本接口返回`ACL_ERROR_FEATURE_UNSUPPORTED`。

<br>
<br>
<br>

<a id="aclrtApiInjectionGetFunc"></a>

## aclrtApiInjectionGetFunc

```c
aclError aclrtApiInjectionGetFunc(const char* name, aclrtApiFunc* originFunc, aclrtApiFunc* currentFunc)
```

### 产品支持情况

<!-- npu="950" id3557 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3557 -->
<!-- npu="A3" id3558 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3558 -->
<!-- npu="910b" id3559 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3559 -->
<!-- npu="310b" id3560 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id3560 -->
<!-- npu="310p" id3561 -->
- Atlas 推理系列产品：支持
<!-- end id3561 -->
<!-- npu="910" id3562 -->
- Atlas 训练系列产品：支持
<!-- end id3562 -->
<!-- npu="IPV350" id3563 -->
- IPV350：不支持
<!-- end id3563 -->
<!-- @ref: runtime/res/docs/zh/api_ref/27_api_hook_res.md#id2 -->

### 功能说明

获取指定名称的Runtime接口的原始实现函数指针和当前实现函数指针。

在运行时初始化阶段，原始实现指针（`originFunc`）与当前实现指针（`currentFunc`）相等。当工具调用[aclrtApiInjectionSetFunc](#aclrtApiInjectionSetFunc)注入Hook函数后，`currentFunc`指向Hook函数，`originFunc`保持不变。当查询`originFunc`和`currentFunc`不一致时，表示该接口实现已被Hook函数替换。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| name | 输入 | Runtime接口名称，需与Runtime接口名称完全匹配，例如`"aclrtMemcpy"`。 |
| originFunc | 输出 | 原始函数指针。若不需要可传nullptr。类型定义请参见[aclrtApiFunc](25-05_Typedefs.md#aclrtApiFunc)。 |
| currentFunc | 输出 | 当前函数指针。若不需要可传nullptr。类型定义请参见[aclrtApiFunc](25-05_Typedefs.md#aclrtApiFunc)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

- 对于不支持Hook功能的产品型号，本接口返回`ACL_ERROR_FEATURE_UNSUPPORTED`。
- aclrtApiInjectionSetFunc接口和aclrtApiInjectionGetFunc接口调用时，需由用户保证多线程调用时序。

<br>
<br>
<br>
