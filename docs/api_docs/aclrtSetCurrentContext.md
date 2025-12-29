# aclrtSetCurrentContext

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

设置线程的Context。

## 函数原型

```
aclError aclrtSetCurrentContext(aclrtContext context)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| context | 输入 | 指定线程当前的Context。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

-   支持以下场景：
    -   如果在某线程（例如：thread1）中调用[aclrtCreateContext](aclrtCreateContext.md)接口显式创建一个Context（例如：ctx1），则可以不调用aclrtSetCurrentContext接口指定该线程的Context，系统默认将ctx1作为thread1的Context。
    -   如果没有调用[aclrtCreateContext](aclrtCreateContext.md)接口显式创建Context，则系统将默认Context作为线程的Context，此时，不能通过[aclrtDestroyContext](aclrtDestroyContext.md)接口来释放默认Context。
    -   如果多次调用aclrtSetCurrentContext接口设置线程的Context，以最后一次为准。

-   若给线程设置的Context所对应的Device已经被复位，则不能将该Context设置为线程的Context，否则会导致业务异常。
-   推荐在某一线程中创建的Context，在该线程中使用。若在线程A中调用[aclrtCreateContext](aclrtCreateContext.md)接口创建Context，在线程B中使用该Context，则需由用户自行保证两个线程中同一个Context下同一个Stream中任务执行的顺序。

