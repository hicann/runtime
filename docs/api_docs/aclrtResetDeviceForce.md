# aclrtResetDeviceForce

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

复位当前运算的Device，释放Device上的资源。释放的资源包括默认Context、默认Stream以及默认Context下创建的所有Stream。若默认Context或默认Stream下的任务还未完成，系统会等待任务完成后再释放。

aclrtResetDeviceForce接口可与aclrtSetDevice接口配对使用，也可不与aclrtSetDevice接口配对使用，若不配对使用，一个进程中，针对同一个Device，调用一次或多次aclrtSetDevice接口后，仅需调用一次aclrtResetDeviceForce接口可释放Device上的资源。

```
# 与aclrtSetDevice接口配对使用：
aclrtSetDevice(1) -> aclrtResetDeviceForce(1) -> aclrtSetDevice(1) -> aclrtResetDeviceForce(1)
 
# 与aclrtSetDevice接口不配对使用：
aclrtSetDevice(1) -> aclrtSetDevice(1) -> aclrtResetDeviceForce(1)
```

## 函数原型

```
aclError aclrtResetDeviceForce(int32_t deviceId)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| deviceId | 输入 | Device ID。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

-   多线程场景下，针对同一个Device，如果每个线程中都调用[aclrtSetDevice](aclrtSetDevice.md)接口、aclrtResetDeviceForce接口，如下所示，线程2中的aclrtResetDeviceForce接口会返回报错，因为线程1中aclrtResetDeviceForce接口已经释放了Device 1的资源：

    ```
    时间线 ----------------------------------------------------------------------------->
    线程1：aclrtSetDevice(1)           aclrtResetDeviceForce(1)
    线程2：aclrtSetDevice(1)                                   aclrtResetDeviceForce(1)
    ```

    多线程场景下，正确方式是应在线程执行的最后，调用一次aclrtResetDeviceForce释放Device资源，如下所示：

    ```
    时间线 ----------------------------------------------------------------------------->
    线程1：aclrtSetDevice(1)    
    线程2：aclrtSetDevice(1)                                   aclrtResetDeviceForce(1)
    ```

-   [aclrtResetDevice](aclrtResetDevice.md)接口与aclrtResetDeviceForce接口可以混用，但混用时，若两个Reset接口的调用次数、调用顺序不对，接口会返回报错。

    ```
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

