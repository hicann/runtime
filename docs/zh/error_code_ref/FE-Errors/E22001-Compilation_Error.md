# E22001 Compilation\_Error

## 错误信息

报错格式如下，占位符%s的含义依次为算子名称、算子类型：

```text
Compilation result for operator %s not found. Optype is %s.
```

报错示例如下：

```text
Compilation result for operator QuantBatchMatmulV3 not found. Optype is QuantBatchMatmulV3.
```

## 可能原因

编译线程或主进程中发生了段错误。

## 解决方法

需检查算子编译线程是否发生异常。
