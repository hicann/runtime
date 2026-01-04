# aclmdlRICaptureThreadExchangeMode

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于商用产品中。**

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

切换当前线程的捕获模式。

调用本接口会将调用线程的捕获模式设置为\*mode中包含的值，并通过\*mode返回该线程之前设置的模式。

## 函数原型

```
aclError aclmdlRICaptureThreadExchangeMode(aclmdlRICaptureMode *mode)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| mode | 输入&输出 | 捕获模式，用于限制非安全函数（包括aclrtMemset、aclrtMemcpy、aclrtMemcpy2d以及使用非Host锁页内存进行异步内存复制操作的接口，如aclrtMemcpyAsync接口）的作用范围。<br>建议在[aclmdlRICaptureBegin](aclmdlRICaptureBegin.md)和[aclmdlRICaptureEnd](aclmdlRICaptureEnd.md)接口之间调用本接口切换当前线程的模式。各捕获模式的配置说明如下，说明中的其它线程指“没有调用aclmdlRICaptureBegin接口、不在捕获状态”的线程。<br>  - 若aclmdlRICaptureBegin接口将捕获模式设置为ACL_MODEL_RI_CAPTURE_MODE_RELAXED（下文简称RELAXED模式），表示所有线程都可以调用非安全函数，这时即使在其它线程（指不在捕获状态的线程）中调用本接口将捕获模式设置为其它值也不会生效，其它线程还是按照RELAXED模式。<br>  - 若aclmdlRICaptureBegin接口将捕获模式设置为ACL_MODEL_RI_CAPTURE_MODE_THREAD_LOCAL（下文简称THREAD_LOCAL模式），表示当前线程禁止调用非安全函数，但其它线程可以调用非安全函数。如果本线程要调用非安全函数，需调用本接口将当前线程模式切换为RELAXED模式。<br>  - 若aclmdlRICaptureBegin接口将捕获模式设置为ACL_MODEL_RI_CAPTURE_MODE_GLOBAL（下文简称GLOBAL模式），表示所有线程都不可以调用非安全函数。本线程若要调用非安全函数，需调用本接口切换为RELAXED模式，其它线程若要调用非安全函数，需调用本接口切换为RELAXED模式或THREAD_LOCAL模式。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

