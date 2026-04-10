# 6. Stream管理

本章节描述 CANN Runtime 的 Stream 管理接口，用于 Stream 的创建、销毁、同步、查询及属性配置。

- [`aclError aclrtCreateStream(aclrtStream *stream)`](#aclrtCreateStream)：创建Stream。
- [`aclError aclrtCreateStreamV2(aclrtStream *stream, const aclrtStreamConfigHandle *handle)`](#aclrtCreateStreamV2)：创建Stream，支持创建Stream时增加Stream配置。
- [`aclError aclrtSetStreamConfigOpt(aclrtStreamConfigHandle *handle, aclrtStreamConfigAttr attr, const void *attrValue, size_t valueSize)`](#aclrtSetStreamConfigOpt)：设置Stream配置对象中的各属性的取值。
- [`aclError aclrtCreateStreamWithConfig(aclrtStream *stream, uint32_t priority, uint32_t flag)`](#aclrtCreateStreamWithConfig)：在当前进程或线程中创建Stream。
- [`aclError aclrtDestroyStream(aclrtStream stream)`](#aclrtDestroyStream)：销毁Stream，销毁通过[aclrtCreateStream](#aclrtCreateStream)或[aclrtCreateStreamWithConfig](#aclrtCreateStreamWithConfig)或[aclrtCreateStreamV2](#aclrtCreateStreamV2)接口创建的Stream，若Stream上有未完成的任务，会等待任务完成后再销毁Stream。
- [`aclError aclrtDestroyStreamForce(aclrtStream stream)`](#aclrtDestroyStreamForce)：销毁Stream，销毁通过[aclrtCreateStream](#aclrtCreateStream)或[aclrtCreateStreamWithConfig](#aclrtCreateStreamWithConfig)接口创建的Stream，若Stream上有未完成的任务，不会等待任务完成，直接强制销毁Stream。
- [`aclError aclrtSetStreamOverflowSwitch(aclrtStream stream, uint32_t flag)`](#aclrtSetStreamOverflowSwitch)：饱和模式下，对接上层训练框架时（例如PyTorch），针对指定Stream，打开或关闭溢出检测开关，关闭后无法通过溢出检测算子获取任务是否溢出。
- [`aclError aclrtGetStreamOverflowSwitch(aclrtStream stream, uint32_t *flag)`](#aclrtGetStreamOverflowSwitch)：针对指定Stream，获取其当前溢出检测开关是否打开。
- [`aclError aclrtSetStreamFailureMode(aclrtStream stream, uint64_t mode)`](#aclrtSetStreamFailureMode)：当一个Stream上下发了多个任务时，可通过本接口指定任务调度模式，以便控制某个任务失败后是否继续执行下一个任务。
- [`aclError aclrtStreamQuery(aclrtStream stream, aclrtStreamStatus *status)`](#aclrtStreamQuery)：查询指定Stream上的所有任务的执行状态。
- [`aclError aclrtSynchronizeStream(aclrtStream stream)`](#aclrtSynchronizeStream)：阻塞Host侧当前线程直到指定Stream中的所有任务都完成。
- [`aclError aclrtSynchronizeStreamWithTimeout(aclrtStream stream, int32_t timeout)`](#aclrtSynchronizeStreamWithTimeout)：阻塞Host侧当前线程直到指定Stream中的所有任务都完成，该接口是在[aclrtSynchronizeStream](#aclrtSynchronizeStream)接口基础上进行了增强，支持用户设置超时时间，当应用程序异常时可根据所设置的超时时间自行退出。
- [`aclError aclrtStreamAbort(aclrtStream stream)`](#aclrtStreamAbort)：停止指定Stream上正在执行的任务、丢弃指定Stream上已下发但未执行的任务。本接口执行期间，指定Stream上新下发的任务不再生效。
- [`aclError aclrtStreamGetId(aclrtStream stream, int32_t *streamId)`](#aclrtStreamGetId)：获取指定Stream的ID。
- [`aclError aclrtGetStreamAvailableNum(uint32_t *streamCount)`](#aclrtGetStreamAvailableNum)：获取当前Device上剩余可用的Stream数量。
- [`aclError aclrtSetStreamAttribute(aclrtStream stream, aclrtStreamAttr stmAttrType, aclrtStreamAttrValue *value)`](#aclrtSetStreamAttribute)：设置Stream属性值。
- [`aclError aclrtGetStreamAttribute(aclrtStream stream, aclrtStreamAttr stmAttrType, aclrtStreamAttrValue *value)`](#aclrtGetStreamAttribute)：获取Stream属性值。
- [`aclError aclrtActiveStream(aclrtStream activeStream, aclrtStream stream)`](#aclrtActiveStream)：激活Stream。异步接口。
- [`aclError aclrtSwitchStream(void *leftValue, aclrtCondition cond, void *rightValue, aclrtCompareDataType dataType, aclrtStream trueStream, aclrtStream falseStream, aclrtStream stream)`](#aclrtSwitchStream)：根据条件在Stream之间跳转。异步接口。
- [`aclError aclrtRegStreamStateCallback(const char *regName, aclrtStreamStateCallback callback, void *args)`](#aclrtRegStreamStateCallback)：注册Stream状态回调函数，不支持重复注册。
- [aclrtStreamStop](#aclrtStreamStop)
- [`aclError aclrtStreamStop(aclrtStream stream)`](#acIrtStreamStop)：仅停止指定Stream上的正在执行的任务，不清理任务。
- [`aclError aclrtPersistentTaskClean(aclrtStream stream)`](#aclrtPersistentTaskClean)：清理ACL\_STREAM\_PERSISTENT类型的Stream上的任务，适用于在不删除该类型Stream的情况下重新下发任务的场景。
- [`aclError aclrtStreamGetPriority(aclrtStream stream, uint32_t *priority)`](#aclrtStreamGetPriority)：查询指定Stream的优先级。
- [`aclError aclrtStreamGetFlags(aclrtStream stream, uint32_t *flags)`](#aclrtStreamGetFlags)：查询创建Stream时设置的flag标志。


<a id="aclrtCreateStream"></a>

# aclrtCreateStream

```c
aclError aclrtCreateStream(aclrtStream *stream)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

创建Stream。

该接口不支持设置Stream的优先级；若不设置，Stream的优先级默认为最高。如需在创建Stream时设置优先级，请参见[aclrtCreateStreamWithConfig](#aclrtCreateStreamWithConfig)接口。

若不显式调用Stream创建接口，那么每个Context对应一个默认Stream，该默认Stream是调用[aclrtSetDevice](04_Device管理.md#aclrtSetDevice)接口或[aclrtCreateContext](05_Context管理.md#aclrtCreateContext)接口隐式创建的，默认Stream的优先级不支持设置，为最高优先级。默认Stream适合简单、无复杂交互逻辑的应用，但缺点在于，在多线程编程中，执行结果取决于线程调度的顺序。显式创建的Stream适合大型、复杂交互逻辑的应用，且便于提高程序的可读性、可维护性，**推荐显式**。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输出 | Stream的指针。类型定义请参见[aclrtStream](24_数据类型及其操作接口.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。

### 约束说明

不同型号的硬件支持的Stream最大数不同，如果已存在多个Stream（包含默认Stream、执行内部同步的Stream），则只能显式创建N个Stream，N = Stream最大数 - 已存在的Stream数。例如，Stream最大数为1024，已存在2个Stream，则只能调用本接口显式创建1022个Stream。


| 型号 | Stream最大数 |
| --- | --- |
| Ascend 950PR/Ascend 950DT<br>Atlas A3 训练系列产品/Atlas A3 推理系列产品<br>Atlas A2 训练系列产品/Atlas A2 推理系列产品 | 1984 |


<br>
<br>
<br>



<a id="aclrtCreateStreamV2"></a>

# aclrtCreateStreamV2

```c
aclError aclrtCreateStreamV2(aclrtStream *stream, const aclrtStreamConfigHandle *handle)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | ☓ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | ☓ |

### 功能说明

创建Stream，支持创建Stream时增加Stream配置。

本接口需要配合其它接口一起使用，创建Stream，接口调用顺序如下：

1.  调用[aclrtCreateStreamConfigHandle](24_数据类型及其操作接口.md#aclrtCreateStreamConfigHandle)接口创建Stream配置对象。
2.  多次调用[aclrtSetStreamConfigOpt](#aclrtSetStreamConfigOpt)接口设置配置对象中每个属性的值。
3.  调用aclrtCreateStreamV2接口创建Stream。
4.  Stream使用完成后，调用[aclrtDestroyStreamConfigHandle](24_数据类型及其操作接口.md#aclrtDestroyStreamConfigHandle)接口销毁Stream配置对象，调用[aclrtDestroyStream](#aclrtDestroyStream)接口销毁Stream。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输出 | Stream的指针。类型定义请参见[aclrtStream](24_数据类型及其操作接口.md#aclrtStream)。 |
| handle | 输入 | Stream配置对象的指针。类型定义请参见[aclrtStreamConfigHandle](24_数据类型及其操作接口.md#aclrtStreamConfigHandle)。<br>与[aclrtSetStreamConfigOpt](#aclrtSetStreamConfigOpt)中的handle保持一致。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtSetStreamConfigOpt"></a>

# aclrtSetStreamConfigOpt

```c
aclError aclrtSetStreamConfigOpt(aclrtStreamConfigHandle *handle, aclrtStreamConfigAttr attr, const void *attrValue, size_t valueSize)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | ☓ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | ☓ |

### 功能说明

设置Stream配置对象中的各属性的取值。

本接口需要配合其它接口一起使用，创建Stream，接口调用顺序如下：

1.  调用[aclrtCreateStreamConfigHandle](24_数据类型及其操作接口.md#aclrtCreateStreamConfigHandle)接口创建Stream配置对象。
2.  多次调用aclrtSetStreamConfigOpt接口设置配置对象中每个属性的值。
3.  调用[aclrtCreateStreamV2](#aclrtCreateStreamV2)接口创建Stream。
4.  Stream使用完成后，调用[aclrtDestroyStreamConfigHandle](24_数据类型及其操作接口.md#aclrtDestroyStreamConfigHandle)接口销毁Stream配置对象，调用[aclrtDestroyStream](#aclrtDestroyStream)接口销毁Stream。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| handle | 输出 | Stream配置对象的指针。类型定义请参见[aclrtStreamConfigHandle](24_数据类型及其操作接口.md#aclrtStreamConfigHandle)。<br>需提前调用[aclrtCreateStreamConfigHandle](24_数据类型及其操作接口.md#aclrtCreateStreamConfigHandle)接口创建该对象。 |
| attr | 输入 | 指定需设置的属性。类型定义请参见[aclrtStreamConfigAttr](24_数据类型及其操作接口.md#aclrtStreamConfigAttr)。 |
| attrValue | 输入 | 指向属性值的指针，attr对应的属性取值。<br>如果属性值本身是指针，则传入该指针的地址。 |
| valueSize | 输入 | attrValue部分的数据长度。<br>用户可使用C/C++标准库的函数sizeof(*attrValue)查询数据长度。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtCreateStreamWithConfig"></a>

# aclrtCreateStreamWithConfig

```c
aclError aclrtCreateStreamWithConfig(aclrtStream *stream, uint32_t priority, uint32_t flag)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

在当前进程或线程中创建Stream。

相比[aclrtCreateStream](#aclrtCreateStream)接口，使用本接口可以创建一个快速下发任务的Stream，但会增加内存消耗或CPU的性能消耗。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输出 | Stream的指针。类型定义请参见[aclrtStream](24_数据类型及其操作接口.md#aclrtStream)。 |
| priority | 输入 | 优先级。<br>该参数为预留参数，暂不使用。 |
| flag | 输入 | Stream指针的flag。<br>flag既支持配置单个宏，也支持配置多个宏位或。对于不支持位或的宏，本接口会返回报错。配置其他值创建出来的Stream等同于通过aclrtCreateStream接口创建出来的Stream。<br>flag参数值请参见“flag取值说明”。 |

### flag取值说明

-   **ACL\_STREAM\_FAST\_LAUNCH**：使用该flag创建出来的Stream，在使用Stream时，下发任务的速度更快。

    相比[aclrtCreateStream](#aclrtCreateStream)接口创建出来的Stream，在使用Stream时才会申请系统内部资源，导致下发任务的时长增加，使用本接口的**ACL\_STREAM\_FAST\_LAUNCH**模式创建Stream时，会在创建Stream时预申请系统内部资源，因此创建Stream的时长增加，下发任务的时长缩短，总体来说，创建一次Stream，使用多次的场景下，总时长缩短，但创建Stream时预申请内部资源会增加内存消耗。

    ```
    #define ACL_STREAM_FAST_LAUNCH      0x00000001U
    ```

-   **ACL\_STREAM\_FAST\_SYNC**：使用该flag创建出来的Stream，在调用[aclrtSynchronizeStream](#aclrtSynchronizeStream)接口时，会阻塞当前线程，主动查询任务的执行状态，一旦任务完成，立即返回。

    相比[aclrtCreateStream](#aclrtCreateStream)接口创建出来的Stream，在调用[aclrtSynchronizeStream](#aclrtSynchronizeStream)接口时，会一直被动等待Device上任务执行完成的通知，等待时间长，使用本接口的**ACL\_STREAM\_FAST\_SYNC**模式创建的Stream，没有被动等待，总时长缩短，但主动查询的操作会增加CPU的性能消耗。

    ```
    #define ACL_STREAM_FAST_SYNC        0x00000002U
    ```

-   **ACL\_STREAM\_PERSISTENT**：使用该flag创建出来的Stream，在该Stream上下发的任务不会立即执行、任务执行完成后也不会立即销毁，在销毁Stream时才会销毁任务相关的资源。该方式下创建的Stream用于与模型绑定，适用于模型构建场景，模型构建相关接口的说明请参见[aclmdlRIBindStream](15_模型运行实例管理.md#aclmdlRIBindStream)。

    ```
    #define ACL_STREAM_PERSISTENT       0x00000004U
    ```

-   **ACL\_STREAM\_HUGE**：相比其他flag，使用该flag创建出来的Stream所能容纳的Task最大数量更大。

    当前版本设置该flag不生效。

    ```
    #define ACL_STREAM_HUGE             0x00000008U
    ```

-   **ACL\_STREAM\_CPU\_SCHEDULE**：使用该flag创建出来的Stream用于队列方式模型推理场景下承载AI CPU调度的相关任务。预留功能。

    ```
    #define ACL_STREAM_CPU_SCHEDULE     0x00000010U
    ```

-   **ACL\_STREAM\_DEVICE\_USE\_ONLY**：表示该Stream仅在Device上调用。

    ```
    #define ACL_STREAM_DEVICE_USE_ONLY  0x00000020U
    ```

    仅如下型号支持ACL\_STREAM\_DEVICE\_USE\_ONLY：

    Ascend 950PR/Ascend 950DT

    Atlas A3 训练系列产品/Atlas A3 推理系列产品

    Atlas A2 训练系列产品/Atlas A2 推理系列产品

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtDestroyStream"></a>

# aclrtDestroyStream

```c
aclError aclrtDestroyStream(aclrtStream stream)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

销毁Stream，销毁通过[aclrtCreateStream](#aclrtCreateStream)或[aclrtCreateStreamWithConfig](#aclrtCreateStreamWithConfig)或[aclrtCreateStreamV2](#aclrtCreateStreamV2)接口创建的Stream，若Stream上有未完成的任务，会等待任务完成后再销毁Stream。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 待销毁的Stream。类型定义请参见[aclrtStream](24_数据类型及其操作接口.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。

### 约束说明

-   在调用aclrtDestroyStream接口销毁指定Stream前，需要先调用[aclrtSynchronizeStream](#aclrtSynchronizeStream)接口确保Stream中的任务都已完成。
-   调用aclrtDestroyStream接口销毁指定Stream时，需确保该Stream在当前Context下。
-   在调用aclrtDestroyStream接口销毁指定Stream时，需确保其它接口没有正在使用该Stream。


<br>
<br>
<br>



<a id="aclrtDestroyStreamForce"></a>

# aclrtDestroyStreamForce

```c
aclError aclrtDestroyStreamForce(aclrtStream stream)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

销毁Stream，销毁通过[aclrtCreateStream](#aclrtCreateStream)或[aclrtCreateStreamWithConfig](#aclrtCreateStreamWithConfig)接口创建的Stream，若Stream上有未完成的任务，不会等待任务完成，直接强制销毁Stream。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 待销毁的Stream。类型定义请参见[aclrtStream](24_数据类型及其操作接口.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。

### 约束说明

调用本接口销毁指定Stream时，需确保该Stream在当前Context下。


<br>
<br>
<br>



<a id="aclrtSetStreamOverflowSwitch"></a>

# aclrtSetStreamOverflowSwitch

```c
aclError aclrtSetStreamOverflowSwitch(aclrtStream stream, uint32_t flag)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

饱和模式下，对接上层训练框架时（例如PyTorch），针对指定Stream，打开或关闭溢出检测开关，关闭后无法通过溢出检测算子获取任务是否溢出。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 待操作Stream。类型定义请参见[aclrtStream](24_数据类型及其操作接口.md#aclrtStream)。 |
| flag | 输入 | 溢出检测开关，取值范围如下：<br><br>  - 0：关闭<br>  - 1：打开 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。

### 约束说明

-   在调用本接口前，可调用[aclrtSetDeviceSatMode](04_Device管理.md#aclrtSetDeviceSatMode)接口设置饱和模式。
-   调用该接口打开或关闭溢出检测开关后，仅对后续新下发的任务生效，已下发的任务仍维持原样。


<br>
<br>
<br>



<a id="aclrtGetStreamOverflowSwitch"></a>

# aclrtGetStreamOverflowSwitch

```c
aclError aclrtGetStreamOverflowSwitch(aclrtStream stream, uint32_t *flag)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

针对指定Stream，获取其当前溢出检测开关是否打开。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 待操作Stream。类型定义请参见[aclrtStream](24_数据类型及其操作接口.md#aclrtStream)。 |
| flag | 输出 | 溢出检测开关，取值范围如下：<br><br>  - 0：关闭<br>  - 1：打开 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtSetStreamFailureMode"></a>

# aclrtSetStreamFailureMode

```c
aclError aclrtSetStreamFailureMode(aclrtStream stream, uint64_t mode)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

当一个Stream上下发了多个任务时，可通过本接口指定任务调度模式，以便控制某个任务失败后是否继续执行下一个任务。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 待操作Stream。类型定义请参见[aclrtStream](24_数据类型及其操作接口.md#aclrtStream)。<br>各产品型号对默认Stream（即该参数传入NULL）的支持情况不同，如下：<br>Ascend 950PR/Ascend 950DT，支持<br>Atlas A3 训练系列产品/Atlas A3 推理系列产品，支持<br>Atlas A2 训练系列产品/Atlas A2 推理系列产品，支持 |
| mode | 输入 | 当一个Stream上下发了多个任务时，可通过本参数指定任务调度模式，以便控制某个任务失败后是否继续执行下一个任务。<br>取值范围如下：<br><br>  - ACL_CONTINUE_ON_FAILURE：默认值，某个任务失败后，继续执行下一个任务；<br>  - ACL_STOP_ON_FAILURE：某个任务失败后，停止执行后续任务，通常称作遇错即停。触发遇错即停之后，不支持再下发新任务。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。

### 约束说明

-   针对指定Stream只能调用一次本接口设置任务调度模式。
-   当Stream上设置了遇错即停模式，该Stream所在的Context下的其它Stream也是遇错即停 。该约束适用于以下产品型号：

    Atlas A3 训练系列产品/Atlas A3 推理系列产品

    Atlas A2 训练系列产品/Atlas A2 推理系列产品


<br>
<br>
<br>



<a id="aclrtStreamQuery"></a>

# aclrtStreamQuery

```c
aclError aclrtStreamQuery(aclrtStream stream, aclrtStreamStatus *status)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

查询指定Stream上的所有任务的执行状态。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | Stream的指针。类型定义请参见[aclrtStream](24_数据类型及其操作接口.md#aclrtStream)。 |
| status | 输出 | Stream上的任务状态。类型定义请参见[aclrtStreamStatus](24_数据类型及其操作接口.md#aclrtStreamStatus)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtSynchronizeStream"></a>

# aclrtSynchronizeStream

```c
aclError aclrtSynchronizeStream(aclrtStream stream)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

阻塞Host侧当前线程直到指定Stream中的所有任务都完成。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 指定需要完成所有任务的Stream。类型定义请参见[aclrtStream](24_数据类型及其操作接口.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtSynchronizeStreamWithTimeout"></a>

# aclrtSynchronizeStreamWithTimeout

```c
aclError aclrtSynchronizeStreamWithTimeout(aclrtStream stream, int32_t timeout)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

阻塞Host侧当前线程直到指定Stream中的所有任务都完成，该接口是在[aclrtSynchronizeStream](#aclrtSynchronizeStream)接口基础上进行了增强，支持用户设置超时时间，当应用程序异常时可根据所设置的超时时间自行退出。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 指定需要完成所有任务的Stream。类型定义请参见[aclrtStream](24_数据类型及其操作接口.md#aclrtStream)。 |
| timeout | 输入 | 接口的超时时间。<br>取值说明如下：<br><br>  - -1：表示永久等待，和接口[aclrtSynchronizeStream](#aclrtSynchronizeStream)功能一样；<br>  - >0：配置具体的超时时间，单位是毫秒。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtStreamAbort"></a>

# aclrtStreamAbort

```c
aclError aclrtStreamAbort(aclrtStream stream)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

停止指定Stream上正在执行的任务、丢弃指定Stream上已下发但未执行的任务。本接口执行期间，指定Stream上新下发的任务不再生效。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 指定待停止任务的Stream。类型定义请参见[aclrtStream](24_数据类型及其操作接口.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。

### 约束说明

-   不支持使用[aclmdlRIBindStream](15_模型运行实例管理.md#aclmdlRIBindStream)接口来绑定模型运行实例的Stream。
-   不支持如下方式创建的Stream：调用[aclrtCreateStreamWithConfig](#aclrtCreateStreamWithConfig)接口，将flag设置为ACL\_STREAM\_DEVICE\_USE\_ONLY（表示该Stream仅在Device上调用）。
-   如果有其它Stream依赖本接口中指定的Stream（例如通过[aclrtRecordEvent](07_Event管理.md#aclrtRecordEvent)、[aclrtStreamWaitEvent](07_Event管理.md#aclrtStreamWaitEvent)等接口实现两个Stream间同步等待），则其它Stream执行可能会卡住，此时您需要显式调用本接口清除其它Stream上的任务。
-   如果调用本接口清除指定Stream上的任务时，再调用同步等待接口（例如[aclrtSynchronizeStream](#aclrtSynchronizeStream)、[aclrtSynchronizeEvent](07_Event管理.md#aclrtSynchronizeEvent)等），同步等待接口会退出并返回ACL\_ERROR\_RT\_STREAM\_ABORT的报错。


<br>
<br>
<br>



<a id="aclrtStreamGetId"></a>

# aclrtStreamGetId

```c
aclError aclrtStreamGetId(aclrtStream stream, int32_t *streamId)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

获取指定Stream的ID。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 指定要查询的Stream。类型定义请参见[aclrtStream](24_数据类型及其操作接口.md#aclrtStream)。<br>若此处传入NULL，则获取的是默认Stream的ID。 |
| streamId | 输出 | Stream ID。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtGetStreamAvailableNum"></a>

# aclrtGetStreamAvailableNum

```c
aclError aclrtGetStreamAvailableNum(uint32_t *streamCount)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

获取当前Device上剩余可用的Stream数量。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| streamCount | 输出 | Stream数量。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtSetStreamAttribute"></a>

# aclrtSetStreamAttribute

```c
aclError aclrtSetStreamAttribute(aclrtStream stream, aclrtStreamAttr stmAttrType, aclrtStreamAttrValue *value)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

设置Stream属性值。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 指定Stream。类型定义请参见[aclrtStream](24_数据类型及其操作接口.md#aclrtStream)。<br>各产品型号对默认Stream（即该参数传入NULL）的支持情况不同，如下：<br>Ascend 950PR/Ascend 950DT，支持<br>Atlas A3 训练系列产品/Atlas A3 推理系列产品，支持<br>Atlas A2 训练系列产品/Atlas A2 推理系列产品，支持 |
| stmAttrType | 输入 | 属性类型。类型定义请参见[aclrtStreamAttr](24_数据类型及其操作接口.md#aclrtStreamAttr)。 |
| value | 输入 | 属性值。类型定义请参见[aclrtStreamAttrValue](24_数据类型及其操作接口.md#aclrtStreamAttrValue)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。

### 约束说明

-   溢出检测属性：调用该接口打开或关闭溢出检测开关后，仅对后续新下的任务生效，已下发的任务仍维持原样。
-   Failure Mode：不支持对Context默认Stream设置Failure Mode。


<br>
<br>
<br>



<a id="aclrtGetStreamAttribute"></a>

# aclrtGetStreamAttribute

```c
aclError aclrtGetStreamAttribute(aclrtStream stream, aclrtStreamAttr stmAttrType, aclrtStreamAttrValue *value)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

获取Stream属性值。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 指定Stream。类型定义请参见[aclrtStream](24_数据类型及其操作接口.md#aclrtStream)。<br>各产品型号对默认Stream（即该参数传入NULL）的支持情况不同，如下：<br>Ascend 950PR/Ascend 950DT，支持<br>Atlas A3 训练系列产品/Atlas A3 推理系列产品，支持<br>Atlas A2 训练系列产品/Atlas A2 推理系列产品，支持 |
| stmAttrType | 输入 | 属性类型。类型定义请参见[aclrtStreamAttr](24_数据类型及其操作接口.md#aclrtStreamAttr)。 |
| value | 输出 | 属性值。类型定义请参见[aclrtStreamAttrValue](24_数据类型及其操作接口.md#aclrtStreamAttrValue)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtActiveStream"></a>

# aclrtActiveStream

```c
aclError aclrtActiveStream(aclrtStream activeStream, aclrtStream stream)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

激活Stream。异步接口。

被激活的Stream上的任务与当前Stream上的任务并行执行。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| activeStream | 输入 | 待激活的Stream。类型定义请参见[aclrtStream](24_数据类型及其操作接口.md#aclrtStream)。<br>此处只支持与模型绑定过的Stream，绑定模型与Stream需调用[aclmdlRIBindStream](15_模型运行实例管理.md#aclmdlRIBindStream)接口。 |
| stream | 输入 | 执行激活任务的Stream。类型定义请参见[aclrtStream](24_数据类型及其操作接口.md#aclrtStream)。<br>此处只支持与模型绑定过的Stream，绑定模型与Stream需调用[aclmdlRIBindStream](15_模型运行实例管理.md#aclmdlRIBindStream)接口。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtSwitchStream"></a>

# aclrtSwitchStream

```c
aclError aclrtSwitchStream(void *leftValue, aclrtCondition cond, void *rightValue, aclrtCompareDataType dataType, aclrtStream trueStream, aclrtStream falseStream, aclrtStream stream)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

根据条件在Stream之间跳转。异步接口。

跳转成功后，只执行所跳转的Stream上的任务，当前Stream上的任务停止执行。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| leftValue | 输入 | 左值数据的Device内存地址。 |
| cond | 输入 | 左值数据与右值数据的比较条件。类型定义请参见[aclrtCondition](24_数据类型及其操作接口.md#aclrtCondition)。 |
| rightValue | 输入 | 右值数据的Device内存地址。 |
| dataType | 输入 | 左值数据、右值数据的数据类型。类型定义请参见[aclrtCompareDataType](24_数据类型及其操作接口.md#aclrtCompareDataType)。 |
| trueStream | 输入 | 根据cond处指定的条件，条件成立时，则执行trueStream上的任务。类型定义请参见[aclrtStream](24_数据类型及其操作接口.md#aclrtStream)。 |
| falseStream | 输入 | 预留参数，当前固定传NULL。<br>取值详见[aclrtStream](24_数据类型及其操作接口.md#aclrtStream)。 |
| stream | 输入 | 执行跳转任务的Stream。类型定义请参见[aclrtStream](24_数据类型及其操作接口.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtRegStreamStateCallback"></a>

# aclrtRegStreamStateCallback

```c
aclError aclrtRegStreamStateCallback(const char *regName, aclrtStreamStateCallback callback, void *args)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

注册Stream状态回调函数，不支持重复注册。

当Stream状态发生变化时（例如调用[aclrtCreateStream](#aclrtCreateStream)、[aclrtDestroyStream](#aclrtDestroyStream)等接口），Runtime模块会触发该回调函数的调用。此处的Stream包含显式创建的Stream以及默认Stream。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| regName | 输入 | 注册唯一名称，不能为空，输入保证字符串以\0结尾。 |
| callback | 输入 | 回调函数。若callback不为NULL，则表示注册回调函数；若为NULL，则表示取消注册回调函数。<br>回调函数的函数原型为：<br>typedef enum {<br>   ACL_RT_STREAM_STATE_CREATE_POST = 1,  // 调用create接口（例如aclrtCreateStream）之后<br>   ACL_RT_STREAM_STATE_DESTROY_PRE,  // 调用destroy接口（例如aclrtDestroyStream）之前<br>} aclrtStreamState;<br>typedef void (*aclrtStreamStateCallback)([aclrtStream](24_数据类型及其操作接口.md#aclrtStream) stm, aclrtStreamState state, void *args); |
| args | 输入 | 待传递给回调函数的用户数据的指针。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



# aclrtStreamStop

> 文档暂缺



<br>
<br>
<br>



<a id="acIrtStreamStop"></a>

# acIrtStreamStop

```c
aclError aclrtStreamStop(aclrtStream stream)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

仅停止指定Stream上的正在执行的任务，不清理任务。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 指定待停止任务的Stream。类型定义请参见[aclrtStream](24_数据类型及其操作接口.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。

### 约束说明

-   不支持使用[aclmdlRIBindStream](15_模型运行实例管理.md#aclmdlRIBindStream)接口来绑定模型运行实例的Stream。
-   不支持默认Stream（即stream参数传入NULL）。
-   对于Atlas A2 训练系列产品/Atlas A2 推理系列产品、Atlas A3 训练系列产品/Atlas A3 推理系列产品，该接口仅支持如下方式创建的Stream：调用[aclrtCreateStreamWithConfig](#aclrtCreateStreamWithConfig)接口，将flag设置为ACL\_STREAM\_DEVICE\_USE\_ONLY（表示该Stream仅在Device上调用）。


<br>
<br>
<br>



<a id="aclrtPersistentTaskClean"></a>

# aclrtPersistentTaskClean

```c
aclError aclrtPersistentTaskClean(aclrtStream stream)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

清理ACL\_STREAM\_PERSISTENT类型的Stream上的任务，适用于在不删除该类型Stream的情况下重新下发任务的场景。

ACL\_STREAM\_PERSISTENT类型的Stream需调用[aclrtCreateStreamWithConfig](#aclrtCreateStreamWithConfig)接口创建。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 指定Stream。类型定义请参见[aclrtStream](24_数据类型及其操作接口.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtStreamGetPriority"></a>

# aclrtStreamGetPriority

```c
aclError aclrtStreamGetPriority(aclrtStream stream, uint32_t *priority)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

查询指定Stream的优先级。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 指定Stream。类型定义请参见[aclrtStream](24_数据类型及其操作接口.md#aclrtStream)。<br>若此处传入NULL，则获取的是默认Stream的优先级。 |
| priority | 输出 | 优先级，数字越小代表优先级越高。<br>关于优先级的取值范围请参见[aclrtCreateStreamWithConfig](#aclrtCreateStreamWithConfig)接口中的priority参数说明。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtStreamGetFlags"></a>

# aclrtStreamGetFlags

```c
aclError aclrtStreamGetFlags(aclrtStream stream, uint32_t *flags)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

查询创建Stream时设置的flag标志。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 指定Stream。类型定义请参见[aclrtStream](24_数据类型及其操作接口.md#aclrtStream)。<br>若此处传入NULL，则获取的是默认Stream的flag。 |
| flags | 输出 | 指向查询到的flag值的指针。<br>关于flag值的说明请参见[aclrtCreateStreamWithConfig](#aclrtCreateStreamWithConfig)接口中的flag参数说明。若创建Stream时配置了多个flag，返回值为各flag按位或运算后的结果，例如配置了0x01U和0x02U，则返回0x03U；若创建Stream是没有配置flag，则返回0。<br>对于默认Stream，不同产品型号的flag值可能存在差异，应以本接口查询到的值为准。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。
