# EE1010 Execution\_Error\_Invalid\_Context

## 错误信息

报错格式如下，占位符%s的含义依次为接口名、对象名、扩展信息：

```
%s execution failed because %s does not belong to the current context. Extended information: %s.
```

报错示例如下：

```
MemCopy2DAsync execution failed because stream does not belong to the current context. Extended information: stream_id=61, stream_ctx=0x56519b7e0ee0, cur_ctx=0x5651a0428090.
```

## 解决方法

根据报错提示调整接口参数。
