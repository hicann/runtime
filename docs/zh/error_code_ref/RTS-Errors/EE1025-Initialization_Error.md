# EE1025 Initialization\_Error

## 错误信息

报错格式如下，两个%s占位符依次表示动态库名称和失败原因：

```text
Failed to load dynamic library %s. Reason: %s.
```

报错示例如下：

```text
Failed to load dynamic library libruntime_v100.so. Reason: /usr/local/Ascend/cann-9.2.0/lib64/libruntime_v100.so: undefined symbol: ConstructRuntimeImpl.
```

## 解决方法

1. 使用正确的动态库路径。
2. 确保所需动态库已正确安装。
