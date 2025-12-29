# acltdtGrantQueue

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | ☓ |

## 功能说明

进程间需要共享队列信息时，可以调用本接口给其它进程授予队列相关的权限，例如Enqueue（指向队列中添加数据）权限、Dequeue（指从队列中获取数据）权限等。

进程间传递队列相关信息时，安全性由用户保证。

## 函数原型

```
aclError acltdtGrantQueue(uint32_t qid, int32_t pid, uint32_t permission, int32_t timeout)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| qid | 输入 | 队列ID。 |
| pid | 输入 | 被授权进程的ID。 |
| permission | 输入 | 权限标识（队列生产者/消费者）。<br>用户选择如下多个宏进行逻辑或（例如：ACL_TDT_QUEUE_PERMISSION_DEQUEUE | ACL_TDT_QUEUE_PERMISSION_ENQUEUE），作为permission参数值。每个宏表示某一权限，详细说明如下：<br><br>  - ACL_TDT_QUEUE_PERMISSION_MANAGE：表示队列的管理权限。<br>  - ACL_TDT_QUEUE_PERMISSION_DEQUEUE：表示Dequeue权限。<br>  - ACL_TDT_QUEUE_PERMISSION_ENQUEUE：表示Enqueue权限。 |
| timeout | 输入 | 等待超时时间，取值范围如下：<br>  - -1：阻塞方式，一直等待直到数据成功加入队列。<br>  - 0：非阻塞方式，立即返回。<br>  - >0：配置具体的超时时间，单位为毫秒，等达到超时时间后返回报错。超时时间受操作系统影响，一般偏差在操作系统的一个时间片内，例如，操作系统的一个时间片为4ms，用户设置的超时时间为1ms，则实际的超时时间在1ms到5ms范围内。在CPU负载高场景下，超时时间仍可能存在波动。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

