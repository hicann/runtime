# aclrtSetDevice

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

指定当前线程中用于运算的Device。

## 函数原型

```
aclError aclrtSetDevice(int32_t deviceId)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| deviceId | 输入 | Device ID。<br>用户调用[aclrtGetDeviceCount](aclrtGetDeviceCount.md)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)] |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

-   调用aclrtSetDevice接口指定运算的Device后，若不使用Device上的资源时，可调用[aclrtResetDevice](aclrtResetDevice.md)或[aclrtResetDeviceForce](aclrtResetDeviceForce.md)接口及时释放本进程使用的Device资源（若不调用这两个接口，功能上不会有问题，因为在进程退出时也会释放本进程使用的Device资源）：
    -   若调用[aclrtResetDevice](aclrtResetDevice.md)接口释放Device资源：

        aclrtResetDevice接口内部涉及引用计数的实现，建议aclrtResetDevice接口与[aclrtSetDevice](aclrtSetDevice.md)接口配对使用，aclrtSetDevice接口每被调用一次，则引用计数加一，aclrtResetDevice接口每被调用一次，则该引用计数减一，当引用计数减到0时，才会真正释放Device上的资源。

    -   若调用[aclrtResetDeviceForce](aclrtResetDeviceForce.md)接口释放Device资源：

        aclrtResetDeviceForce接口可与aclrtSetDevice接口配对使用，也可不与aclrtSetDevice接口配对使用，若不配对使用，一个进程中，针对同一个Device，调用一次或多次aclrtSetDevice接口后，仅需调用一次aclrtResetDeviceForce接口可释放Device上的资源。

-   在不同进程或线程中支持调用aclrtSetDevice接口指定同一个Device用于运算。在同一个进程中的多个线程中，如果调用aclrtSetDevice接口指定同一个Device用于运算，这时隐式创建的默认Context是同一个。
-   多Device场景下，可在进程中通过aclrtSetDevice接口切换到其它Device，也可以调用[aclrtSetCurrentContext](aclrtSetCurrentContext.md)接口通过切换Context来切换Device。
-   调用本接口会隐式创建默认Context，该默认Context中包含1个默认Stream。

