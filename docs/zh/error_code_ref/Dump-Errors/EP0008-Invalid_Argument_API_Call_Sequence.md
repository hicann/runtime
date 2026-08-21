# EP0008 Invalid\_Argument\_API\_Call\_Sequence

## 错误信息

报错格式如下，占位符%s的含义依次为接口名、报错原因：

```text
%s failed. Reason: %s.
```

报错示例如下：

```text
aclmdlInitDump failed. Reason: aclInit must be executed before aclmdlInitDump is called.
```

## 解决方法

需按照Reason中的提示检查并修改。
