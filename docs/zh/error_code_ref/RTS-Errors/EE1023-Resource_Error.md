# EE1023 Resource\_Error

## 错误信息

报错格式如下，占位符%s的含义依次为报错阶段（或接口名）、报错原因：

```
%s failed. Reason: %s.
```

报错示例如下：

```
Expanding the capacity failed. Reason: The number of asynchronous copy tasks in the ACL graph is too large. 1. If the value of numBatches transferred by aclrtMemcpyBatchAsync in the ACL Graph is too large, reduce the value of numBatches. 2. If the height transferred by aclrtMemcpy2dAsync in the ACL Graph is too large, reduce the height.
```

## 解决方法

如需了解具体排除方法，请在<https://www.hiascend.com/document>网站上搜索关键词“EE1023”。