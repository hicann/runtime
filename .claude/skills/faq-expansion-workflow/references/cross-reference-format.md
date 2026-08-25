# 交叉引用规范

## API 文档引用

格式：
```markdown
参见：[aclrtMalloc API 参考](../api_ref/11-01_device_memory_malloc_and_free.md#aclrtMalloc)
```

位置：FAQ 底部"参见"章节

注意：引用路径必须指向实际存在的文档文件。如果对应 API 参考文档尚不存在，不要编造路径。

## 最佳实践引用

格式：
```markdown
参见：[内存管理最佳实践](../dev_guide/02_memory_management.md)
```

注意：确认 `docs/zh/dev_guide/` 下对应文件存在后再引用。

## 相关 FAQ 引用

格式：
```markdown
参见：[aclrtMalloc 内存申请失败](aclrtMalloc内存申请失败常见原因.md)
```

注意：同目录下的 FAQ 用相对文件名引用，不需要 `../zh/FAQ/` 前缀。

## 完整交叉引用示例

```markdown
## 参见

- [aclrtReserveMemAddress API 参考](../api_ref/11-04_virtual_memory_management.md#aclrtReserveMemAddress)
- [内存管理最佳实践](../dev_guide/02_memory_management.md)
- [aclrtMalloc 内存申请失败](aclrtMalloc内存申请失败常见原因.md)
```

## 引用路径校验

添加引用前，确认目标文件存在：
```bash
ls docs/zh/api_ref/11-01_device_memory_malloc_and_free.md
ls docs/zh/dev_guide/02_memory_management.md
ls docs/zh/FAQ/aclrtMalloc内存申请失败常见原因.md
```

如果文件不存在，不要添加引用。

## 引用网络价值

交叉引用构建知识网络：
- 用户可快速导航到相关文档
- 降低重复内容编写
- 提升文档系统性
