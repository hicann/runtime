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
| funcType | 函数类别。 |
| dropoutBitmaskInfo | Dropout bitmask信息。 |
| uniformDisInfo | 均匀分布信息。 |
| normalDisInfo | 正态分布信息或截断正态分布信息。 |

