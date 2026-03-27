# aclrtRandomNumFuncParaInfo

```
typedef struct { 
    aclrtRandomNumFuncType funcType;
    union { 
        aclrtDropoutBitMaskInfo dropoutBitmaskInfo; 
        aclrtUniformDisInfo uniformDisInfo;
        aclrtNormalDisInfo normalDisInfo; 
    } paramInfo; 
} aclrtRandomNumFuncParaInfo;
```


| 成员名称 | 说明 |
| --- | --- |
| funcType | 函数类别。类型定义请参见[aclrtRandomNumFuncType](aclrtRandomNumFuncType.md)。 |
| dropoutBitmaskInfo | Dropout bitmask信息。类型定义请参见[aclrtDropoutBitMaskInfo](aclrtDropoutBitMaskInfo.md)。 |
| uniformDisInfo | 均匀分布信息。类型定义请参见[aclrtUniformDisInfo](aclrtUniformDisInfo.md)。 |
| normalDisInfo | 正态分布信息或截断正态分布信息。类型定义请参见[aclrtNormalDisInfo](aclrtNormalDisInfo.md)。 |

