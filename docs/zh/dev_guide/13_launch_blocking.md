# Launch Blocking同步执行模式

Runtime的Kernel下发与模型执行接口默认采用异步模式：接口完成任务下发后立即返回，不等待任务在Device上执行完成，详见[异步任务总述](03-01_asynchronous_task_overview.md)。由此带来的问题是，任务执行出错的报错时机被延迟：错误只能在后续同步点暴露，无法归属到具体是哪一次下发、哪个Kernel出错。

将环境变量`ASCEND_RT_LAUNCH_BLOCKING`配置为1后，Kernel下发与模型执行接口切换为同步模式：接口等待任务执行完成后才返回，任务执行出错会在调用点立即报错，可精确定位出错的Kernel及其所在的Stream。该功能用于算子调试场景，环境变量的详细说明请参见[ASCEND_RT_LAUNCH_BLOCKING](../env_vars/ASCEND_RT_LAUNCH_BLOCKING.md)。

> **注意：**
>
> - 同步模式会显著影响业务性能，仅建议在算子调试场景下开启，不建议在生产环境开启。
> - 同步模式改变了任务下发的时序。在单线程下发多个有依赖关系任务的场景下（典型如多Stream并发的复合算子内部），可能产生死锁。死锁副作用与规避方案见下文。
> - 该环境变量不支持动态修改，需在调用任意Runtime接口前完成配置。

本文代码示例仅展示关键调用逻辑，不可直接编译运行，仅供参考。

## 使用场景

### 场景一：精确定位执行出错的Kernel

默认异步模式下，多个Kernel下发后立即返回，执行错误延迟到同步点才暴露，无法区分错误来自哪个Kernel：

```c
// 默认异步模式：下发即返回，错误延迟到同步点暴露
aclrtLaunchKernelWithHostArgs(funcA, numBlocks, mainStream, nullptr, argsA, argsSizeA, nullptr, 0);
aclrtLaunchKernelWithHostArgs(funcB, numBlocks, mainStream, nullptr, argsB, argsSizeB, nullptr, 0);
// funcB内部存在越界访问，但此处无任何报错
aclrtLaunchKernelWithHostArgs(funcC, numBlocks, mainStream, nullptr, argsC, argsSizeC, nullptr, 0);
aclrtSynchronizeStream(mainStream);
// 此处报错，但无法区分是funcA、funcB还是funcC执行出错
```

开启同步模式后，每次下发都会等待该任务执行完成，任务出错会立即在调用点返回错误，无需借助调试器即可定位到出错Kernel：

```bash
export ASCEND_RT_LAUNCH_BLOCKING=1
```

```c
// 同步模式：等待执行完成后才返回
aclrtLaunchKernelWithHostArgs(funcA, numBlocks, mainStream, nullptr, argsA, argsSizeA, nullptr, 0);
// funcA执行完成，无错误

aclrtLaunchKernelWithHostArgs(funcB, numBlocks, mainStream, nullptr, argsB, argsSizeB, nullptr, 0);
// funcB执行出错，立即在调用点报错，明确归属到funcB
```

同步模式下，Device侧执行错误会体现在接口返回值以及aclrtGetLastError获取的线程错误信息中，错误处理方式参见[异常处理](10_runtime_troubleshooting.md)。

### 场景二：多Stream场景下的错误归属

多Stream场景下，异步模式的报错无法区分出错的Kernel和Stream。开启同步模式后，每次下发都等待本Stream任务执行完成，错误可精确归属：

```c
// 同步模式
aclrtLaunchKernelWithHostArgs(funcA, numBlocks, stream1, nullptr, argsA, argsSizeA, nullptr, 0);
// funcA在stream1上执行完成，无错误
aclrtLaunchKernelWithHostArgs(funcB, numBlocks, stream2, nullptr, argsB, argsSizeB, nullptr, 0);
// funcB执行出错，立即报错，明确归属到stream2上的funcB
```

## 作用范围

开启同步模式后，仅对下述接口生效；调用这些接口下发任务时，需等待任务执行完成才返回。

- aclrtLaunchKernel
- aclrtLaunchKernelV2
- aclrtLaunchKernelWithConfig
- aclrtLaunchKernelWithHostArgs
- aclrtLaunchKernelWithArgsArray
- aclrtLaunchSIMTKernelWithArgsArray
- aclrtLaunchSIMTKernelWithHostArgs
- aclmdlRIExecuteAsync

混合编程的`<<< >>>`语法最终通过上述LaunchKernel接口族下发，同样受本功能影响。


## 死锁副作用

开启同步模式下会有算子下发死锁副作用。死锁本质上发生在这种中间状态：**Host线程正在同步等待某任务执行完成，而该任务（或其前序任务）依赖的任务尚未下发，且下发动作又被Host的同步等待阻塞**。

典型时序如下（单线程向两条Stream下发有依赖关系的任务）：

