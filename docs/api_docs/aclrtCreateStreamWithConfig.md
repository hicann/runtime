# aclrtCreateStreamWithConfig

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

在当前进程或线程中创建Stream。

Atlas A3 训练系列产品/Atlas A3 推理系列产品，相比[aclrtCreateStream](aclrtCreateStream.md)接口，使用本接口可以创建一个快速下发任务的Stream，但会增加内存消耗或CPU的性能消耗。

Atlas A2 训练系列产品/Atlas A2 推理系列产品，相比[aclrtCreateStream](aclrtCreateStream.md)接口，使用本接口可以创建一个快速下发任务的Stream，但会增加内存消耗或CPU的性能消耗。

## 函数原型

```
aclError aclrtCreateStreamWithConfig(aclrtStream *stream, uint32_t priority, uint32_t flag)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| stream | 输出 | Stream的指针。 |
| priority | 输入 | 优先级。<br>对以下产品，该参数为预留参数，暂不使用，当前固定设置为0：<br><br>  - Atlas A3 训练系列产品/Atlas A3 推理系列产品<br>  - Atlas A2 训练系列产品/Atlas A2 推理系列产品 |
| flag | 输入 | Stream指针的flag。<br>flag既支持配置单个宏，也支持配置多个宏位或（例如ACL_STREAM_FAST_LAUNCH | ACL_STREAM_FAST_SYNC）。对于不支持位或的宏，本接口会返回报错。配置其他值创建出来的Stream等同于通过[aclrtCreateStream](aclrtCreateStream.md)接口创建出来的Stream。<br>flag参数值请参见“flag取值说明”。 |

## flag取值说明

-   **ACL\_STREAM\_FAST\_LAUNCH**：使用该flag创建出来的Stream，在使用Stream时，下发任务的速度更快。

    相比[aclrtCreateStream](aclrtCreateStream.md)接口创建出来的Stream，在使用Stream时才会申请系统内部资源，导致下发任务的时长增加，使用本接口的**ACL\_STREAM\_FAST\_LAUNCH**模式创建Stream时，会在创建Stream时预申请系统内部资源，因此创建Stream的时长增加，下发任务的时长缩短，总体来说，创建一次Stream，使用多次的场景下，总时长缩短，但创建Stream时预申请内部资源会增加内存消耗。

    ```
    #define ACL_STREAM_FAST_LAUNCH      0x00000001U
    ```

-   **ACL\_STREAM\_FAST\_SYNC**：使用该flag创建出来的Stream，在调用[aclrtSynchronizeStream](aclrtSynchronizeStream.md)接口时，会阻塞当前线程，主动查询任务的执行状态，一旦任务完成，立即返回。

    相比[aclrtCreateStream](aclrtCreateStream.md)接口创建出来的Stream，在调用[aclrtSynchronizeStream](aclrtSynchronizeStream.md)接口时，会一直被动等待Device上任务执行完成的通知，等待时间长，使用本接口的**ACL\_STREAM\_FAST\_SYNC**模式创建的Stream，没有被动等待，总时长缩短，但主动查询的操作会增加CPU的性能消耗。

    ```
    #define ACL_STREAM_FAST_SYNC        0x00000002U
    ```

-   **ACL\_STREAM\_PERSISTENT**：使用该flag创建出来的Stream，在该Stream上下发的任务不会立即执行、任务执行完成后也不会立即销毁，在销毁Stream时才会销毁任务相关的资源。该方式下创建的Stream用于与模型绑定，适用于模型构建场景，模型构建相关接口的说明请参见[aclmdlRIBindStream](aclmdlRIBindStream.md)。

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

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

