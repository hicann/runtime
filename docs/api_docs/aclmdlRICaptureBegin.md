# aclmdlRICaptureBegin

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于商用产品中。**

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

开始捕获Stream上下发的任务。

在aclmdlRICaptureBegin和[aclmdlRICaptureEnd](aclmdlRICaptureEnd.md)接口之间，所有在指定Stream上下发的任务不会立即执行，而是被暂存在系统内部模型运行实例中，只有在调用[aclmdlRIExecute](aclmdlRIExecute.md)或[aclmdlRIExecuteAsync](aclmdlRIExecuteAsync.md)接口执行模型推理时，这些任务才会被真正执行，以此减少Host侧的任务下发开销。所有任务执行完毕后，若无需再使用内部模型，可调用[aclmdlRIDestroy](aclmdlRIDestroy.md)接口及时销毁该资源。

aclmdlRICaptureBegin和[aclmdlRICaptureEnd](aclmdlRICaptureEnd.md)接口要成对使用，且两个接口中的Stream应相同。在这两个接口之间，可以调用[aclmdlRICaptureGetInfo](aclmdlRICaptureGetInfo.md)接口获取捕获信息，调用[aclmdlRICaptureThreadExchangeMode](aclmdlRICaptureThreadExchangeMode.md)接口切换当前线程的捕获模式。此外，在调用[aclmdlRICaptureEnd](aclmdlRICaptureEnd.md)接口之后，还可以调用[aclmdlRIDebugPrint](aclmdlRIDebugPrint.md)接口打印模型信息，这在维护和测试场景下有助于问题定位。

在aclmdlRICaptureBegin和[aclmdlRICaptureEnd](aclmdlRICaptureEnd.md)接口之间捕获的任务，若要更新任务（包含任务本身以及任务的参数信息），则需在[aclmdlRICaptureTaskGrpBegin](aclmdlRICaptureTaskGrpBegin.md)、[aclmdlRICaptureTaskGrpEnd](aclmdlRICaptureTaskGrpEnd.md)接口之间下发后续可能更新的任务，给任务打上任务组的标记，然后在[aclmdlRICaptureTaskUpdateBegin](aclmdlRICaptureTaskUpdateBegin.md)、[aclmdlRICaptureTaskUpdateEnd](aclmdlRICaptureTaskUpdateEnd.md)接口之间更新任务的输入信息。

在aclmdlRICaptureBegin和[aclmdlRICaptureEnd](aclmdlRICaptureEnd.md)接口之间捕获到的任务会暂存在系统内部模型运行实例中，随着任务数量的增加，以及通过Event推导、内部任务的操作，导致更多的Stream进入捕获状态，Stream资源被不断消耗，最终可能会导致并发的调度资源不足，因此需提前规划好调度资源的使用。

## 函数原型

```
aclError aclmdlRICaptureBegin(aclrtStream stream, aclmdlRICaptureMode mode)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| stream | 输入 | 指定Stream。 |
| mode | 输入 | 捕获模式，用于限制非安全函数（包括aclrtMemset、aclrtMemcpy、aclrtMemcpy2d以及使用非Host锁页内存进行异步内存复制操作的接口，如aclrtMemcpyAsync接口）的调用范围。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

