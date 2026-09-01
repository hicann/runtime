# EE1024 Execution\_Error\_Stream\_Synchronize\_Timeout

## 错误信息

报错格式如下，占位符%s的含义依次为报错阶段、device ID、OOM检测时间窗：

```text
%s failed. Reason: AI CPU operator execution timed out on device %s. In addition, an OOM event occurred on the device within %s seconds.
```

报错示例如下：

```text
Stream synchronize failed. Reason: AI CPU operator execution timed out on device 0. In addition, an OOM event occurred on the device within 10 seconds.
```

## 可能原因

1. AICPU算子可能因OOM导致执行阻塞或无法及时响应。
2. 对于GetNext算子，其预处理时间可能过长。
3. 对于自定义算子，实现逻辑中有超大循环，或者输入输出Shape过大。
4. 内置算子输入输出Shape过大。

## 解决方法

1. 检查设备内存使用情况，减少算子占用的内存或释放不再使用的内存。
2. 对于GetNext算子，检查其预处理过程，或使用aclrtSetOpExecuteTimeOut接口调整超时时间。
3. 对于自定义算子，确保逻辑设计合理，或修改Shape。
4. 如果输入输出Shape过大，请修改Shape，或使用aclrtSetOpExecuteTimeOut接口调整超时时间。
