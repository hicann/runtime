# EE1014 File\_Operation\_Error\_Parse

## 错误信息

报错格式如下，占位符%s表示报错原因：

```text
Failed to parse the binary file of the operator. Reason: %s.
```

报错示例如下：

```text
Failed to parse the binary file of the operator. Reason: The ELF section header address in the operator binary ELF file header cannot be empty.
```

## 可能原因

1. 算子的二进制文件损坏。
2. 编译参数不正确。

## 解决方法

重新编译并加载算子的二进制文件。