```c
// 1. 主流下发funcA：funcA会与稍侯在从流的funcB 存在依赖关系
aclrtLaunchKernelWithHostArgs(funcA, numBlocks, mainStream, ...);   // 同步模式下，Host在此阻塞等待funcA执行完成

// 永远执行不到这里：
aclrtLaunchKernelWithHostArgs(funcB, numBlocks, subStream, ...);    // 下发了funcB，才能解开funcA依赖
```

循环等待链路为：Host等待funcA执行完成 → funcA等待funcB → funcB等待Host下发 → 死锁。
举例：在通信与计算融合算子中就会使用到采用主流下发AI Core算子，从流下发AI CPU算子，两个算子互相依赖协作完成通算功能。

泛化结论：只要业务借助任务异步下发机制，由单线程向多条Stream下发多个有依赖关系的任务（例如先下发的任务依赖后下发任务的场景），开启ASCEND_RT_LAUNCH_BLOCKING模式就可能死锁。

## APP开发者：使用方案与死锁规避

### 基本用法

调试场景下直接配置环境变量后运行业务即可：

```bash
export ASCEND_RT_LAUNCH_BLOCKING=1
./app    # 出错任务会在调用点立即报错；若程序卡死不再推进，按本节方案规避死锁
```

### 遇到死锁时的处理

较早版本的算子可能未适配同步模式（算子内部存在上述依赖任务下发时序），开启环境变量后会卡死。可按以下方案处理，按优先程度排列：

**方案一（推荐）：升级已适配的算子版本。** 已适配的算子内部已通过"多流并发算子开发者：死锁规避方案"章节中的方案处理了依赖下发时序，将算子包升级到与Runtime配套的版本（算子版本与Runtime版本拉齐）即可。

**方案二：不配置环境变量，仅对APP要调试算子的下发Stream开启同步模式** ，并对会死锁的算子通过NonBlocking Begin/End区间包裹，样例如下：

```c
// 不配置ASCEND_RT_LAUNCH_BLOCKING，仅对APP的Stream开启同步模式
aclrtStreamAttrValue attrValue;
attrValue.launchBlockingMode = ACL_STREAM_LAUNCH_BLOCKING_MODE_BLOCKING;
aclrtSetStreamAttribute(mainStream, ACL_STREAM_LAUNCH_BLOCKING_MODE, &attrValue);

// APP自己的Kernel：同步模式，执行错误立即在调用点暴露
aclrtLaunchKernelWithHostArgs(funcA, numBlocks, mainStream, nullptr, argsA, argsSizeA, nullptr, 0);

// 调用可能未适配的第三方算子/旧版复合算子：用Begin/End包裹，规避死锁
aclrtNonBlockingLaunchBegin(mainStream, 0);
CallLegacyCompositeOp(mainStream);   // 算子内部多Stream下发保持异步，不阻塞Host
aclrtNonBlockingLaunchEnd(mainStream, 0);   // 此处等待mainStream上已下发任务执行完成
// 恢复同步模式

aclrtLaunchKernelWithHostArgs(funcB, numBlocks, mainStream, nullptr, argsB, argsSizeB, nullptr, 0);
```

## 多流并发算子开发者：死锁规避方案

### 适用对象

单个算子（或一个复合下发流程）内部创建多条Stream，并向不同Stream下发有依赖关系的多个任务。此类实现在同步模式下存在死锁风险，需按本节规范适配。

### 规避原则

