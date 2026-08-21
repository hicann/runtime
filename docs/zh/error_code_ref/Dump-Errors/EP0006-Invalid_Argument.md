# EP0006 Invalid\_Argument

## 错误信息

报错格式如下，占位符%s的含义依次为接口名、参数名、报错原因：

```text
%s failed. Value %s for parameter %s is invalid. Reason: %s.
```

报错示例如下：

```text
aclopStartDumpArgs failed. Value /output for parameter path is invalid. Reason: The parameter is a path and the path fails to be created. Error: No such file or directory.
```

## 解决方法

需按照Reason中的提示检查并修改。
