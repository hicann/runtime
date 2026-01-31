# acldumpType

```
enum acldumpType {
    AIC_ERR_BRIEF_DUMP = 1,         // 轻量化exception dump
    AIC_ERR_NORM_DUMP = 2,          // 普通exception dump，在轻量化exception dump基础上，还会导出Shape、Data Type、Format以及属性信息
    AIC_ERR_DETAIL_DUMP = 3,        // 在轻量化exception dump基础上，还会导出AI Core的内部存储、寄存器以及调用栈信息
    DATA_DUMP = 4,                  // 模型Dump配置、单算子Dump配置
    OVERFLOW_DUMP = 5               // 溢出算子Dump
};
```