同步模式的死锁发生在Host批量下发相互依赖任务、尚未下发完毕的中间状态（成因见上文[死锁副作用](#死锁副作用)）。规避思路只有两条：要么让同步等待落在安全的时机（所有任务已下发完毕），要么让中间状态下的下发保持异步。按任务间依赖关系，分为三种模式：


| 模式               | 适用依赖关系                 | 做法                                                                                           |
| ------------------ | ---------------------------- | ---------------------------------------------------------------------------------------------- |
| 依赖排序           | 任务间单向依赖               | 按依赖拓扑序下发：先下发被依赖的任务，后下发依赖方任务，全程保持同步模式                       |
| 从流异步、主流同步 | 任务间相互依赖 | 先下发的任务通过从流属性保持异步；最后下发的主流任务保持同步模式，对外体现整算子的同步语义 |
| 从流异步、主流区间异步 | 多条从流间也存在复杂依赖 | 从流下发过程全部保持异步；下发完成后由算子显式同步主流，对外体现整算子的同步语义                   |

**前提要求：无论哪种模式，最后执行同步等待的任务，其依赖的所有任务必须已下发完毕。**

### 模式一：依赖排序（单向依赖）

任务间依赖单向（后下发的任务依赖先下发的任务）时，按拓扑序下发即可，无需任何额外接口。同步模式下每次下发等待任务执行完成，后下发的任务所依赖的任务必然已完成：

```c
// funcA（subStream）产出数据，funcB（mainStream）消费funcA的产出：单向依赖
// 先下发被依赖的funcA，后下发依赖方funcB
aclrtLaunchKernelWithHostArgs(funcA, numBlocks, subStream, nullptr, argsA, argsSizeA, nullptr, 0);
// 同步模式，funcA执行完成后返回
aclrtLaunchKernelWithHostArgs(funcB, numBlocks, mainStream, nullptr, argsB, argsSizeB, nullptr, 0);
// funcB依赖的funcA已完成，不会出现循环等待
```

### 模式二：从流异步、主流同步

下发序列内部存在"先下发的任务依赖后下发的任务"的反向依赖时，让先下发的任务保持异步，由最后下发的任务体现同步语义：

```c
// 创建的从流设置为异步模式：该流上的下发不阻塞Host
aclrtStreamAttrValue attrValue;
attrValue.launchBlockingMode = ACL_STREAM_LAUNCH_BLOCKING_MODE_NON_BLOCKING;
aclrtSetStreamAttribute(subStream, ACL_STREAM_LAUNCH_BLOCKING_MODE, &attrValue);

void CompositeOpLaunch(aclrtStream mainStream, aclrtStream subStream)
{   
    // 先下发subStream上的任务：异步模式，不阻塞Host，后续任务可继续下发
    aclrtLaunchKernelWithHostArgs(funcB, numBlocks, subStream, nullptr, argsB, argsSizeB, nullptr, 0);

    // 最后下发mainStream上的任务：保持同步模式，等待执行完成后返回
    // 此时所有任务均已下发完毕，同步等待不会阻碍任何任务下发，无死锁风险
    // 对外即体现为整算子的同步语义
    aclrtLaunchKernelWithHostArgs(funcA, numBlocks, mainStream, nullptr, argsA, argsSizeA, nullptr, 0);
}
```

### 模式三：从流异步、主流区间异步

多条从Stream之间存在复杂依赖时，将整个下发过程置于异步区间内，下发完成后通过`aclrtNonBlockingLaunchEnd`的同步行为（或显式调用流同步接口）对外体现整算子的同步语义：

```c
// 创建的从流全部设置为异步模式
aclrtStreamAttrValue attrValue;
attrValue.launchBlockingMode = ACL_STREAM_LAUNCH_BLOCKING_MODE_NON_BLOCKING;
aclrtSetStreamAttribute(subStream1, ACL_STREAM_LAUNCH_BLOCKING_MODE, &attrValue);
aclrtSetStreamAttribute(subStream2, ACL_STREAM_LAUNCH_BLOCKING_MODE, &attrValue);

void CompositeOpLaunch(aclrtStream mainStream, aclrtStream subStream1, aclrtStream subStream2)
{   
    // 主流进入异步区间：区间内通过LaunchKernel系列接口的下发均不阻塞
    aclrtNonBlockingLaunchBegin(mainStream, 0);
    aclrtLaunchKernelWithHostArgs(func1, numBlocks, mainStream, nullptr, args1, argsSize1, nullptr, 0);
    aclrtLaunchKernelWithHostArgs(func2, numBlocks, subStream1, nullptr, args2, argsSize2, nullptr, 0);
    aclrtLaunchKernelWithHostArgs(func3, numBlocks, subStream2, nullptr, args3, argsSize3, nullptr, 0);
    // End：若主流处于同步模式（环境变量开启或流属性设置为同步），此处等待mainStream上
    // 已下发任务执行完成后返回，对外体现整算子的同步语义
    aclrtNonBlockingLaunchEnd(mainStream, 0);
}
```

### 编程规范

适配同步模式时，多流并发算子开发者须遵守以下规范：

1. **主流同步须代表全部子任务完成。** 从Stream上的任务必须通过Event/Notify等机制与主流建立依赖，保证对主流的同步等待能够覆盖算子的全部子任务，否则对外无法正确体现整算子的同步语义。
2. **异步区间按Stream生效，不按线程生效。** 上层框架（如推理框架）可能存在异步下发线程，因此区间状态以Stream为粒度维护。`aclrtNonBlockingLaunchBegin`与`aclrtNonBlockingLaunchEnd`须成对调用，两个接口传入的Stream应相同，并建议在同一线程中成对调用。
3. **异步区间支持嵌套。** APP层与算子内部都可以包裹区间（例如APP包裹多个算子的下发），每调用一次Begin需对应调用一次End，全部Begin结束后Stream才恢复同步语义，End在恢复同步语义时会执行一次同步等待。
4. **异步区间内可包含多个算子的下发**，不要求区间仅包裹单个算子。
5. **优先级：异步区间 > 流属性 > 环境变量。** `aclrtNonBlockingLaunchBegin` 设置的异步模式优先级高于 `ASCEND_RT_LAUNCH_BLOCKING` 环境变量与 `ACL_STREAM_LAUNCH_BLOCKING_MODE` 流属性；未配置环境变量时，可通过流属性 `ACL_STREAM_LAUNCH_BLOCKING_MODE` 独立控制对应Stream的执行模式（默认值 `ACL_STREAM_LAUNCH_BLOCKING_MODE_CTRL_BY_ENV`，表示该流由环境变量控制执行模式）。