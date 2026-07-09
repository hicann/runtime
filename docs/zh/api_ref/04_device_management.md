# 4. Device管理

本章节描述 CANN Runtime 的设备管理接口，用于设备的设置、重置、查询、同步及 P2P 访问等操作。

- [`aclError aclrtSetDevice(int32_t deviceId)`](#aclrtSetDevice)：指定当前线程中用于运算的Device。在不同线程中支持调用aclrtSetDevice接口指定同一个Device用于运算。
- [`aclError aclrtResetDevice(int32_t deviceId)`](#aclrtResetDevice)：复位当前运算的Device，释放Device上的资源。
- [`aclError aclrtResetDeviceForce(int32_t deviceId)`](#aclrtResetDeviceForce)：复位当前运算的Device，释放Device上的资源。
- [`aclError aclrtGetDevice(int32_t *deviceId)`](#aclrtGetDevice)：获取当前正在使用的Device的ID。
- [`aclError aclrtGetRunMode(aclrtRunMode *runMode)`](#aclrtGetRunMode)：获取当前AI软件栈的运行模式。
- [`aclError aclrtSetTsDevice(aclrtTsId tsId)`](#aclrtSetTsDevice)：设置本次计算需要使用的Task Schedule。
- [`aclError aclrtGetDeviceCount(uint32_t *count)`](#aclrtGetDeviceCount)：获取可用Device的数量。
- [`aclError aclrtGetDeviceUtilizationRate(int32_t deviceId, aclrtUtilizationInfo *utilizationInfo)`](#aclrtGetDeviceUtilizationRate)：查询Device上Cube、Vector、AI CPU等的利用率。
- [`aclError aclrtQueryDeviceStatus(int32_t deviceId, aclrtDeviceStatus *deviceStatus)`](#aclrtQueryDeviceStatus)：查询Device状态是正常可用、还是异常不可用。
- [`const char *aclrtGetSocName()`](#aclrtGetSocName)：查询当前运行环境的AI处理器版本。
- [`aclError aclrtSetDeviceSatMode(aclrtFloatOverflowMode mode)`](#aclrtSetDeviceSatMode)：设置当前Device的浮点计算结果输出模式。
- [`aclError aclrtGetDeviceSatMode(aclrtFloatOverflowMode *mode)`](#aclrtGetDeviceSatMode)：查询当前Device的浮点计算结果输出模式。
- [`aclError aclrtDeviceCanAccessPeer(int32_t *canAccessPeer, int32_t deviceId, int32_t peerDeviceId)`](#aclrtDeviceCanAccessPeer)：查询Device之间是否支持数据交互。
- [`aclError aclrtDeviceEnablePeerAccess(int32_t peerDeviceId, uint32_t flags)`](#aclrtDeviceEnablePeerAccess)：开启当前Device与指定Device之间的数据交互。开启数据交互是Device级的。
- [`aclError aclrtDeviceDisablePeerAccess(int32_t peerDeviceId)`](#aclrtDeviceDisablePeerAccess)：关闭当前Device与指定Device之间的数据交互功能。关闭数据交互功能是Device级的。
- [`aclError aclrtDevicePeerAccessStatus(int32_t deviceId, int32_t peerDeviceId, int32_t *status)`](#aclrtDevicePeerAccessStatus)：查询两个Device之间的数据交互状态。
- [`aclError aclrtGetOverflowStatus(void *outputAddr, size_t outputSize, aclrtStream stream)`](#aclrtGetOverflowStatus)：获取当前Device下所有Stream上任务的溢出状态，并将状态值拷贝到用户申请的Device内存中。异步接口。
- [`aclError aclrtResetOverflowStatus(aclrtStream stream)`](#aclrtResetOverflowStatus)：清除当前Device下所有Stream上任务的溢出状态。异步接口。
- [`aclError aclrtSynchronizeDevice(void)`](#aclrtSynchronizeDevice)：阻塞当前线程，直到与当前线程绑定的Context所对应的Device完成运算。
- [`aclError aclrtSynchronizeDeviceWithTimeout(int32_t timeout)`](#aclrtSynchronizeDeviceWithTimeout)：阻塞当前线程，直到与当前线程绑定的Context所对应的Device完成运算。
- [`aclError aclrtGetDeviceInfo(uint32_t deviceId, aclrtDevAttr attr, int64_t *value)`](#aclrtGetDeviceInfo)：获取指定Device的信息。
- [`aclError aclrtDeviceGetStreamPriorityRange(int32_t *leastPriority, int32_t *greatestPriority)`](#aclrtDeviceGetStreamPriorityRange)：查询硬件支持的Stream最低、最高优先级。
- [`aclError aclrtGetDeviceCapability(int32_t deviceId, aclrtDevFeatureType devFeatureType, int32_t *value)`](#aclrtGetDeviceCapability)：查询支持的特性信息。
- [`aclError aclrtGetDevicesTopo(uint32_t deviceId, uint32_t otherDeviceId, uint64_t *value)`](#aclrtGetDevicesTopo)：获取两个Device之间的网络拓扑关系。
- [`aclError aclrtRegDeviceStateCallback(const char *regName, aclrtDeviceStateCallback callback, void *args)`](#aclrtRegDeviceStateCallback)：注册Device状态回调函数，不支持重复注册。
- [`aclError aclrtGetLogicDevIdByUserDevId(const int32_t userDevid, int32_t *const logicDevId)`](#aclrtGetLogicDevIdByUserDevId)：根据用户设备ID获取对应的逻辑设备ID。
- [`aclError aclrtGetUserDevIdByLogicDevId(const int32_t logicDevId, int32_t *const userDevid)`](#aclrtGetUserDevIdByLogicDevId)：根据逻辑设备ID获取对应的用户设备ID。
- [`aclError aclrtGetLogicDevIdByPhyDevId(const int32_t phyDevId, int32_t *const logicDevId)`](#aclrtGetLogicDevIdByPhyDevId)：根据物理设备ID获取对应的逻辑设备ID。
- [`aclError aclrtGetPhyDevIdByLogicDevId(const int32_t logicDevId, int32_t *const phyDevId)`](#aclrtGetPhyDevIdByLogicDevId)：根据逻辑设备ID获取对应的物理设备ID。
- [`aclError aclrtGetUserDevIdByPhyDevId(const int32_t phyDevId, int32_t *const userDevId)`](#aclrtGetUserDevIdByPhyDevId)：根据物理设备ID获取对应的用户设备ID。
- [`aclError aclrtGetPhyDevIdByUserDevId(const int32_t userDevId, int32_t *const phyDevId)`](#aclrtGetPhyDevIdByUserDevId)：根据用户设备ID获取对应的物理设备ID。
- [`aclError aclrtDeviceGetUuid(int32_t deviceId, aclrtUuid *uuid)`](#aclrtDeviceGetUuid)：获取Device的唯一标识UUID（Universally Unique Identifier）。
- [`aclError aclrtDeviceGetBareTgid(int32_t *pid)`](#aclrtDeviceGetBareTgid)：获取当前进程的进程ID。
- [`aclError aclrtDeviceGetHostAtomicCapabilities(uint32_t* capabilities, const aclrtAtomicOperation* operations, const uint32_t count, int32_t deviceId)`](#aclrtDeviceGetHostAtomicCapabilities)：查询指定Device与Host之间支持的原子操作详情。
- [`aclError aclrtDeviceGetP2PAtomicCapabilities(uint32_t* capabilities, const aclrtAtomicOperation* operations, const uint32_t count, int32_t srcDeviceId, int32_t dstDeviceId)`](#aclrtDeviceGetP2PAtomicCapabilities)：查询一个AI Server内两个Device之间支持的原子操作详情。AI Server通常是多个Device组成的服务器形态的统称。

<a id="aclrtSetDevice"></a>

## aclrtSetDevice

```c
aclError aclrtSetDevice(int32_t deviceId)
```

### 产品支持情况

<!-- npu="950" id295 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id295 -->
<!-- npu="A3" id296 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id296 -->
<!-- npu="910b" id297 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id297 -->
<!-- npu="310b" id298 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id298 -->
<!-- npu="310p" id299 -->
- Atlas 推理系列产品：支持
<!-- end id299 -->
<!-- npu="910" id300 -->
- Atlas 训练系列产品：支持
<!-- end id300 -->
<!-- npu="IPV350" id301 -->
- IPV350：支持
<!-- end id301 -->
<!-- @ref: runtime/res/docs/zh/api_ref/04_device_management_res.md#id1 -->

### 功能说明

指定当前线程中用于运算的Device。在不同线程中支持调用aclrtSetDevice接口指定同一个Device用于运算。

<!-- npu="950,A3,910b,910,310p,310b" id1 -->
多Device场景下，可在进程中通过aclrtSetDevice接口切换到其它Device。
<!-- end id1 -->

调用本接口会隐式创建默认Context，该默认Context中包含一个默认Stream。在同一个进程的多个线程中，如果调用aclrtSetDevice接口并指定相同的Device用于计算，那么这些线程将共享同一个默认Context。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| deviceId | 输入 | Device ID。<br>用户调用[aclrtGetDeviceCount](#aclrtGetDeviceCount)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)] |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

<!-- npu="IPV350" id2 -->
IPV350上不支持默认Comtext和默认Stream。
<!-- end id2 -->

调用aclrtSetDevice接口指定运算的Device后，若不使用Device上的资源时，可调用[aclrtResetDevice](#aclrtResetDevice)或[aclrtResetDeviceForce](#aclrtResetDeviceForce)接口及时释放本进程使用的Device资源（若不调用Reset接口，进程退出时也会释放本进程使用的Device资源）：

- 若调用[aclrtResetDevice](#aclrtResetDevice)接口释放Device资源：

  aclrtResetDevice接口内部涉及引用计数的实现，建议aclrtResetDevice接口与[aclrtSetDevice](#aclrtSetDevice)接口配对使用，aclrtSetDevice接口每被调用一次，则引用计数加一，aclrtResetDevice接口每被调用一次，则该引用计数减一，当引用计数减到0时，才会真正释放Device上的资源。

- 若调用[aclrtResetDeviceForce](#aclrtResetDeviceForce)接口释放Device资源：

  aclrtResetDeviceForce接口可与aclrtSetDevice接口配对使用，也可不与aclrtSetDevice接口配对使用，若不配对使用，一个进程中，针对同一个Device，调用一次或多次aclrtSetDevice接口后，仅需调用一次aclrtResetDeviceForce接口可释放Device上的资源。

<br>
<br>
<br>

<a id="aclrtResetDevice"></a>

## aclrtResetDevice

```c
aclError aclrtResetDevice(int32_t deviceId)
```

### 产品支持情况

<!-- npu="950" id288 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id288 -->
<!-- npu="A3" id289 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id289 -->
<!-- npu="910b" id290 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id290 -->
<!-- npu="310b" id291 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id291 -->
<!-- npu="310p" id292 -->
- Atlas 推理系列产品：支持
<!-- end id292 -->
<!-- npu="910" id293 -->
- Atlas 训练系列产品：支持
<!-- end id293 -->
<!-- npu="IPV350" id294 -->
- IPV350：支持
<!-- end id294 -->
<!-- @ref: runtime/res/docs/zh/api_ref/04_device_management_res.md#id2 -->

### 功能说明

复位当前运算的Device，释放Device上的资源。释放的资源包括默认Context、默认Stream以及默认Context下创建的所有Stream。若默认Context或默认Stream下的任务还未完成，系统会等待任务完成后再释放。

aclrtResetDevice接口内部涉及引用计数的实现，建议aclrtResetDevice接口与[aclrtSetDevice](#aclrtSetDevice)接口配对使用，aclrtSetDevice接口每被调用一次，则引用计数加一，aclrtResetDevice接口每被调用一次，则该引用计数减一，当引用计数减到0时，才会真正释放Device上的资源。

如果多次调用aclrtSetDevice接口而不调用aclrtResetDevice接口释放本线程使用的Device资源，进程退出时也会释放本进程使用的Device资源。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| deviceId | 输入 | Device ID。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

<!-- npu="IPV350" id3 -->
IPV350上不支持默认Comtext和默认Stream。
<!-- end id3 -->

若要复位的Device上存在显式创建的Context、Stream、Event，在复位前，建议遵循如下接口调用顺序，否则可能会导致业务异常。

**接口调用顺序**：调用[aclrtDestroyEvent](07_event_management.md#aclrtDestroyEvent)接口释放Event/调用[aclrtDestroyStream](06_stream_management.md#aclrtDestroyStream)接口释放显式创建的Stream**--\>**调用[aclrtDestroyContext](05_context_management.md#aclrtDestroyContext)释放显式创建的Context**--\>**调用aclrtResetDevice接口

<br>
<br>
<br>

<a id="aclrtResetDeviceForce"></a>

## aclrtResetDeviceForce

```c
aclError aclrtResetDeviceForce(int32_t deviceId)
```

### 产品支持情况

<!-- npu="950" id1849 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1849 -->
<!-- npu="A3" id1850 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1850 -->
<!-- npu="910b" id1851 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1851 -->
<!-- npu="310b" id1852 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1852 -->
<!-- npu="310p" id1853 -->
- Atlas 推理系列产品：支持
<!-- end id1853 -->
<!-- npu="910" id1854 -->
- Atlas 训练系列产品：支持
<!-- end id1854 -->
<!-- npu="IPV350" id1855 -->
- IPV350：支持
<!-- end id1855 -->
<!-- @ref: runtime/res/docs/zh/api_ref/04_device_management_res.md#id3 -->

### 功能说明

复位当前运算的Device，释放Device上的资源。释放的资源包括默认Context、默认Stream以及默认Context下创建的所有Stream。若默认Context或默认Stream下的任务还未完成，系统会等待任务完成后再释放。

aclrtResetDeviceForce接口可与aclrtSetDevice接口配对使用，也可不与aclrtSetDevice接口配对使用，若不配对使用，一个进程中，针对同一个Device，调用一次或多次aclrtSetDevice接口后，仅需调用一次aclrtResetDeviceForce接口可释放Device上的资源。

```text
// 与aclrtSetDevice接口配对使用：
aclrtSetDevice(1) -> aclrtResetDeviceForce(1) -> aclrtSetDevice(1) -> aclrtResetDeviceForce(1)
 
// 与aclrtSetDevice接口不配对使用：
aclrtSetDevice(1) -> aclrtSetDevice(1) -> aclrtResetDeviceForce(1)
```

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| deviceId | 输入 | Device ID。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

<!-- npu="IPV350" id4 -->
- IPV350上不支持默认Comtext和默认Stream。
<!-- end id4 -->

- 多线程场景下，针对同一个Device，如果每个线程中都调用[aclrtSetDevice](#aclrtSetDevice)接口、aclrtResetDeviceForce接口，如下所示，线程2中的aclrtResetDeviceForce接口会返回报错，因为线程1中aclrtResetDeviceForce接口已经释放了Device 1的资源：

    ```text
    时间线 ----------------------------------------------------------------------------->
    线程1：aclrtSetDevice(1)           aclrtResetDeviceForce(1)
    线程2：aclrtSetDevice(1)                                   aclrtResetDeviceForce(1)
    ```

    多线程场景下，正确方式是应在线程执行的最后，调用一次aclrtResetDeviceForce释放Device资源，如下所示：

    ```text
    时间线 ----------------------------------------------------------------------------->
    线程1：aclrtSetDevice(1)    
    线程2：aclrtSetDevice(1)                                   aclrtResetDeviceForce(1)
    ```

- [aclrtResetDevice](#aclrtResetDevice)接口与aclrtResetDeviceForce接口可以混用，但混用时，若两个Reset接口的调用次数、调用顺序不对，接口会返回报错。

    ```text
    # 混用时的正确方式：
    # 两个Reset接口都分别与Set接口配对使用，且aclrtResetDeviceForce接口在aclrtResetDevice接口之后
    aclrtSetDevice(1) -> aclrtResetDevice(1) -> aclrtSetDevice(1) -> aclrtResetDeviceForce(1)
    aclrtSetDevice(1) -> aclrtSetDevice(1) -> aclrtResetDevice(1) -> aclrtResetDeviceForce(1)
    
    # 混用时的错误方式：
    # aclrtResetDevice接口内部涉及引用计数的实现，当aclrtResetDevice接口每被调用一次，则该引用计数减1，当引用计数减到0时，会真正释放Device上的资源，此时再调用aclrtResetDevice或aclrtResetDeviceForce接口都会报错
    aclrtSetDevice(1) -> aclrtSetDevice(1) -> aclrtResetDevice(1)-->aclrtResetDevice(1)-->aclrtResetDeviceForce(1)
    aclrtSetDevice(1) -> aclrtSetDevice(1) -> aclrtResetDevice(1)-->aclrtResetDeviceForce(1)-->aclrtResetDeviceForce(1)
    # aclrtResetDeviceForce接口在aclrtResetDevice接口之后，否则接口返回报错
    aclrtSetDevice(1) -> aclrtSetDevice(1) -> aclrtResetDeviceForce(1)-->aclrtResetDevice(1)
    ```

<br>
<br>
<br>

<a id="aclrtGetDevice"></a>

## aclrtGetDevice

```c
aclError aclrtGetDevice(int32_t *deviceId)
```

### 产品支持情况

<!-- npu="950" id3242 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3242 -->
<!-- npu="A3" id3243 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3243 -->
<!-- npu="910b" id3244 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3244 -->
<!-- npu="310b" id3245 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id3245 -->
<!-- npu="310p" id3246 -->
- Atlas 推理系列产品：支持
<!-- end id3246 -->
<!-- npu="910" id3247 -->
- Atlas 训练系列产品：支持
<!-- end id3247 -->
<!-- npu="IPV350" id3248 -->
- IPV350：支持
<!-- end id3248 -->
<!-- @ref: runtime/res/docs/zh/api_ref/04_device_management_res.md#id4 -->

### 功能说明

获取当前正在使用的Device的ID。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| deviceId | 输出 | Device ID的指针。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

如果没有提前指定计算设备（例如调用[aclrtSetDevice](#aclrtSetDevice)接口），则调用aclrtGetDevice接口时，返回错误。

<br>
<br>
<br>

<a id="aclrtGetRunMode"></a>

## aclrtGetRunMode

```c
aclError aclrtGetRunMode(aclrtRunMode *runMode)
```

### 产品支持情况

<!-- npu="950" id596 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id596 -->
<!-- npu="A3" id597 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id597 -->
<!-- npu="910b" id598 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id598 -->
<!-- npu="310b" id599 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id599 -->
<!-- npu="310p" id600 -->
- Atlas 推理系列产品：支持
<!-- end id600 -->
<!-- npu="910" id601 -->
- Atlas 训练系列产品：支持
<!-- end id601 -->
<!-- npu="IPV350" id602 -->
- IPV350：支持
<!-- end id602 -->
<!-- @ref: runtime/res/docs/zh/api_ref/04_device_management_res.md#id5 -->

### 功能说明

获取当前AI软件栈的运行模式。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| runMode | 输出 | 运行模式的指针。类型定义请参见[aclrtRunMode](25-02_Enumerations.md#aclrtRunMode)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtSetTsDevice"></a>

## aclrtSetTsDevice

```c
aclError aclrtSetTsDevice(aclrtTsId tsId)
```

### 产品支持情况

<!-- npu="950" id3046 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3046 -->
<!-- npu="A3" id3047 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3047 -->
<!-- npu="910b" id3048 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3048 -->
<!-- npu="310b" id3049 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id3049 -->
<!-- npu="310p" id3050 -->
- Atlas 推理系列产品：支持
<!-- end id3050 -->
<!-- npu="910" id3051 -->
- Atlas 训练系列产品：支持
<!-- end id3051 -->
<!-- npu="IPV350" id3052 -->
- IPV350：不支持
<!-- end id3052 -->
<!-- @ref: runtime/res/docs/zh/api_ref/04_device_management_res.md#id6 -->

### 功能说明

设置本次计算需要使用的Task Schedule。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| tsId | 输入 | 指定本次计算需要使用的Task Schedule。如果AI处理器中只有AI CORE Task Schedule，没有VECTOR Core Task Schedule，则设置该参数无效，默认使用AI CORE Task Schedule。 |

aclrtTsId的定义如下：

```c
typedef enum aclrtTsId {
    ACL_TS_ID_AICORE  = 0,  // 使用AI CORE Task Schedule
    ACL_TS_ID_AIVECTOR = 1, // 使用VECTOR Core Task Schedule
    ACL_TS_ID_RESERVED = 2, 
} aclrtTsId;
```

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtGetDeviceCount"></a>

## aclrtGetDeviceCount

```c
aclError aclrtGetDeviceCount(uint32_t *count)
```

### 产品支持情况

<!-- npu="950" id1653 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1653 -->
<!-- npu="A3" id1654 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1654 -->
<!-- npu="910b" id1655 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1655 -->
<!-- npu="310b" id1656 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1656 -->
<!-- npu="310p" id1657 -->
- Atlas 推理系列产品：支持
<!-- end id1657 -->
<!-- npu="910" id1658 -->
- Atlas 训练系列产品：支持
<!-- end id1658 -->
<!-- npu="IPV350" id1659 -->
- IPV350：支持
<!-- end id1659 -->
<!-- @ref: runtime/res/docs/zh/api_ref/04_device_management_res.md#id7 -->

### 功能说明

获取可用Device的数量。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| count | 输出 | Device数量的指针。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtGetDeviceUtilizationRate"></a>

## aclrtGetDeviceUtilizationRate

```c
aclError aclrtGetDeviceUtilizationRate(int32_t deviceId, aclrtUtilizationInfo *utilizationInfo)
```

### 产品支持情况

<!-- npu="950" id393 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id393 -->
<!-- npu="A3" id394 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id394 -->
<!-- npu="910b" id395 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id395 -->
<!-- npu="310b" id396 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id396 -->
<!-- npu="310p" id397 -->
- Atlas 推理系列产品：支持
<!-- end id397 -->
<!-- npu="910" id398 -->
- Atlas 训练系列产品：支持
<!-- end id398 -->
<!-- npu="IPV350" id399 -->
- IPV350：不支持
<!-- end id399 -->
<!-- @ref: runtime/res/docs/zh/api_ref/04_device_management_res.md#id8 -->

### 功能说明

查询Device上Cube、Vector、AI CPU等的利用率。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| deviceId | 输入 | Device ID。<br>用户调用[aclrtGetDeviceCount](#aclrtGetDeviceCount)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)] |
| utilizationInfo | 输出 | 利用率信息结构体指针。类型定义定参见[aclrtUtilizationInfo](25-04_Structs.md#aclrtUtilizationInfo)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

- 当使用本接口查询Vector利用率时，如果查询结果为-1，则表示Vector不存在。
- 当前版本不支持查询Device内存利用率，若通过本接口查询内存利用率，返回的利用率为-1。
- 开启Profiling功能时，不支持调用本接口查询利用率，接口返回值无实际意义。
<!-- npu="910b,910,310p" id5 -->
- 昇腾虚拟化实例场景下，不支持调用本接口查询利用率，接口返回值无实际意义。
<!-- end id5 -->

<br>
<br>
<br>

<a id="aclrtQueryDeviceStatus"></a>

## aclrtQueryDeviceStatus

```c
aclError aclrtQueryDeviceStatus(int32_t deviceId, aclrtDeviceStatus *deviceStatus)
```

### 产品支持情况

<!-- npu="950" id1737 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1737 -->
<!-- npu="A3" id1738 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1738 -->
<!-- npu="910b" id1739 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1739 -->
<!-- npu="310b" id1740 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1740 -->
<!-- npu="310p" id1741 -->
- Atlas 推理系列产品：支持
<!-- end id1741 -->
<!-- npu="910" id1742 -->
- Atlas 训练系列产品：支持
<!-- end id1742 -->
<!-- npu="IPV350" id1743 -->
- IPV350：不支持
<!-- end id1743 -->
<!-- @ref: runtime/res/docs/zh/api_ref/04_device_management_res.md#id9 -->

### 功能说明

查询Device状态是正常可用、还是异常不可用。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| deviceId | 输入 | Device ID。<br>用户调用[aclrtGetDeviceCount](#aclrtGetDeviceCount)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)] |
| deviceStatus | 输出 | Device状态。类型定义请参见[aclrtDeviceStatus](25-02_Enumerations.md#aclrtDeviceStatus)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtGetSocName"></a>

## aclrtGetSocName

```c
const char *aclrtGetSocName()
```

### 产品支持情况

<!-- npu="950" id2640 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2640 -->
<!-- npu="A3" id2641 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2641 -->
<!-- npu="910b" id2642 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2642 -->
<!-- npu="310b" id2643 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2643 -->
<!-- npu="310p" id2644 -->
- Atlas 推理系列产品：支持
<!-- end id2644 -->
<!-- npu="910" id2645 -->
- Atlas 训练系列产品：支持
<!-- end id2645 -->
<!-- npu="IPV350" id2646 -->
- IPV350：不支持
<!-- end id2646 -->
<!-- @ref: runtime/res/docs/zh/api_ref/04_device_management_res.md#id10 -->

### 功能说明

查询当前运行环境的AI处理器版本。

### 参数说明

无

### 返回值说明

返回AI处理器版本字符串的指针。

如果通过该接口获取芯片版本失败，则返回空指针；如果运行环境上Device数量大于1，则固定返回Device 0的AI处理器版本名称。

<br>
<br>
<br>

<a id="aclrtSetDeviceSatMode"></a>

## aclrtSetDeviceSatMode

```c
aclError aclrtSetDeviceSatMode(aclrtFloatOverflowMode mode)
```

### 产品支持情况

<!-- npu="950" id3004 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3004 -->
<!-- npu="A3" id3005 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3005 -->
<!-- npu="910b" id3006 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3006 -->
<!-- npu="310b" id3007 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id3007 -->
<!-- npu="310p" id3008 -->
- Atlas 推理系列产品：支持
<!-- end id3008 -->
<!-- npu="910" id3009 -->
- Atlas 训练系列产品：支持
<!-- end id3009 -->
<!-- npu="IPV350" id3010 -->
- IPV350：不支持
<!-- end id3010 -->
<!-- @ref: runtime/res/docs/zh/api_ref/04_device_management_res.md#id11 -->

### 功能说明

设置当前Device的浮点计算结果输出模式。

调用该接口成功后，后续在该Device上新创建的Stream按设置的模式生效，对之前已创建的Stream不生效。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| mode | 输入 | 设置浮点计算结果输出模式。类型定义请参见[aclrtFloatOverflowMode](25-02_Enumerations.md#aclrtFloatOverflowMode)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtGetDeviceSatMode"></a>

## aclrtGetDeviceSatMode

```c
aclError aclrtGetDeviceSatMode(aclrtFloatOverflowMode *mode)
```

### 产品支持情况

<!-- npu="950" id1051 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1051 -->
<!-- npu="A3" id1052 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1052 -->
<!-- npu="910b" id1053 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1053 -->
<!-- npu="310b" id1054 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1054 -->
<!-- npu="310p" id1055 -->
- Atlas 推理系列产品：支持
<!-- end id1055 -->
<!-- npu="910" id1056 -->
- Atlas 训练系列产品：支持
<!-- end id1056 -->
<!-- npu="IPV350" id1057 -->
- IPV350：不支持
<!-- end id1057 -->
<!-- @ref: runtime/res/docs/zh/api_ref/04_device_management_res.md#id12 -->

### 功能说明

查询当前Device的浮点计算结果输出模式。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| mode | 输出 | 获取浮点计算结果输出模式。类型定义请参见[aclrtFloatOverflowMode](25-02_Enumerations.md#aclrtFloatOverflowMode)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtDeviceCanAccessPeer"></a>

## aclrtDeviceCanAccessPeer

```c
aclError aclrtDeviceCanAccessPeer(int32_t *canAccessPeer, int32_t deviceId, int32_t peerDeviceId)
```

### 产品支持情况

<!-- npu="950" id2493 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2493 -->
<!-- npu="A3" id2494 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2494 -->
<!-- npu="910b" id2495 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2495 -->
<!-- npu="310b" id2496 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id2496 -->
<!-- npu="310p" id2497 -->
- Atlas 推理系列产品：支持
<!-- end id2497 -->
<!-- npu="910" id2498 -->
- Atlas 训练系列产品：支持
<!-- end id2498 -->
<!-- npu="IPV350" id2499 -->
- IPV350：不支持
<!-- end id2499 -->
<!-- @ref: runtime/res/docs/zh/api_ref/04_device_management_res.md#id13 -->

### 功能说明

查询Device之间是否支持数据交互。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| canAccessPeer | 输出 | 是否支持数据交互，1表示支持，0表示不支持。 |
| deviceId | 输入 | 指定Device的ID，不能与peerDeviceId参数值相同。<br>用户调用[aclrtGetDeviceCount](#aclrtGetDeviceCount)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)] |
| peerDeviceId | 输入 | 指定Device的ID，不能与deviceId参数值相同。<br>用户调用[aclrtGetDeviceCount](#aclrtGetDeviceCount)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)] |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

- 仅支持物理机和容器场景；
- 仅支持同一个PCIe Switch内Device之间的数据交互。AI Server场景下，虽然是跨PCIe Switch，但也支持Device之间的数据交互。
- 仅支持同一个物理机或容器内的Device之间的数据交互操作。
- 仅支持同一个进程内、线程间的Device之间的数据交互，不支持不同进程间Device之间的数据交互。
<!-- npu="310p" id6 -->
- Atlas 推理系列产品，Control CPU开放形态下，应用程序运行在Device的Control CPU上时，该接口不支持Device之间的数据交互。
<!-- end id6 -->

<br>
<br>
<br>

<a id="aclrtDeviceEnablePeerAccess"></a>

## aclrtDeviceEnablePeerAccess

```c
aclError aclrtDeviceEnablePeerAccess(int32_t peerDeviceId, uint32_t flags)
```

### 产品支持情况

<!-- npu="950" id2269 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2269 -->
<!-- npu="A3" id2270 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2270 -->
<!-- npu="910b" id2271 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2271 -->
<!-- npu="310b" id2272 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id2272 -->
<!-- npu="310p" id2273 -->
- Atlas 推理系列产品：支持
<!-- end id2273 -->
<!-- npu="910" id2274 -->
- Atlas 训练系列产品：支持
<!-- end id2274 -->
<!-- npu="IPV350" id2275 -->
- IPV350：不支持
<!-- end id2275 -->
<!-- @ref: runtime/res/docs/zh/api_ref/04_device_management_res.md#id14 -->

### 功能说明

开启当前Device与指定Device之间的数据交互。开启数据交互是Device级的。

调用本接口开启Device之间的数据交互是单向的。例如，当前Device ID为0，调用aclrtDeviceEnablePeerAccess接口指定Device ID为1后，仅Device 0到Device 1方向的数据交互是可行的。若要启用Device 1到Device 0方向的数据交互，则需将当前Device切换至Device 1，并再次调用aclrtDeviceEnablePeerAccess接口指定Device ID 0，此时Device 1到Device 0方向的数据交互才能实现。

可提前调用[aclrtDeviceCanAccessPeer](#aclrtDeviceCanAccessPeer)接口查询当前Device与指定Device之间能否进行数据交互。开启Device间的数据交互功能后，若想关闭该功能，可调用[aclrtDeviceDisablePeerAccess](#aclrtDeviceDisablePeerAccess)接口。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| peerDeviceId | 输入 | 指定Device ID，该ID不能与当前Device的ID相同。<br>用户调用[aclrtGetDeviceCount](#aclrtGetDeviceCount)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)] |
| flags | 输入 | 保留参数，当前必须设置为0。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<!-- npu="310p" id7 -->
## 约束说明

Atlas 推理系列产品，Control CPU开放形态下，应用程序运行在Device的Control CPU上时，该接口不支持Device之间的数据交互。
<!-- end id7 -->

<br>
<br>
<br>

<a id="aclrtDeviceDisablePeerAccess"></a>

## aclrtDeviceDisablePeerAccess

```c
aclError aclrtDeviceDisablePeerAccess(int32_t peerDeviceId)
```

### 产品支持情况

<!-- npu="950" id2962 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2962 -->
<!-- npu="A3" id2963 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2963 -->
<!-- npu="910b" id2964 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2964 -->
<!-- npu="310b" id2965 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id2965 -->
<!-- npu="310p" id2966 -->
- Atlas 推理系列产品：支持
<!-- end id2966 -->
<!-- npu="910" id2967 -->
- Atlas 训练系列产品：支持
<!-- end id2967 -->
<!-- npu="IPV350" id2968 -->
- IPV350：不支持
<!-- end id2968 -->
<!-- @ref: runtime/res/docs/zh/api_ref/04_device_management_res.md#id15 -->

### 功能说明

关闭当前Device与指定Device之间的数据交互功能。关闭数据交互功能是Device级的。

调用[aclrtDeviceEnablePeerAccess](#aclrtDeviceEnablePeerAccess)接口开启当前Device与指定Device之间的数据交互后，可调用aclrtDeviceDisablePeerAccess接口关闭数据交互功能。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| peerDeviceId | 输入 | Device ID，该ID不能与当前Device的ID相同。<br>用户调用[aclrtGetDeviceCount](#aclrtGetDeviceCount)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)] |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<!-- npu="310p" id8 -->
## 约束说明

Atlas 推理系列产品，Control CPU开放形态下，应用程序运行在Device的Control CPU上时，该接口不支持Device之间的数据交互。
<!-- end id8 -->

<br>
<br>
<br>

<a id="aclrtDevicePeerAccessStatus"></a>

## aclrtDevicePeerAccessStatus

```c
aclError aclrtDevicePeerAccessStatus(int32_t deviceId, int32_t peerDeviceId, int32_t *status)
```

### 产品支持情况

<!-- npu="950" id2955 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2955 -->
<!-- npu="A3" id2956 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2956 -->
<!-- npu="910b" id2957 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2957 -->
<!-- npu="310b" id2958 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2958 -->
<!-- npu="310p" id2959 -->
- Atlas 推理系列产品：支持
<!-- end id2959 -->
<!-- npu="910" id2960 -->
- Atlas 训练系列产品：支持
<!-- end id2960 -->
<!-- npu="IPV350" id2961 -->
- IPV350：不支持
<!-- end id2961 -->
<!-- @ref: runtime/res/docs/zh/api_ref/04_device_management_res.md#id16 -->

### 功能说明

查询两个Device之间的数据交互状态。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| deviceId | 输入 | 指定Device的ID。<br>用户调用[aclrtGetDeviceCount](#aclrtGetDeviceCount)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)] |
| peerDeviceId | 输入 | 指定Device的ID。<br>用户调用[aclrtGetDeviceCount](#aclrtGetDeviceCount)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)] |
| status | 输出 | 设备状态。0表示未开启数据交互；1表示已开启数据交互。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

该接口仅可用于查询取值范围内两个Device ID对应设备的数据交互状态。若传入的Device ID超出[0, (可用的Device数量-1)]取值区间，接口查询结果为0或直接返回错误码ACL_ERROR_RT_PARAM_INVALID。

<br>
<br>
<br>

<a id="aclrtGetOverflowStatus"></a>

## aclrtGetOverflowStatus

```c
aclError aclrtGetOverflowStatus(void *outputAddr, size_t outputSize, aclrtStream stream)
```

### 产品支持情况

<!-- npu="950" id1135 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1135 -->
<!-- npu="A3" id1136 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1136 -->
<!-- npu="910b" id1137 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1137 -->
<!-- npu="310b" id1138 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1138 -->
<!-- npu="310p" id1139 -->
- Atlas 推理系列产品：支持
<!-- end id1139 -->
<!-- npu="910" id1140 -->
- Atlas 训练系列产品：支持
<!-- end id1140 -->
<!-- npu="IPV350" id1141 -->
- IPV350：不支持
<!-- end id1141 -->
<!-- @ref: runtime/res/docs/zh/api_ref/04_device_management_res.md#id17 -->

### 功能说明

获取当前Device下所有Stream上任务的溢出状态，并将状态值拷贝到用户申请的Device内存中。异步接口。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| outputAddr | 输入&输出 | 用户申请的Device内存，例如通过aclrtMalloc接口申请。 |
| outputSize | 输入 | 需申请的Device内存大小，单位Byte，固定大小为64Byte。 |
| stream | 输入 | 指定Stream，用于下发溢出状态查询任务。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<!-- npu="950,A3,910b" id9 -->
### 约束说明

对于Ascend 950PR/Ascend 950DT、Atlas A3 训练系列产品/Atlas A3 推理系列产品、Atlas A2 训练系列产品/Atlas A2 推理系列产品，调用本接口查询出来的溢出状态是进程级别的。
<!-- end id9 -->

<br>
<br>
<br>

<a id="aclrtResetOverflowStatus"></a>

## aclrtResetOverflowStatus

```c
aclError aclrtResetOverflowStatus(aclrtStream stream)
```

### 产品支持情况

<!-- npu="950" id2276 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2276 -->
<!-- npu="A3" id2277 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2277 -->
<!-- npu="910b" id2278 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2278 -->
<!-- npu="310b" id2279 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2279 -->
<!-- npu="310p" id2280 -->
- Atlas 推理系列产品：支持
<!-- end id2280 -->
<!-- npu="910" id2281 -->
- Atlas 训练系列产品：支持
<!-- end id2281 -->
<!-- npu="IPV350" id2282 -->
- IPV350：不支持
<!-- end id2282 -->
<!-- @ref: runtime/res/docs/zh/api_ref/04_device_management_res.md#id18 -->

### 功能说明

清除当前Device下所有Stream上任务的溢出状态。异步接口。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 指定Stream，用于下发溢出状态复位任务。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<!-- npu="950,A3,910b" id10 -->
### 约束说明

对于Ascend 950PR/Ascend 950DT、Atlas A3 训练系列产品/Atlas A3 推理系列产品、Atlas A2 训练系列产品/Atlas A2 推理系列产品，调用本接口清除的溢出状态是进程级别的。
<!-- end id10 -->

<br>
<br>
<br>

<a id="aclrtSynchronizeDevice"></a>

## aclrtSynchronizeDevice

```c
aclError aclrtSynchronizeDevice(void)
```

### 产品支持情况

<!-- npu="950" id1268 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1268 -->
<!-- npu="A3" id1269 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1269 -->
<!-- npu="910b" id1270 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1270 -->
<!-- npu="310b" id1271 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1271 -->
<!-- npu="310p" id1272 -->
- Atlas 推理系列产品：支持
<!-- end id1272 -->
<!-- npu="910" id1273 -->
- Atlas 训练系列产品：支持
<!-- end id1273 -->
<!-- npu="IPV350" id1274 -->
- IPV350：不支持
<!-- end id1274 -->
<!-- @ref: runtime/res/docs/zh/api_ref/04_device_management_res.md#id19 -->

### 功能说明

阻塞当前线程，直到与当前线程绑定的Context所对应的Device完成运算。

### 参数说明

无

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtSynchronizeDeviceWithTimeout"></a>

## aclrtSynchronizeDeviceWithTimeout

```c
aclError aclrtSynchronizeDeviceWithTimeout(int32_t timeout)
```

### 产品支持情况

<!-- npu="950" id2367 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2367 -->
<!-- npu="A3" id2368 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2368 -->
<!-- npu="910b" id2369 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2369 -->
<!-- npu="310b" id2370 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2370 -->
<!-- npu="310p" id2371 -->
- Atlas 推理系列产品：支持
<!-- end id2371 -->
<!-- npu="910" id2372 -->
- Atlas 训练系列产品：支持
<!-- end id2372 -->
<!-- npu="IPV350" id2373 -->
- IPV350：不支持
<!-- end id2373 -->
<!-- @ref: runtime/res/docs/zh/api_ref/04_device_management_res.md#id20 -->

### 功能说明

阻塞当前线程，直到与当前线程绑定的Context所对应的Device完成运算。该接口是在[aclrtSynchronizeDevice](#aclrtSynchronizeDevice)接口基础上进行了增强，支持用户设置超时时间，当应用程序异常时可根据所设置的超时时间自行退出，超时退出时本接口返回ACL\_ERROR\_RT\_STREAM\_SYNC\_TIMEOUT。

多Device场景下，调用该接口等待的是当前Context对应的Device。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| timeout | 输入 | 接口的超时时间。<br>取值说明如下：<br><br>  - -1：表示永久等待，和接口[aclrtSynchronizeDevice](#aclrtSynchronizeDevice)功能一样；<br>  - >0：配置具体的超时时间，单位是毫秒。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtGetDeviceInfo"></a>

## aclrtGetDeviceInfo

```c
aclError aclrtGetDeviceInfo(uint32_t deviceId, aclrtDevAttr attr, int64_t *value)
```

### 产品支持情况

<!-- npu="950" id3032 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3032 -->
<!-- npu="A3" id3033 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3033 -->
<!-- npu="910b" id3034 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3034 -->
<!-- npu="310b" id3035 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id3035 -->
<!-- npu="310p" id3036 -->
- Atlas 推理系列产品：支持
<!-- end id3036 -->
<!-- npu="910" id3037 -->
- Atlas 训练系列产品：支持
<!-- end id3037 -->
<!-- npu="IPV350" id3038 -->
- IPV350：不支持
<!-- end id3038 -->
<!-- @ref: runtime/res/docs/zh/api_ref/04_device_management_res.md#id21 -->

### 功能说明

获取指定Device的信息。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| deviceId | 输入 | Device ID。<br>用户调用[aclrtGetDeviceCount](#aclrtGetDeviceCount)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)]。 |
| attr | 输入 | 属性。类型定义请参见[aclrtDevAttr](25-02_Enumerations.md#aclrtDevAttr)。 |
| value | 输出 | 属性值。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtDeviceGetStreamPriorityRange"></a>

## aclrtDeviceGetStreamPriorityRange

```c
aclError aclrtDeviceGetStreamPriorityRange(int32_t *leastPriority, int32_t *greatestPriority)
```

### 产品支持情况

<!-- npu="950" id1989 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1989 -->
<!-- npu="A3" id1990 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1990 -->
<!-- npu="910b" id1991 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1991 -->
<!-- npu="310b" id1992 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1992 -->
<!-- npu="310p" id1993 -->
- Atlas 推理系列产品：支持
<!-- end id1993 -->
<!-- npu="910" id1994 -->
- Atlas 训练系列产品：支持
<!-- end id1994 -->
<!-- npu="IPV350" id1995 -->
- IPV350：不支持
<!-- end id1995 -->
<!-- @ref: runtime/res/docs/zh/api_ref/04_device_management_res.md#id22 -->

### 功能说明

查询硬件支持的Stream最低、最高优先级。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| leastPriority | 输出 | 最低优先级。 |
| greatestPriority | 输出 | 最高优先级。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtGetDeviceCapability"></a>

## aclrtGetDeviceCapability

```c
aclError aclrtGetDeviceCapability(int32_t deviceId, aclrtDevFeatureType devFeatureType, int32_t *value)
```

### 产品支持情况

<!-- npu="950" id1079 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1079 -->
<!-- npu="A3" id1080 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1080 -->
<!-- npu="910b" id1081 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1081 -->
<!-- npu="310b" id1082 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1082 -->
<!-- npu="310p" id1083 -->
- Atlas 推理系列产品：支持
<!-- end id1083 -->
<!-- npu="910" id1084 -->
- Atlas 训练系列产品：支持
<!-- end id1084 -->
<!-- npu="IPV350" id1085 -->
- IPV350：不支持
<!-- end id1085 -->
<!-- @ref: runtime/res/docs/zh/api_ref/04_device_management_res.md#id23 -->

### 功能说明

查询支持的特性信息。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| deviceId | 输入 | Device ID。<br>用户调用[aclrtGetDeviceCount](#aclrtGetDeviceCount)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)]。 |
| devFeatureType | 输入 | 特性类型。类型定义请参见[aclrtDevFeatureType](25-02_Enumerations.md#aclrtDevFeatureType)。 |
| value | 输出 | 特性是否支持。<br><br>  - ACL_DEV_FEATURE_NOT_SUPPORT(0)：不支持<br>  - ACL_DEV_FEATURE_SUPPORT(1)：支持<br><br><br>相关宏定义如下：<br>#define ACL_DEV_FEATURE_SUPPORT  0x00000001<br>#define ACL_DEV_FEATURE_NOT_SUPPORT 0x00000000 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtGetDevicesTopo"></a>

## aclrtGetDevicesTopo

```c
aclError aclrtGetDevicesTopo(uint32_t deviceId, uint32_t otherDeviceId, uint64_t *value)
```

### 产品支持情况

<!-- npu="950" id813 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id813 -->
<!-- npu="A3" id814 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id814 -->
<!-- npu="910b" id815 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id815 -->
<!-- npu="310b" id816 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id816 -->
<!-- npu="310p" id817 -->
- Atlas 推理系列产品：支持
<!-- end id817 -->
<!-- npu="910" id818 -->
- Atlas 训练系列产品：支持
<!-- end id818 -->
<!-- npu="IPV350" id819 -->
- IPV350：不支持
<!-- end id819 -->
<!-- @ref: runtime/res/docs/zh/api_ref/04_device_management_res.md#id24 -->

### 功能说明

获取两个Device之间的网络拓扑关系。

<!-- npu="310b" id11 -->
本接口不支持在Atlas 200I/500 A2 推理产品的Ascend RC形态下调用。
<!-- end id11 -->

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| deviceId | 输入 | 指定Device的ID。<br>用户调用[aclrtGetDeviceCount](#aclrtGetDeviceCount)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)] |
| otherDeviceId | 输入 | 指定Device的ID。<br>用户调用[aclrtGetDeviceCount](#aclrtGetDeviceCount)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)] |
| value | 输出 | 两个Device之间互联的拓扑关系。<br><br>  - ACL_RT_DEVS_TOPOLOGY_HCCS：通过HCCS连接。HCCS是Huawei Cache Coherence System（华为缓存一致性系统），用于CPU/NPU之间的高速互联。<br>  - ACL_RT_DEVS_TOPOLOGY_PIX：通过同一个PCIe Switch连接。<br>  - ACL_RT_DEVS_TOPOLOGY_PHB：通过PCIe Host Bridge连接。<br>  - ACL_RT_DEVS_TOPOLOGY_SYS：通过SMP（Symmetric Multiprocessing）连接，NUMA节点之间通过SMP互连。<br>  - ACL_RT_DEVS_TOPOLOGY_SIO：片内连接方式，两个DIE之间通过该方式连接。<br>  - ACL_RT_DEVS_TOPOLOGY_HCCS_SW：通过HCCS Switch连接。<br>  - ACL_RT_DEVS_TOPOLOGY_PIB：预留值，暂不支持。<br><br>宏定义如下：<br>#define ACL_RT_DEVS_TOPOLOGY_HCCS  0x01ULL<br>#define ACL_RT_DEVS_TOPOLOGY_PIX  0x02ULL<br>#define ACL_RT_DEVS_TOPOLOGY_PHB  0x08ULL<br>#define ACL_RT_DEVS_TOPOLOGY_SYS  0x10ULL<br>#define ACL_RT_DEVS_TOPOLOGY_SIO  0x20ULL<br>#define ACL_RT_DEVS_TOPOLOGY_HCCS_SW  0x40ULL<br>#define ACL_RT_DEVS_TOPOLOGY_PIB  0x04ULL |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtRegDeviceStateCallback"></a>

## aclrtRegDeviceStateCallback

```c
aclError aclrtRegDeviceStateCallback(const char *regName, aclrtDeviceStateCallback callback, void *args)
```

### 产品支持情况

<!-- npu="950" id2633 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2633 -->
<!-- npu="A3" id2634 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2634 -->
<!-- npu="910b" id2635 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2635 -->
<!-- npu="310b" id2636 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2636 -->
<!-- npu="310p" id2637 -->
- Atlas 推理系列产品：支持
<!-- end id2637 -->
<!-- npu="910" id2638 -->
- Atlas 训练系列产品：支持
<!-- end id2638 -->
<!-- npu="IPV350" id2639 -->
- IPV350：不支持
<!-- end id2639 -->
<!-- @ref: runtime/res/docs/zh/api_ref/04_device_management_res.md#id25 -->

### 功能说明

注册Device状态回调函数，不支持重复注册。

当Device状态发生变化时（例如调用[aclrtSetDevice](#aclrtSetDevice)、[aclrtResetDevice](#aclrtResetDevice)等接口），Runtime模块会触发该回调函数的调用。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| regName | 输入 | 注册名称，保持唯一，不能为空，输入保证字符串以\0结尾。 |
| callback | 输入 | 回调函数。若callback不为NULL，则表示注册回调函数；若为NULL，则表示取消注册回调函数。<br>回调函数的函数原型为：<br>typedef enum {<br>   ACL_RT_DEVICE_STATE_SET_PRE = 0, // 调用set接口（例如aclrtSetDevice）之前<br>   ACL_RT_DEVICE_STATE_SET_POST,  // 调用set接口（例如aclrtSetDevice）之后<br>   ACL_RT_DEVICE_STATE_RESET_PRE,  // 调用reset接口（例如aclrtResetDevice）之前<br>   ACL_RT_DEVICE_STATE_RESET_POST, // 调用reset接口（例如aclrtResetDevice）之后<br>} aclrtDeviceState;<br>typedef void (*aclrtDeviceStateCallback)(uint32_t devId, aclrtDeviceState state, void*args); |
| args | 输入 | 待传递给回调函数的用户数据的指针。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtGetLogicDevIdByUserDevId"></a>

## aclrtGetLogicDevIdByUserDevId

```c
aclError aclrtGetLogicDevIdByUserDevId(const int32_t userDevid, int32_t *const logicDevId)
```

### 产品支持情况

<!-- npu="950" id456 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id456 -->
<!-- npu="A3" id457 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id457 -->
<!-- npu="910b" id458 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id458 -->
<!-- npu="310b" id459 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id459 -->
<!-- npu="310p" id460 -->
- Atlas 推理系列产品：支持
<!-- end id460 -->
<!-- npu="910" id461 -->
- Atlas 训练系列产品：支持
<!-- end id461 -->
<!-- npu="IPV350" id462 -->
- IPV350：不支持
<!-- end id462 -->
<!-- @ref: runtime/res/docs/zh/api_ref/04_device_management_res.md#id26 -->

### 功能说明

根据用户设备ID获取对应的逻辑设备ID。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| userDevid | 输入 | 用户设备ID。 |
| logicDevId | 输出 | 逻辑设备ID。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 用户设备ID、逻辑设备ID、物理设备ID之间的关系

若未设置ASCEND\_RT\_VISIBLE\_DEVICES环境变量，逻辑设备ID与用户设备ID相同；若在非容器场景下，物理设备ID与逻辑设备ID相同。

下图以容器场景且设置ASCEND\_RT\_VISIBLE\_DEVICES环境变量为例说明三者之间的关系：通过ASCEND\_RT\_VISIBLE\_DEVICES环境变量设置的Device ID依次为**1**、2，对应的Device索引值依次为**0**、1，通过[aclrtSetDevice](#aclrtSetDevice)接口设置的用户设备ID为**0**，即对应的Device索引值为**0**，因此用户设备ID=**0**对应逻辑设备ID=**1**，容器中的逻辑设备ID=**1**又映射到物理设备ID=**6**，因此最终是使用ID为6的物理设备进行计算。

![](figures/UserDevId_LogicDevId_PhyDevId.png)

关于ASCEND\_RT\_VISIBLE\_DEVICES环境的详细介绍请参见[《环境变量参考》](https://hiascend.com/document/redirect/CannCommunityEnvRef)。

<br>
<br>
<br>

<a id="aclrtGetUserDevIdByLogicDevId"></a>

## aclrtGetUserDevIdByLogicDevId

```c
aclError aclrtGetUserDevIdByLogicDevId(const int32_t logicDevId, int32_t *const userDevid)
```

### 产品支持情况

<!-- npu="950" id1702 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1702 -->
<!-- npu="A3" id1703 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1703 -->
<!-- npu="910b" id1704 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1704 -->
<!-- npu="310b" id1705 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1705 -->
<!-- npu="310p" id1706 -->
- Atlas 推理系列产品：支持
<!-- end id1706 -->
<!-- npu="910" id1707 -->
- Atlas 训练系列产品：支持
<!-- end id1707 -->
<!-- npu="IPV350" id1708 -->
- IPV350：不支持
<!-- end id1708 -->
<!-- @ref: runtime/res/docs/zh/api_ref/04_device_management_res.md#id27 -->

### 功能说明

根据逻辑设备ID获取对应的用户设备ID。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| logicDevId | 输入 | 逻辑设备ID。 |
| userDevid | 输出 | 用户设备ID。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 用户设备ID、逻辑设备ID、物理设备ID之间的关系

若未设置ASCEND\_RT\_VISIBLE\_DEVICES环境变量，逻辑设备ID与用户设备ID相同；若在非容器场景下，物理设备ID与逻辑设备ID相同。

下图以容器场景且设置ASCEND\_RT\_VISIBLE\_DEVICES环境变量为例说明三者之间的关系：通过ASCEND\_RT\_VISIBLE\_DEVICES环境变量设置的Device ID依次为**1**、2，对应的Device索引值依次为**0**、1，通过[aclrtSetDevice](#aclrtSetDevice)接口设置的用户设备ID为**0**，即对应的Device索引值为**0**，因此用户设备ID=**0**对应逻辑设备ID=**1**，容器中的逻辑设备ID=**1**又映射到物理设备ID=**6**，因此最终是使用ID为6的物理设备进行计算。

![](figures/UserDevId_LogicDevId_PhyDevId.png)

关于ASCEND\_RT\_VISIBLE\_DEVICES环境的详细介绍请参见[《环境变量参考》](https://hiascend.com/document/redirect/CannCommunityEnvRef)。

<br>
<br>
<br>

<a id="aclrtGetLogicDevIdByPhyDevId"></a>

## aclrtGetLogicDevIdByPhyDevId

```c
aclError aclrtGetLogicDevIdByPhyDevId(const int32_t phyDevId, int32_t *const logicDevId)
```

### 产品支持情况

<!-- npu="950" id1296 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1296 -->
<!-- npu="A3" id1297 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1297 -->
<!-- npu="910b" id1298 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1298 -->
<!-- npu="310b" id1299 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1299 -->
<!-- npu="310p" id1300 -->
- Atlas 推理系列产品：支持
<!-- end id1300 -->
<!-- npu="910" id1301 -->
- Atlas 训练系列产品：支持
<!-- end id1301 -->
<!-- npu="IPV350" id1302 -->
- IPV350：不支持
<!-- end id1302 -->
<!-- @ref: runtime/res/docs/zh/api_ref/04_device_management_res.md#id28 -->

### 功能说明

根据物理设备ID获取对应的逻辑设备ID。

**注意：本接口中逻辑设备ID的语义描述不正确，实际对应用户设备ID。为修复此问题，Runtime提供了[aclrtGetUserDevIdByPhyDevId](#aclrtGetUserDevIdByPhyDevId)接口作为替代。**

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| phyDevId | 输入 | 物理设备ID。 |
| logicDevId | 输出 | 逻辑设备ID（参数实际为userDevId）。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 用户设备ID、逻辑设备ID、物理设备ID之间的关系

若未设置ASCEND\_RT\_VISIBLE\_DEVICES环境变量，逻辑设备ID与用户设备ID相同；若在非容器场景下，物理设备ID与逻辑设备ID相同。

下图以容器场景且设置ASCEND\_RT\_VISIBLE\_DEVICES环境变量为例说明三者之间的关系：通过ASCEND\_RT\_VISIBLE\_DEVICES环境变量设置的Device ID依次为**1**、2，对应的Device索引值依次为**0**、1，通过[aclrtSetDevice](#aclrtSetDevice)接口设置的用户设备ID为**0**，即对应的Device索引值为**0**，因此用户设备ID=**0**对应逻辑设备ID=**1**，容器中的逻辑设备ID=**1**又映射到物理设备ID=**6**，因此最终是使用ID为6的物理设备进行计算。

![](figures/UserDevId_LogicDevId_PhyDevId.png)

关于ASCEND\_RT\_VISIBLE\_DEVICES环境的详细介绍请参见[《环境变量参考》](https://hiascend.com/document/redirect/CannCommunityEnvRef)。

<br>
<br>
<br>

<a id="aclrtGetPhyDevIdByLogicDevId"></a>

## aclrtGetPhyDevIdByLogicDevId

```c
aclError aclrtGetPhyDevIdByLogicDevId(const int32_t logicDevId, int32_t *const phyDevId)
```

### 产品支持情况

<!-- npu="950" id2255 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2255 -->
<!-- npu="A3" id2256 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2256 -->
<!-- npu="910b" id2257 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2257 -->
<!-- npu="310b" id2258 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2258 -->
<!-- npu="310p" id2259 -->
- Atlas 推理系列产品：支持
<!-- end id2259 -->
<!-- npu="910" id2260 -->
- Atlas 训练系列产品：支持
<!-- end id2260 -->
<!-- npu="IPV350" id2261 -->
- IPV350：不支持
<!-- end id2261 -->
<!-- @ref: runtime/res/docs/zh/api_ref/04_device_management_res.md#id29 -->

### 功能说明

根据逻辑设备ID获取对应的物理设备ID。

**注意：本接口中逻辑设备ID的语义描述不正确，实际对应用户设备ID。为修复此问题，Runtime提供了[aclrtGetPhyDevIdByUserDevId](#aclrtGetPhyDevIdByUserDevId)接口作为替代。**

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| logicDevId | 输入 | 逻辑设备ID（参数实际为userDevId）。 |
| phyDevId | 输出 | 物理设备ID。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 用户设备ID、逻辑设备ID、物理设备ID之间的关系

若未设置ASCEND\_RT\_VISIBLE\_DEVICES环境变量，逻辑设备ID与用户设备ID相同；若在非容器场景下，物理设备ID与逻辑设备ID相同。

下图以容器场景且设置ASCEND\_RT\_VISIBLE\_DEVICES环境变量为例说明三者之间的关系：通过ASCEND\_RT\_VISIBLE\_DEVICES环境变量设置的Device ID依次为**1**、2，对应的Device索引值依次为**0**、1，通过[aclrtSetDevice](#aclrtSetDevice)接口设置的用户设备ID为**0**，即对应的Device索引值为**0**，因此用户设备ID=**0**对应逻辑设备ID=**1**，容器中的逻辑设备ID=**1**又映射到物理设备ID=**6**，因此最终是使用ID为6的物理设备进行计算。

![](figures/UserDevId_LogicDevId_PhyDevId.png)

关于ASCEND\_RT\_VISIBLE\_DEVICES环境的详细介绍请参见[《环境变量参考》](https://hiascend.com/document/redirect/CannCommunityEnvRef)。

<br>
<br>
<br>

<a id="aclrtGetUserDevIdByPhyDevId"></a>

## aclrtGetUserDevIdByPhyDevId

```c
aclError aclrtGetUserDevIdByPhyDevId(const int32_t phyDevId, int32_t *const userDevId)
```

### 产品支持情况

<!-- npu="950" id3326 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3326 -->
<!-- npu="A3" id3327 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3327 -->
<!-- npu="910b" id3328 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3328 -->
<!-- npu="310b" id3329 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id3329 -->
<!-- npu="310p" id3330 -->
- Atlas 推理系列产品：支持
<!-- end id3330 -->
<!-- npu="910" id3331 -->
- Atlas 训练系列产品：支持
<!-- end id3331 -->
<!-- npu="IPV350" id3332 -->
- IPV350：不支持
<!-- end id3332 -->
<!-- @ref: runtime/res/docs/zh/api_ref/04_device_management_res.md#id30 -->

### 功能说明

根据物理设备ID获取对应的用户设备ID。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| phyDevId | 输入 | 物理设备ID。 |
| userDevId | 输出 | 用户设备ID。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 用户设备ID、逻辑设备ID、物理设备ID之间的关系

若未设置ASCEND\_RT\_VISIBLE\_DEVICES环境变量，逻辑设备ID与用户设备ID相同；若在非容器场景下，物理设备ID与逻辑设备ID相同。

下图以容器场景且设置ASCEND\_RT\_VISIBLE\_DEVICES环境变量为例说明三者之间的关系：通过ASCEND\_RT\_VISIBLE\_DEVICES环境变量设置的Device ID依次为**1**、2，对应的Device索引值依次为**0**、1，通过[aclrtSetDevice](#aclrtSetDevice)接口设置的用户设备ID为**0**，即对应的Device索引值为**0**，因此用户设备ID=**0**对应逻辑设备ID=**1**，容器中的逻辑设备ID=**1**又映射到物理设备ID=**6**，因此最终是使用ID为6的物理设备进行计算。

![](figures/UserDevId_LogicDevId_PhyDevId.png)

关于ASCEND\_RT\_VISIBLE\_DEVICES环境的详细介绍请参见[《环境变量参考》](https://hiascend.com/document/redirect/CannCommunityEnvRef)。

<br>
<br>
<br>

<a id="aclrtGetPhyDevIdByUserDevId"></a>

## aclrtGetPhyDevIdByUserDevId

```c
aclError aclrtGetPhyDevIdByUserDevId(const int32_t userDevId, int32_t *const phyDevId)
```

### 产品支持情况

<!-- npu="950" id575 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id575 -->
<!-- npu="A3" id576 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id576 -->
<!-- npu="910b" id577 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id577 -->
<!-- npu="310b" id578 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id578 -->
<!-- npu="310p" id579 -->
- Atlas 推理系列产品：支持
<!-- end id579 -->
<!-- npu="910" id580 -->
- Atlas 训练系列产品：支持
<!-- end id580 -->
<!-- npu="IPV350" id581 -->
- IPV350：不支持
<!-- end id581 -->
<!-- @ref: runtime/res/docs/zh/api_ref/04_device_management_res.md#id31 -->

### 功能说明

根据用户设备ID获取对应的物理设备ID。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| userDevId | 输入 | 用户设备ID。 |
| phyDevId | 输出 | 物理设备ID。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 用户设备ID、逻辑设备ID、物理设备ID之间的关系

若未设置ASCEND\_RT\_VISIBLE\_DEVICES环境变量，逻辑设备ID与用户设备ID相同；若在非容器场景下，物理设备ID与逻辑设备ID相同。

下图以容器场景且设置ASCEND\_RT\_VISIBLE\_DEVICES环境变量为例说明三者之间的关系：通过ASCEND\_RT\_VISIBLE\_DEVICES环境变量设置的Device ID依次为**1**、2，对应的Device索引值依次为**0**、1，通过[aclrtSetDevice](#aclrtSetDevice)接口设置的用户设备ID为**0**，即对应的Device索引值为**0**，因此用户设备ID=**0**对应逻辑设备ID=**1**，容器中的逻辑设备ID=**1**又映射到物理设备ID=**6**，因此最终是使用ID为6的物理设备进行计算。

![](figures/UserDevId_LogicDevId_PhyDevId.png)

关于ASCEND\_RT\_VISIBLE\_DEVICES环境的详细介绍请参见[《环境变量参考》](https://hiascend.com/document/redirect/CannCommunityEnvRef)。

<br>
<br>
<br>

<a id="aclrtDeviceGetUuid"></a>

## aclrtDeviceGetUuid

```c
aclError aclrtDeviceGetUuid(int32_t deviceId, aclrtUuid *uuid)
```

### 产品支持情况

<!-- npu="950" id2654 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2654 -->
<!-- npu="A3" id2655 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2655 -->
<!-- npu="910b" id2656 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2656 -->
<!-- npu="310b" id2657 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id2657 -->
<!-- npu="310p" id2658 -->
- Atlas 推理系列产品：不支持
<!-- end id2658 -->
<!-- npu="910" id2659 -->
- Atlas 训练系列产品：不支持
<!-- end id2659 -->
<!-- npu="IPV350" id2660 -->
- IPV350：不支持
<!-- end id2660 -->
<!-- @ref: runtime/res/docs/zh/api_ref/04_device_management_res.md#id32 -->

### 功能说明

获取Device的唯一标识UUID（Universally Unique Identifier）。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| deviceId | 输入 | Device ID，与[aclrtSetDevice](#aclrtSetDevice)接口中的Device ID保持一致。 |
| uuid | 输出 | Device的唯一标识。类型定义请参见[aclrtUuid](25-04_Structs.md#aclrtUuid)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtDeviceGetBareTgid"></a>

## aclrtDeviceGetBareTgid

```c
aclError aclrtDeviceGetBareTgid(int32_t *pid)
```

### 产品支持情况

<!-- npu="950" id855 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id855 -->
<!-- npu="A3" id856 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id856 -->
<!-- npu="910b" id857 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id857 -->
<!-- npu="310b" id858 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id858 -->
<!-- npu="310p" id859 -->
- Atlas 推理系列产品：支持
<!-- end id859 -->
<!-- npu="910" id860 -->
- Atlas 训练系列产品：支持
<!-- end id860 -->
<!-- npu="IPV350" id861 -->
- IPV350：不支持
<!-- end id861 -->
<!-- @ref: runtime/res/docs/zh/api_ref/04_device_management_res.md#id33 -->

### 功能说明

获取当前进程的进程ID。

本接口内部在获取进程ID时已适配物理机、虚拟机场景，用户只需调用本接口获取进程ID，再配置其它接口使用（配合流程请参见[aclrtMemExportToShareableHandle](11-04_virtual_memory_management.md#aclrtMemExportToShareableHandle)），达到物理内存共享的目的。若用户不调用本接口、自行获取进程ID，可能会导致后续使用进程ID异常。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| pid | 输出 | 进程ID。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtDeviceGetHostAtomicCapabilities"></a>

## aclrtDeviceGetHostAtomicCapabilities

```c
aclError aclrtDeviceGetHostAtomicCapabilities(uint32_t* capabilities, const aclrtAtomicOperation* operations, const uint32_t count, int32_t deviceId)
```

### 产品支持情况

<!-- npu="950" id2262 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2262 -->
<!-- npu="A3" id2263 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2263 -->
<!-- npu="910b" id2264 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2264 -->
<!-- npu="310b" id2265 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2265 -->
<!-- npu="310p" id2266 -->
- Atlas 推理系列产品：支持
<!-- end id2266 -->
<!-- npu="910" id2267 -->
- Atlas 训练系列产品：支持
<!-- end id2267 -->
<!-- npu="IPV350" id2268 -->
- IPV350：不支持
<!-- end id2268 -->
<!-- @ref: runtime/res/docs/zh/api_ref/04_device_management_res.md#id34 -->

### 功能说明

查询指定Device与Host之间支持的原子操作详情。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| capabilities | 输出 | 原子操作支持能力数组，数组长度与count参数值一致。数组中的每个元素是一个位掩码，位掩码的每一位代表对不同数据类型原子操作的支持情况，1表示支持，0表示不支持。类型定义请参见[aclrtAtomicOperationCapability](25-02_Enumerations.md#aclrtAtomicOperationCapability)。 |
| operations | 输入 | 待查询的原子操作数组，数组长度与count参数值一致。类型定义请参见[aclrtAtomicOperation](25-02_Enumerations.md#aclrtAtomicOperation)。 |
| count | 输入 | 待查询的原子操作数量，其大小必须与capabilities以及operations参数数组的长度一致，否则可能会导致未定义的行为。 |
| deviceId | 输入 | Device ID。<br>用户调用[aclrtGetDeviceCount](#aclrtGetDeviceCount)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)] |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtDeviceGetP2PAtomicCapabilities"></a>

## aclrtDeviceGetP2PAtomicCapabilities

```c
aclError aclrtDeviceGetP2PAtomicCapabilities(uint32_t* capabilities, const aclrtAtomicOperation* operations, const uint32_t count, int32_t srcDeviceId, int32_t dstDeviceId)
```

### 产品支持情况

<!-- npu="950" id1968 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1968 -->
<!-- npu="A3" id1969 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1969 -->
<!-- npu="910b" id1970 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1970 -->
<!-- npu="310b" id1971 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1971 -->
<!-- npu="310p" id1972 -->
- Atlas 推理系列产品：支持
<!-- end id1972 -->
<!-- npu="910" id1973 -->
- Atlas 训练系列产品：支持
<!-- end id1973 -->
<!-- npu="IPV350" id1974 -->
- IPV350：不支持
<!-- end id1974 -->
<!-- @ref: runtime/res/docs/zh/api_ref/04_device_management_res.md#id35 -->

### 功能说明

查询一个AI Server内两个Device之间支持的原子操作详情。AI Server通常是多个Device组成的服务器形态的统称。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| capabilities | 输出 | 原子操作支持能力数组，数组长度与count参数值一致。数组中的每个元素是一个位掩码，位掩码的每一位代表对不同数据类型原子操作的支持情况，1表示支持，0表示不支持。类型定义请参见[aclrtAtomicOperationCapability](25-02_Enumerations.md#aclrtAtomicOperationCapability)。 |
| operations | 输入 | 待查询的原子操作数组，数组长度与count参数值一致。类型定义请参见[aclrtAtomicOperation](25-02_Enumerations.md#aclrtAtomicOperation)。 |
| count | 输入 | 待查询的原子操作数量，其大小必须与capabilities以及operations参数数组的长度一致，否则可能会导致未定义的行为。 |
| srcDeviceId | 输入 | Device ID。<br>用户调用[aclrtGetDeviceCount](#aclrtGetDeviceCount)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)] |
| dstDeviceId | 输入 | Device ID。<br>用户调用[aclrtGetDeviceCount](#aclrtGetDeviceCount)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)] |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。
