# 12. 执行控制

本章节描述 CANN Runtime 的执行控制接口，包括回调函数启动、Host 函数订阅、超时设置及异步 Reduce 操作。

- [`aclError aclrtLaunchCallback(aclrtCallback fn, void *userData, aclrtCallbackBlockType blockType, aclrtStream stream)`](#aclrtLaunchCallback)：在Stream的任务队列中下发一个Host回调任务，系统内部在执行到该回调任务时，会在Stream上注册的线程（该线程由用户自行创建，并通过[aclrtSubscribeReport](#aclrtSubscribeReport)接口注册）中执行回调函数。
- [`aclError aclrtSubscribeReport(uint64_t threadId, aclrtStream stream)`](#aclrtSubscribeReport)：注册处理Stream上回调函数的线程。
- [`aclError aclrtProcessReport(int32_t timeout)`](#aclrtProcessReport)：调用本接口设置超时时间，等待[aclrtLaunchCallback](#aclrtLaunchCallback)接口下发的回调任务执行。
- [`aclError aclrtUnSubscribeReport(uint64_t threadId, aclrtStream stream)`](#aclrtUnSubscribeReport)：取消线程注册，Stream上的回调函数不再由指定线程处理。
- [`aclError aclrtGetOpTimeOutInterval(uint64_t *interval)`](#aclrtGetOpTimeOutInterval)：获取硬件支持的算子超时配置的最短时间间隔interval，单位为微秒。
- [`aclError aclrtSetOpExecuteTimeOut(uint32_t timeout)`](#aclrtSetOpExecuteTimeOut)：设置算子执行的超时时间，单位为秒。一个进程内多次调用本接口，则以最后一次设置的时间为准。
- [`aclError aclrtSetOpExecuteTimeOutV2(uint64_t timeout, uint64_t *actualTimeout)`](#aclrtSetOpExecuteTimeOutV2)：设置算子执行的超时时间，单位为微秒。
- [`aclError aclrtSetOpExecuteTimeOutWithMs(uint32_t timeout)`](#aclrtSetOpExecuteTimeOutWithMs)：设置算子执行的超时时间，单位为毫秒。
- [`aclError aclrtGetOpExecuteTimeout(uint32_t *const timeoutMs)`](#aclrtGetOpExecuteTimeout)：获取AI Core算子执行的超时时间。
- [`aclError aclrtGetThreadLastTaskId(uint32_t *taskId)`](#aclrtGetThreadLastTaskId)：获取当前线程的最后一个下发的Task ID。
- [`aclError aclrtReduceAsync(void *dst, const void *src, uint64_t count, aclrtReduceKind kind, aclDataType type, aclrtStream stream, void *reserve)`](#aclrtReduceAsync)：执行Reduce操作，包括SUM、MIN、MAX等。异步接口。
- [`aclError aclrtLaunchHostFunc(aclrtStream stream, aclrtHostFunc fn, void *args)`](#aclrtLaunchHostFunc)：在Stream的任务队列中下发一个Host回调任务，系统内部在执行到该回调任务时，会在Stream上注册的线程（该线程在本接口内部创建并注册）中执行回调函数，并且回调任务默认阻塞本Stream上后续任务的执行。
- [`aclError aclrtRandomNumAsync(const aclrtRandomNumTaskInfo *taskInfo, const aclrtStream stream, void *reserve)`](#aclrtRandomNumAsync)：下发并执行随机数生成任务。异步接口。
- [`aclError aclrtTaskUpdateAsync(aclrtStream taskStream, uint32_t taskId, aclrtTaskUpdateInfo *info, aclrtStream execStream)`](#aclrtTaskUpdateAsync)：刷新目标任务的信息。异步接口。

<a id="aclrtLaunchCallback"></a>

## aclrtLaunchCallback

```c
aclError aclrtLaunchCallback(aclrtCallback fn, void *userData, aclrtCallbackBlockType blockType, aclrtStream stream)
```

### 产品支持情况

<!-- npu="950" id2773 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2773 -->
<!-- npu="A3" id2774 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2774 -->
<!-- npu="910b" id2775 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2775 -->
<!-- npu="310b" id2776 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2776 -->
<!-- npu="310p" id2777 -->
- Atlas 推理系列产品：支持
<!-- end id2777 -->
<!-- npu="910" id2778 -->
- Atlas 训练系列产品：支持
<!-- end id2778 -->
<!-- npu="IPV350" id2779 -->
- IPV350：支持
<!-- end id2779 -->
<!-- @ref: runtime/res/docs/zh/api_ref/12_execution_control_res.md#id1 -->

### 功能说明

在Stream的任务队列中下发一个Host回调任务，系统内部在执行到该回调任务时，会在Stream上注册的线程（该线程由用户自行创建，并通过[aclrtSubscribeReport](#aclrtSubscribeReport)接口注册）中执行回调函数。异步接口。

**本接口需与以下其它接口配合使用**，以便实现异步场景下的callback功能：

1. 定义并实现回调函数，函数原型为：typedef void \(\*aclrtCallback\)\(void \*userData\)；
2. 新建线程，在线程函数内，调用[aclrtProcessReport](#aclrtProcessReport)接口设置超时时间（需循环调用），等待回调任务执行；
3. 调用[aclrtSubscribeReport](#aclrtSubscribeReport)接口建立第2步中的线程和Stream的绑定关系，该Stream下发的回调函数将在绑定的线程中执行；
4. 在指定Stream上执行异步任务（例如异步推理任务）；
5. 调用[aclrtLaunchCallback](#aclrtLaunchCallback)接口在Stream的任务队列中下发回调任务，触发第2步中注册的线程处理回调函数，每调用一次aclrtLaunchCallback接口，就会触发一次回调函数的执行；
6. 异步任务全部执行完成后，取消线程注册（[aclrtUnSubscribeReport](#aclrtUnSubscribeReport)接口）。

本接口可用于实现异步场景下的callback功能，与另一个实现异步场景下的callback功能接口[aclrtLaunchHostFunc](#aclrtLaunchHostFunc)的差别在于：使用aclrtLaunchHostFunc接口时，会在Stream上注册的线程（该线程在本接口内部创建并注册）中执行回调函数，并且回调任务默认阻塞本Stream上后续任务的执行。

对于同一个Stream，两套实现异步场景下的callback功能的接口不能混用，否则可能出现异常。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| fn | 输入 | 指定要增加的回调函数。<br>回调函数的函数原型为：<br>typedef void (*aclrtCallback)(void*userData) |
| userData | 输入 | 待传递给回调函数的用户数据的指针。 |
| blockType | 输入 | 指定回调任务是否阻塞本Stream上后续任务的执行。<br>typedef enum aclrtCallbackBlockType {<br>   ACL_CALLBACK_NO_BLOCK,  //非阻塞<br>   ACL_CALLBACK_BLOCK,  //阻塞<br>} aclrtCallbackBlockType; |
| stream | 输入 | 指定Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

回调函数涉及共享资源（例如锁），因此在使用回调函数需慎重，不应该调用资源申请、资源释放、Stream同步、Device同步、任务下发、任务终止等接口，否则可能导致错误或死锁。

<br>
<br>
<br>

<a id="aclrtSubscribeReport"></a>

## aclrtSubscribeReport

```c
aclError aclrtSubscribeReport(uint64_t threadId, aclrtStream stream)
```

### 产品支持情况

<!-- npu="950" id2010 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2010 -->
<!-- npu="A3" id2011 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2011 -->
<!-- npu="910b" id2012 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2012 -->
<!-- npu="310b" id2013 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2013 -->
<!-- npu="310p" id2014 -->
- Atlas 推理系列产品：支持
<!-- end id2014 -->
<!-- npu="910" id2015 -->
- Atlas 训练系列产品：支持
<!-- end id2015 -->
<!-- npu="IPV350" id2016 -->
- IPV350：支持
<!-- end id2016 -->
<!-- @ref: runtime/res/docs/zh/api_ref/12_execution_control_res.md#id2 -->

### 功能说明

注册处理Stream上回调函数的线程。

**本接口需与以下其它接口配合使用**，以便实现异步场景下的callback功能：

1. 定义并实现回调函数，函数原型为：typedef void \(\*aclrtCallback\)\(void \*userData\)；
2. 新建线程，在线程函数内，调用[aclrtProcessReport](#aclrtProcessReport)接口设置超时时间（需循环调用），等待回调任务执行；
3. 调用[aclrtSubscribeReport](#aclrtSubscribeReport)接口建立第2步中的线程和Stream的绑定关系，该Stream下发的回调函数将在绑定的线程中执行；
4. 在指定Stream上执行异步任务（例如异步推理任务）；
5. 调用[aclrtLaunchCallback](#aclrtLaunchCallback)接口在Stream的任务队列中下发回调任务，触发第2步中注册的线程处理回调函数，每调用一次aclrtLaunchCallback接口，就会触发一次回调函数的执行；
6. 异步任务全部执行完成后，取消线程注册（[aclrtUnSubscribeReport](#aclrtUnSubscribeReport)接口）。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| threadId | 输入 | 指定线程的ID。 |
| stream | 输入 | 指定Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

支持多次调用aclrtSubscribeReport接口给多个Stream（仅支持同一Device内的多个Stream）注册同一个处理回调函数的线程；为确保Stream内的任务按调用顺序执行，不支持调用aclrtSubscribeReport接口给同一个Stream注册多个处理回调函数的线程；同一个进程内，在不同的Device上注册回调函数的线程时，不能指定同一个线程ID。

<!-- npu="950,A3,910b,910,310p,310b" id8 -->
单进程内调用本接口注册的线程数量超过一定限制，则接口返回失败。考虑操作系统的线程切换性能开销，建议调用aclrtSubscribeReport接口注册的线程数量控制在32个以下（包括32）。当前支持的线程数量最大值为1024。
<!-- end id8 -->

<!-- @ref: runtime/res/docs/zh/api_ref/12_execution_control_res.md#id15 -->

<br>
<br>
<br>

<a id="aclrtProcessReport"></a>

## aclrtProcessReport

```c
aclError aclrtProcessReport(int32_t timeout)
```

### 产品支持情况

<!-- npu="950" id1359 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1359 -->
<!-- npu="A3" id1360 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1360 -->
<!-- npu="910b" id1361 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1361 -->
<!-- npu="310b" id1362 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1362 -->
<!-- npu="310p" id1363 -->
- Atlas 推理系列产品：支持
<!-- end id1363 -->
<!-- npu="910" id1364 -->
- Atlas 训练系列产品：支持
<!-- end id1364 -->
<!-- npu="IPV350" id1365 -->
- IPV350：支持
<!-- end id1365 -->
<!-- @ref: runtime/res/docs/zh/api_ref/12_execution_control_res.md#id3 -->

### 功能说明

调用本接口设置超时时间，等待[aclrtLaunchCallback](#aclrtLaunchCallback)接口下发的回调任务执行。

**本接口需与以下其它接口配合使用**，以便实现异步场景下的callback功能：

1. 定义并实现回调函数，函数原型为：typedef void \(\*aclrtCallback\)\(void \*userData\)；
2. 新建线程，在线程函数内，调用[aclrtProcessReport](#aclrtProcessReport)接口设置超时时间（需循环调用），等待回调任务执行；
3. 调用[aclrtSubscribeReport](#aclrtSubscribeReport)接口建立第2步中的线程和Stream的绑定关系，该Stream下发的回调函数将在绑定的线程中执行；
4. 在指定Stream上执行异步任务（例如异步推理任务）；
5. 调用[aclrtLaunchCallback](#aclrtLaunchCallback)接口在Stream的任务队列中下发回调任务，触发第2步中注册的线程处理回调函数，每调用一次aclrtLaunchCallback接口，就会触发一次回调函数的执行；
6. 异步任务全部执行完成后，取消线程注册（[aclrtUnSubscribeReport](#aclrtUnSubscribeReport)接口）。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| timeout | 输入 | 超时时间，单位为ms。<br>取值范围：<br><br>  - -1：表示无限等待<br>  - 大于0（不包含0）：表示等待的时间 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtUnSubscribeReport"></a>

## aclrtUnSubscribeReport

```c
aclError aclrtUnSubscribeReport(uint64_t threadId, aclrtStream stream)
```

### 产品支持情况

<!-- npu="950" id2143 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2143 -->
<!-- npu="A3" id2144 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2144 -->
<!-- npu="910b" id2145 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2145 -->
<!-- npu="310b" id2146 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2146 -->
<!-- npu="310p" id2147 -->
- Atlas 推理系列产品：支持
<!-- end id2147 -->
<!-- npu="910" id2148 -->
- Atlas 训练系列产品：支持
<!-- end id2148 -->
<!-- npu="IPV350" id2149 -->
- IPV350：支持
<!-- end id2149 -->
<!-- @ref: runtime/res/docs/zh/api_ref/12_execution_control_res.md#id4 -->

### 功能说明

取消线程注册，Stream上的回调函数不再由指定线程处理。

**本接口需与以下其它接口配合使用**，以便实现异步场景下的callback功能：

1. 定义并实现回调函数，函数原型为：typedef void \(\*aclrtCallback\)\(void \*userData\)；
2. 新建线程，在线程函数内，调用[aclrtProcessReport](#aclrtProcessReport)接口设置超时时间（需循环调用），等待回调任务执行；
3. 调用[aclrtSubscribeReport](#aclrtSubscribeReport)接口建立第2步中的线程和Stream的绑定关系，该Stream下发的回调函数将在绑定的线程中执行；
4. 在指定Stream上执行异步任务（例如异步推理任务）；
5. 调用[aclrtLaunchCallback](#aclrtLaunchCallback)接口在Stream的任务队列中下发回调任务，触发第2步中注册的线程处理回调函数，每调用一次aclrtLaunchCallback接口，就会触发一次回调函数的执行；
6. 异步任务全部执行完成后，取消线程注册（[aclrtUnSubscribeReport](#aclrtUnSubscribeReport)接口）。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| threadId | 输入 | 指定线程的ID。 |
| stream | 输入 | 指定Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtGetOpTimeOutInterval"></a>

## aclrtGetOpTimeOutInterval

```c
aclError aclrtGetOpTimeOutInterval(uint64_t *interval)
```

### 产品支持情况

<!-- npu="950" id1 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1 -->
<!-- npu="A3" id2 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2 -->
<!-- npu="910b" id3 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3 -->
<!-- npu="310b" id4 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id4 -->
<!-- npu="310p" id5 -->
- Atlas 推理系列产品：支持
<!-- end id5 -->
<!-- npu="910" id6 -->
- Atlas 训练系列产品：支持
<!-- end id6 -->
<!-- npu="IPV350" id7 -->
- IPV350：不支持
<!-- end id7 -->
<!-- @ref: runtime/res/docs/zh/api_ref/12_execution_control_res.md#id5 -->

### 功能说明

获取硬件支持的算子超时配置的最短时间间隔interval，单位为微秒。

<!-- npu="910,310p,310b" id9 -->
对于Atlas 200I/500 A2 推理产品、Atlas 推理系列产品、Atlas 训练系列产品，调用本接口只能获取AI Core算子的最短时间间隔。
<!-- end id9 -->
<!-- @ref: runtime/res/docs/zh/api_ref/12_execution_control_res.md#id16 -->

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| interval | 输出 | 最短时间间隔，单位为微秒。<br>用户可配置且生效的超时时间是interval *N，N的取值为[1, 254]的整数，如果用户配置的超时时间不等于interval* N，则向上对齐到interval *N，假设interval = 100微秒，用户设置的超时时间为50微秒，则实际生效的超时时间为100*1 = 100微秒；用户设置的超时时间为30000微秒，则实际生效的超时时间为100 *254 =25400微秒。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtSetOpExecuteTimeOut"></a>

## aclrtSetOpExecuteTimeOut

```c
aclError aclrtSetOpExecuteTimeOut(uint32_t timeout)
```

### 产品支持情况

<!-- npu="950" id547 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id547 -->
<!-- npu="A3" id548 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id548 -->
<!-- npu="910b" id549 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id549 -->
<!-- npu="310b" id550 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id550 -->
<!-- npu="310p" id551 -->
- Atlas 推理系列产品：支持
<!-- end id551 -->
<!-- npu="910" id552 -->
- Atlas 训练系列产品：支持
<!-- end id552 -->
<!-- npu="IPV350" id553 -->
- IPV350：支持
<!-- end id553 -->
<!-- @ref: runtime/res/docs/zh/api_ref/12_execution_control_res.md#id6 -->

### 功能说明

设置算子执行的超时时间，单位为秒。一个进程内多次调用本接口，则以最后一次设置的时间为准。

如果算子下发时携带了超时时间，则该超时时间优先级高于本接口设置的超时时间。

<!-- npu="950,A3,910b" id10 -->
对于Ascend 950PR/Ascend 950DT、Atlas A3 训练系列产品/Atlas A3 推理系列产品、Atlas A2 训练系列产品/Atlas A2 推理系列产品，建议使用aclrtSetOpExecuteTimeOutV2接口，该接口会返回实际生效的超时时间。
<!-- end id10 -->

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| timeout | 输入 | 设置超时时间，单位为秒。<br>将该参数设置为0时，表示使用最大超时时间。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<!-- npu="950,A3,910b,910,310p,310b" id11 -->
### 约束说明

- 不调用本接口，不同产品型号的AI Core算子、AI CPU算子默认超时时间不同：
    <!-- npu="950" id12 -->
    - 对于Ascend 950PR/Ascend 950DT，AI Core算子的默认超时时间为1091秒，AI CPU算子的默认超时时间为28秒。
    <!-- end id12 -->
    <!-- npu="A3" id13 -->
    - 对于Atlas A3 训练系列产品/Atlas A3 推理系列产品，AI Core算子的默认超时时间为1091秒，AI CPU算子的默认超时时间为60秒。
    <!-- end id13 -->
    <!-- npu="910b" id14 -->
    - 对于Atlas A2 训练系列产品/Atlas A2 推理系列产品，AI Core算子的默认超时时间为1091秒，AI CPU算子的默认超时时间为28秒。
    <!-- end id14 -->
    <!-- npu="310b" id15 -->
    - 对于Atlas 200I/500 A2 推理产品，AI Core算子的默认超时时间为1091秒，AI CPU算子的默认超时时间为28秒。
    <!-- end id15 -->
    <!-- npu="310p" id16 -->
    - 对于Atlas 推理系列产品，AI Core算子的默认超时时间为547秒，AI CPU算子的默认超时时间为28秒。
    <!-- end id16 -->
    <!-- npu="910" id17 -->
    - 对于Atlas 训练系列产品，AI Core算子的默认超时时间为68秒，AI CPU算子的默认超时时间为28秒。
    <!-- end id17 -->

- 由于不同产品型号的架构差异，AI Core算子、AI CPU算子的最大超时时间有所不同：
    <!-- npu="950,A3,910b" id18 -->
    - 对于Ascend 950PR/Ascend 950DT、Atlas A3 训练系列产品/Atlas A3 推理系列产品、Atlas A2 训练系列产品/Atlas A2 推理系列产品，AI Core算子、AI CPU算子最大超时时间为interval \* 254，单位是微秒，interval可通过aclrtGetOpTimeoutInterval接口获取。
    <!-- end id18 -->   
    <!-- npu="310b" id19 -->
    - 对于Atlas 200I/500 A2 推理产品，AI Core算子、AI CPU算子最大超时时间为1091秒。
    <!-- end id19 -->
    <!-- npu="310p" id20 -->
    - 对于Atlas 推理系列产品，AI Core算子的最大超时时间为547秒，AI CPU算子的最大超时时间不支持设置。
    <!-- end id20 -->
    <!-- npu="910" id21 -->
    - 对于Atlas 训练系列产品，AI Core算子、AI CPU算子最大超时时间为2176秒。
    <!-- end id21 -->
<!-- end id11 -->

<br>
<br>
<br>

<a id="aclrtSetOpExecuteTimeOutV2"></a>

## aclrtSetOpExecuteTimeOutV2

```c
aclError aclrtSetOpExecuteTimeOutV2(uint64_t timeout,  uint64_t *actualTimeout)
```

### 产品支持情况

<!-- npu="950" id1254 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1254 -->
<!-- npu="A3" id1255 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1255 -->
<!-- npu="910b" id1256 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1256 -->
<!-- npu="310b" id1257 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1257 -->
<!-- npu="310p" id1258 -->
- Atlas 推理系列产品：支持
<!-- end id1258 -->
<!-- npu="910" id1259 -->
- Atlas 训练系列产品：支持
<!-- end id1259 -->
<!-- npu="IPV350" id1260 -->
- IPV350：不支持
<!-- end id1260 -->
<!-- @ref: runtime/res/docs/zh/api_ref/12_execution_control_res.md#id7 -->

### 功能说明

设置算子执行的超时时间，单位为微秒。如果算子下发时携带了超时时间，则该超时时间优先级高于本接口设置的超时时间。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| timeout | 输入 | 设置超时时间，单位为微秒。<br>将该参数设置为0时，表示使用最大超时时间。<br> 当调用aclrtGetOpTimeOutInterval接口获取的时间间隔小于100000微妙，并且timeout参数设置为0时，表示AI Core算子将永不超时。 |
| actualTimeout | 输出 | 返回实际生效的超时时间，单位为微秒。<br> 如果AI Core算子永不超时，则该参数输出的值为uint64_t的最大值。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

<!-- npu="950,A3,910b" id22 -->
对于Ascend 950PR/Ascend 950DT、Atlas A3 训练系列产品/Atlas A3 推理系列产品、Atlas A2 训练系列产品/Atlas A2 推理系列产品，当调用aclrtGetOpTimeoutInterval接口获取的时间间隔小于100000微秒，并且将timeout参数值设置为0时，表示AI Core算子将永不超时，此时，actualTimeout参数输出的值为uint64\_t的最大值。
<!-- end id22 -->

<!-- npu="910,310p,310b" id23 -->
对于Atlas 200I/500 A2 推理产品、Atlas 推理系列产品、Atlas 训练系列产品，调用本接口只能设置AI Core算子执行的超时时间。
<!-- end id23 -->

<!-- @ref: runtime/res/docs/zh/api_ref/12_execution_control_res.md#id17 -->

<br>
<br>
<br>

<a id="aclrtSetOpExecuteTimeOutWithMs"></a>

## aclrtSetOpExecuteTimeOutWithMs

```c
aclError aclrtSetOpExecuteTimeOutWithMs(uint32_t timeout)
```

### 产品支持情况

<!-- npu="950" id1884 -->
- Ascend 950PR/Ascend 950DT：不支持
<!-- end id1884 -->
<!-- npu="A3" id1885 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：不支持
<!-- end id1885 -->
<!-- npu="910b" id1886 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：不支持
<!-- end id1886 -->
<!-- npu="310b" id1887 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id1887 -->
<!-- npu="310p" id1888 -->
- Atlas 推理系列产品：不支持
<!-- end id1888 -->
<!-- npu="910" id1889 -->
- Atlas 训练系列产品：不支持
<!-- end id1889 -->
<!-- npu="IPV350" id1890 -->
- IPV350：不支持
<!-- end id1890 -->
<!-- @ref: runtime/res/docs/zh/api_ref/12_execution_control_res.md#id8 -->

### 功能说明

设置算子执行的超时时间，单位为毫秒。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| timeout | 输入 | 设置超时时间，单位为毫秒。将该参数设置为0时，表示使用最大超时时间。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<!-- @ref: runtime/res/docs/zh/api_ref/12_execution_control_res.md#id18 -->

<br>
<br>
<br>

<a id="aclrtGetOpExecuteTimeout"></a>

## aclrtGetOpExecuteTimeout

```c
aclError aclrtGetOpExecuteTimeout(uint32_t *const timeoutMs)
```

### 产品支持情况

<!-- npu="950" id449 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id449 -->
<!-- npu="A3" id450 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id450 -->
<!-- npu="910b" id451 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id451 -->
<!-- npu="310b" id452 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id452 -->
<!-- npu="310p" id453 -->
- Atlas 推理系列产品：支持
<!-- end id453 -->
<!-- npu="910" id454 -->
- Atlas 训练系列产品：支持
<!-- end id454 -->
<!-- npu="IPV350" id455 -->
- IPV350：不支持
<!-- end id455 -->
<!-- @ref: runtime/res/docs/zh/api_ref/12_execution_control_res.md#id9 -->

### 功能说明

获取AI Core算子执行的超时时间。

<!-- npu="950,A3,910b" id24 -->
对于Ascend 950PR/Ascend 950DT、Atlas A3 训练系列产品/Atlas A3 推理系列产品、Atlas A2 训练系列产品/Atlas A2 推理系列产品，如果AI Core算子永不超时，则该参数输出的值为uint32_t的最大值。
<!-- end id24 -->

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| timeoutMs | 输出 | 超时时间，单位为毫秒。<br>若已调用set接口（例如aclrtSetOpExecuteTimeOut）设置过超时时间，则返回硬件的实际超时时间，否则，返回AI Core的默认超时时间。|

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtGetThreadLastTaskId"></a>

## aclrtGetThreadLastTaskId

```c
aclError aclrtGetThreadLastTaskId(uint32_t *taskId)
```

### 产品支持情况

<!-- npu="950" id3333 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3333 -->
<!-- npu="A3" id3334 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3334 -->
<!-- npu="910b" id3335 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3335 -->
<!-- npu="310b" id3336 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id3336 -->
<!-- npu="310p" id3337 -->
- Atlas 推理系列产品：支持
<!-- end id3337 -->
<!-- npu="910" id3338 -->
- Atlas 训练系列产品：支持
<!-- end id3338 -->
<!-- npu="IPV350" id3339 -->
- IPV350：不支持
<!-- end id3339 -->
<!-- @ref: runtime/res/docs/zh/api_ref/12_execution_control_res.md#id10 -->

### 功能说明

获取当前线程的最后一个下发的Task ID。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| taskId | 输出 | 当前线程的最后一个下发的Task ID。<br>此处的Task表示由用户显式创建的Stream上下发的Task。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtReduceAsync"></a>

## aclrtReduceAsync

```c
aclError aclrtReduceAsync(void *dst, const void *src, uint64_t count, aclrtReduceKind kind, aclDataType type, aclrtStream stream, void *reserve)
```

### 产品支持情况

<!-- npu="950" id2122 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2122 -->
<!-- npu="A3" id2123 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2123 -->
<!-- npu="910b" id2124 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2124 -->
<!-- npu="310b" id2125 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2125 -->
<!-- npu="310p" id2126 -->
- Atlas 推理系列产品：支持
<!-- end id2126 -->
<!-- npu="910" id2127 -->
- Atlas 训练系列产品：支持
<!-- end id2127 -->
<!-- npu="IPV350" id2128 -->
- IPV350：不支持
<!-- end id2128 -->
<!-- @ref: runtime/res/docs/zh/api_ref/12_execution_control_res.md#id11 -->

### 功能说明

执行Reduce操作，包括SUM、MIN、MAX等。异步接口。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| dst | 输入 | 目的内存地址指针。 |
| src | 输入 | 源内存地址指针。 |
| count | 输入 | 源内存大小，单位为Byte。 |
| kind | 输入 | 操作类型。类型定义请参见[aclrtReduceKind](25-02_Enumerations.md#aclrtReduceKind)。 |
| type | 输入 | 数据类型。类型定义请参见[aclDataType](25-02_Enumerations.md#aclDataType)。 |
| stream | 输入 | 指定执行Reduce操作任务的Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |
| reserve | 输入 | 预留参数。当前固定传NULL。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

dts、src必须跟stream所在的Device是同一个设备。

<!-- npu="950" id25 -->
Ascend 950PR/Ascend 950DT支持如下数据类型：int8、int16、int32、uint32、fp16、fp32、bf16。
<!-- end id25 -->

<!-- npu="A3" id26 -->
Atlas A3 训练系列产品/Atlas A3 推理系列产品支持如下数据类型：int8、int16、int32、fp16、fp32、bf16。
<!-- end id26 -->

<!-- npu="910b" id27 -->
Atlas A2 训练系列产品/Atlas A2 推理系列产品支持如下数据类型：int8、int16、int32、fp16、fp32、bf16。
<!-- end id27 -->

<!-- npu="310b" id28 -->
Atlas 200I/500 A2 推理产品支持如下数据类型：int8、int16、int32、fp16、fp32。
<!-- end id28 -->

<!-- npu="310p" id29 -->
Atlas 推理系列产品支持如下数据类型：fp32  、fp16、int16。
<!-- end id29 -->

<!-- npu="910" id30 -->
Atlas 训练系列产品仅支持fp32类型。
<!-- end id30 -->

<!-- @ref: runtime/res/docs/zh/api_ref/12_execution_control_res.md#id19 -->

<br>
<br>
<br>

<a id="aclrtLaunchHostFunc"></a>

## aclrtLaunchHostFunc

```c
aclError aclrtLaunchHostFunc(aclrtStream stream, aclrtHostFunc fn, void *args)
```

### 产品支持情况

<!-- npu="950" id1975 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1975 -->
<!-- npu="A3" id1976 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1976 -->
<!-- npu="910b" id1977 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1977 -->
<!-- npu="310b" id1978 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1978 -->
<!-- npu="310p" id1979 -->
- Atlas 推理系列产品：支持
<!-- end id1979 -->
<!-- npu="910" id1980 -->
- Atlas 训练系列产品：支持
<!-- end id1980 -->
<!-- npu="IPV350" id1981 -->
- IPV350：不支持
<!-- end id1981 -->
<!-- @ref: runtime/res/docs/zh/api_ref/12_execution_control_res.md#id12 -->

### 功能说明

在Stream的任务队列中下发一个Host回调任务，系统内部在执行到该回调任务时，会在Stream上注册的线程（该线程在本接口内部创建并注册）中执行回调函数，并且回调任务默认阻塞本Stream上后续任务的执行。异步接口。

本接口可用于实现异步场景下的callback功能，与另一套实现异步场景下的callback功能接口（[aclrtLaunchCallback](#aclrtLaunchCallback)、[aclrtSubscribeReport](#aclrtSubscribeReport)、[aclrtProcessReport](#aclrtProcessReport)、[aclrtUnSubscribeReport](#aclrtUnSubscribeReport)）的差别在于：使用aclrtLaunchCallback等接口时，Stream上注册的线程需由用户自行创建并通过[aclrtSubscribeReport](#aclrtSubscribeReport)接口注册，另外也可以指定回调任务是否阻塞本Stream上后续任务的执行。

对于同一个Stream，两套实现异步场景下的callback功能的接口不能混用，否则可能出现异常。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 指定执行回调任务的Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |
| fn | 输入 | 指定要增加的回调函数。<br>回调函数的函数原型为：<br>typedef void (*aclrtHostFunc)(void*args) |
| args | 输入 | 待传递给回调函数的用户数据。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

回调函数涉及共享资源（例如锁），因此在使用回调函数需慎重，不应该调用资源申请、资源释放、Stream同步、Device同步、任务下发、任务终止等接口，否则可能导致错误或死锁。

<br>
<br>
<br>

<a id="aclrtRandomNumAsync"></a>

## aclrtRandomNumAsync

```c
aclError aclrtRandomNumAsync(const aclrtRandomNumTaskInfo *taskInfo, const aclrtStream stream, void *reserve)
```

### 产品支持情况

<!-- npu="950" id2948 -->
- Ascend 950PR/Ascend 950DT：不支持
<!-- end id2948 -->
<!-- npu="A3" id2949 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2949 -->
<!-- npu="910b" id2950 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2950 -->
<!-- npu="310b" id2951 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id2951 -->
<!-- npu="310p" id2952 -->
- Atlas 推理系列产品：不支持
<!-- end id2952 -->
<!-- npu="910" id2953 -->
- Atlas 训练系列产品：不支持
<!-- end id2953 -->
<!-- npu="IPV350" id2954 -->
- IPV350：不支持
<!-- end id2954 -->
<!-- @ref: runtime/res/docs/zh/api_ref/12_execution_control_res.md#id13 -->

### 功能说明

下发并执行随机数生成任务。异步接口。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| taskInfo | 输入 | 随机数生成任务信息。类型定义请参见[aclrtRandomNumTaskInfo](25-04_Structs.md#aclrtRandomNumTaskInfo)。 |
| stream | 输入 | 执行随机数生成任务的Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |
| reserve | 输入 | 预留参数。当前固定传NULL。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtTaskUpdateAsync"></a>

## aclrtTaskUpdateAsync

```c
aclError aclrtTaskUpdateAsync(aclrtStream taskStream, uint32_t taskId, aclrtTaskUpdateInfo *info, aclrtStream execStream)
```

### 产品支持情况

<!-- npu="950" id3018 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3018 -->
<!-- npu="A3" id3019 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3019 -->
<!-- npu="910b" id3020 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3020 -->
<!-- npu="310b" id3021 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id3021 -->
<!-- npu="310p" id3022 -->
- Atlas 推理系列产品：支持
<!-- end id3022 -->
<!-- npu="910" id3023 -->
- Atlas 训练系列产品：不支持
<!-- end id3023 -->
<!-- npu="IPV350" id3024 -->
- IPV350：不支持
<!-- end id3024 -->
<!-- @ref: runtime/res/docs/zh/api_ref/12_execution_control_res.md#id14 -->

### 功能说明

刷新目标任务的信息。异步接口。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| taskStream | 输入 | 目标任务所在的Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。<br>此处只支持与模型绑定过的Stream，绑定模型与Stream需调用[aclmdlRIBindStream](15_model_running_instance__management.md#aclmdlRIBindStream)接口。 |
| taskId | 输入 | 目标任务ID。<br>可调用[aclrtGetThreadLastTaskId](#aclrtGetThreadLastTaskId)接口获取任务ID。 |
| info | 输入 | 配置信息。类型定义请参见[aclrtTaskUpdateInfo](25-04_Structs.md#aclrtTaskUpdateInfo)。 |
| execStream | 输入 | 执行刷新任务的Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<!-- npu="950" id31 -->
### 约束说明

Ascend 950PR/Ascend 950DT产品不支持更新ACL_RT_UPDATE_RANDOM_TASK(随机数生成任务)。
<!-- end id31 -->
