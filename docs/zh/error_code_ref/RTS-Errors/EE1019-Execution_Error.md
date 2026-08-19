# EE1019 Execution\_Error

## 错误信息

报错格式如下，占位符%s的含义依次为报错阶段、报错原因：

```
%s failed. Reason: %s.
```

报错示例如下：

```
Allocating task info failed. Reason: The number of pending tasks in the stream exceeds the limit.
```

## 解决方法

1. 减少提交到同一stream中的任务数量。
2. 使用多个stream并行提交任务。
