# 5. Context管理

本章节描述 CANN Runtime 的 Context 管理接口，用于 Context 的创建、销毁、切换及参数配置。

- [`aclError aclrtCreateContext(aclrtContext *context, int32_t deviceId)`](#aclrtCreateContext)：在当前线程中显式创建Context。
- [`aclError aclrtDestroyContext(aclrtContext context)`](#aclrtDestroyContext)：销毁Context，释放Context的资源。
- [`aclError aclrtSetCurrentContext(aclrtContext context)`](#aclrtSetCurrentContext)：设置线程的Context。
- [`aclError aclrtGetCurrentContext(aclrtContext *context)`](#aclrtGetCurrentContext)：获取线程的Context。
- [`aclError aclrtCtxSetSysParamOpt(aclSysParamOpt opt, int64_t value)`](#aclrtCtxSetSysParamOpt)：设置当前Context中的系统参数值，多次调用本接口，以最后一次设置的值为准。
- [`aclError aclrtCtxGetSysParamOpt(aclSysParamOpt opt, int64_t *value)`](#aclrtCtxGetSysParamOpt)：获取当前Context中的系统参数值。
- [`aclError aclrtCtxGetCurrentDefaultStream(aclrtStream *stream)`](#aclrtCtxGetCurrentDefaultStream)：获取Context上的默认Stream。
- [`aclError aclrtGetPrimaryCtxState(int32_t deviceId, uint32_t *flags, int32_t *active)`](#aclrtGetPrimaryCtxState)：获取默认Context的状态。
- [`aclError aclrtCtxGetFloatOverflowAddr(void **overflowAddr)`](#aclrtCtxGetFloatOverflowAddr)：饱和模式下，获取保存溢出标记的Device内存地址，该内存地址后续需作为Workspace参数传递给AI Core算子。


<a id="aclrtCreateContext"></a>

# aclrtCreateContext

```c
aclError aclrtCreateContext(aclrtContext *context, int32_t deviceId)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

在当前线程中显式创建Context。

若不调用aclrtCreateContext接口显式创建Context，那系统会使用默认Context，该默认Context是在调用[aclrtSetDevice](04_Device管理.md#aclrtSetDevice)接口时隐式创建的。默认Context适合简单、无复杂交互逻辑的应用，但缺点在于，在多线程编程中，执行结果取决于线程调度的顺序。显式创建的Context适合大型、复杂交互逻辑的应用，且便于提高程序的可读性、可维护性。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| context | 输出 | Context的指针。类型定义请参见[aclrtContext](25_数据类型及其操作接口.md#aclrtContext)。 |
| deviceId | 输入 | 在指定的Device下创建Context。<br>用户调用[aclrtGetDeviceCount](04_Device管理.md#aclrtGetDeviceCount)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)] |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。

### 约束说明

-   在某一进程中指定Device，该进程内的多个线程可共用在此Device上显式创建的Context。
-   若在某一进程内创建多个Context，Context的数量与Stream相关，Stream数量有限制，请参见显式创建Stream的接口。当前线程在同一时刻内只能使用其中一个Context，建议通过[aclrtSetCurrentContext](#aclrtSetCurrentContext)接口明确指定当前线程的Context，增加程序的可维护性**。**
-   调用本接口创建的Context中包含一个默认Stream。
-   如果在应用程序中没有调用[aclrtSetDevice](04_Device管理.md#aclrtSetDevice)接口，那么在首次调用aclrtCreateContext接口时，系统内部会根据该接口传入的Device ID，为该Device绑定一个默认Stream（一个Device仅绑定一个默认Stream），因此在首次调用aclrtCreateContext接口时，占用的Stream数量 = Device上绑定的默认Stream + Context中包含的Stream。


<br>
<br>
<br>



<a id="aclrtDestroyContext"></a>

# aclrtDestroyContext

```c
aclError aclrtDestroyContext(aclrtContext context)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

销毁Context，释放Context的资源。只能销毁通过[aclrtCreateContext](#aclrtCreateContext)接口创建的Context。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| context | 输入 | 需销毁的Context。类型定义请参见[aclrtContext](25_数据类型及其操作接口.md#aclrtContext)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtSetCurrentContext"></a>

# aclrtSetCurrentContext

```c
aclError aclrtSetCurrentContext(aclrtContext context)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

设置线程的Context。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| context | 输入 | 指定线程当前的Context。类型定义请参见[aclrtContext](25_数据类型及其操作接口.md#aclrtContext)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。

### 约束说明

-   支持以下场景：
    -   如果在某线程（例如：thread1）中调用[aclrtCreateContext](#aclrtCreateContext)接口显式创建一个Context（例如：ctx1），则可以不调用aclrtSetCurrentContext接口指定该线程的Context，系统默认将ctx1作为thread1的Context。
    -   如果没有调用[aclrtCreateContext](#aclrtCreateContext)接口显式创建Context，则系统将默认Context作为线程的Context，此时，不能通过[aclrtDestroyContext](#aclrtDestroyContext)接口来释放默认Context。
    -   如果多次调用aclrtSetCurrentContext接口设置线程的Context，以最后一次为准。

-   若给线程设置的Context所对应的Device已经被复位，则不能将该Context设置为线程的Context，否则会导致业务异常。
-   推荐在某一线程中创建的Context，在该线程中使用。若在线程A中调用[aclrtCreateContext](#aclrtCreateContext)接口创建Context，在线程B中使用该Context，则需由用户自行保证两个线程中同一个Context下同一个Stream中任务执行的顺序。
-   调用aclrtSetCurrentContext接口通过切换Context时，如果新Context与当前Context所属的Device不同时，Device也会随之切换。


<br>
<br>
<br>



<a id="aclrtGetCurrentContext"></a>

# aclrtGetCurrentContext

```c
aclError aclrtGetCurrentContext(aclrtContext *context)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

获取线程的Context。

如果用户多次调用[aclrtSetCurrentContext](#aclrtSetCurrentContext)接口设置当前线程的Context，则获取的是最后一次设置的Context。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| context | 输出 | 线程当前Context的指针。类型定义请参见[aclrtContext](25_数据类型及其操作接口.md#aclrtContext)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtCtxSetSysParamOpt"></a>

# aclrtCtxSetSysParamOpt

```c
aclError aclrtCtxSetSysParamOpt(aclSysParamOpt opt, int64_t value)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

设置当前Context中的系统参数值，多次调用本接口，以最后一次设置的值为准。调用本接口设置运行时参数值后，若需获取参数值，需调用[aclrtCtxGetSysParamOpt](#aclrtCtxGetSysParamOpt)接口。

本接口与[aclrtSetSysParamOpt](03_运行时配置.md#aclrtSetSysParamOpt)接口的差别是，本接口作用域是Context，aclrtSetSysParamOpt的作用域是进程。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| opt | 输入 | 系统参数。类型定义请参见[aclSysParamOpt](25_数据类型及其操作接口.md#aclSysParamOpt)。 |
| value | 输入 | 系统参数值。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtCtxGetSysParamOpt"></a>

# aclrtCtxGetSysParamOpt

```c
aclError aclrtCtxGetSysParamOpt(aclSysParamOpt opt, int64_t *value)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

获取当前Context中的系统参数值。

系统参数无默认值，如果不调用[aclrtCtxSetSysParamOpt](#aclrtCtxSetSysParamOpt)接口设置系统参数的值，直接调用本接口获取系统参数的值，接口会返回失败。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| opt | 输入 | 系统参数。类型定义请参见[aclSysParamOpt](25_数据类型及其操作接口.md#aclSysParamOpt)。 |
| value | 输出 | 存放系统参数值的内存的指针。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtCtxGetCurrentDefaultStream"></a>

# aclrtCtxGetCurrentDefaultStream

```c
aclError aclrtCtxGetCurrentDefaultStream(aclrtStream *stream)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

获取Context上的默认Stream。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输出 | 获取到的默认Stream。类型定义请参见[aclrtStream](25_数据类型及其操作接口.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtGetPrimaryCtxState"></a>

# aclrtGetPrimaryCtxState

```c
aclError aclrtGetPrimaryCtxState(int32_t deviceId, uint32_t *flags, int32_t *active)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

获取默认Context的状态。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| deviceId | 输入 | 获取指定Device下的默认Context。<br>用户调用[aclrtGetDeviceCount](04_Device管理.md#aclrtGetDeviceCount)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)] |
| flags | 输出 | 预留参数。当前固定传NULL。 |
| active | 输出 | 存放默认Context状态的指针。<br>状态值如下：<br><br>  - 0：未激活<br>  - 1：激活 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtCtxGetFloatOverflowAddr"></a>

# aclrtCtxGetFloatOverflowAddr

```c
aclError aclrtCtxGetFloatOverflowAddr(void **overflowAddr)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

饱和模式下，获取保存溢出标记的Device内存地址，该内存地址后续需作为Workspace参数传递给AI Core算子。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| overflowAddr | 输出 | 保存溢出标记的Device内存地址。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。
