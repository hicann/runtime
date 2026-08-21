# EK0002 Invalid\_Argument\_API\_Call\_Sequence

## 错误信息

报错格式如下，占位符%s都表示接口名：

```text
Please call the APIs in the following order: call %s first, then %s.
```

报错示例如下：

```text
Please call the APIs in the following order: call aclprofInit first, then aclprofStart.
```

## 解决方法

需根据报错提示，按照正确的顺序调用接口。
