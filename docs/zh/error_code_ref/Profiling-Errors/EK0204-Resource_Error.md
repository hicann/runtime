# EK0204 Resource\_Error

## 错误信息

报错格式如下，占位符%s表示报错原因：

```text
Insufficient disk space. Reason: %s.
```

报错示例如下：

```text
Insufficient disk space. Reason: The remaining disk space of the system is 19MB, which is less than 20MB.
```

## 解决方法

Profiling落盘需求至少20MB的存储空间，请删除多余文件或更换落盘路径。
