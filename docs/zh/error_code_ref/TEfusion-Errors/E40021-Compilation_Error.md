# E40021 Compilation\_Error

## 错误信息

报错格式如下，占位符%s的含义依次为算子名称、路径、算子类型：

```text
Failed to compile Op %s. oppath is %s and optype is %s.
```

报错示例如下：

```text
Failed to compile Op QuantBatchMatmulV3. oppath is /usr/local/Ascend/cann/opp and optype is QuantBatchMatmulV3.
```

## 解决方法

查看Host日志以获取详细信息，然后检查日志中的Python堆栈。
