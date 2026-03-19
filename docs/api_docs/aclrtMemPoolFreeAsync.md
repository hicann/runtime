# aclrtMemPoolFreeAsync

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于商用产品中。**

## 产品支持情况

| 产品                     | 是否支持 |
| ------------------------------------------- | -------- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ✕     |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √     |


## 功能说明
异步内存释放接口，释放通过aclrtMemPoolMallocAsync接口申请的内存，仅将内存归还给内存池，而不是实际释放物理内存。

## 函数原型
```
aclError aclrtMemPoolFreeAsync(void *ptr, aclrtStream stream)
```


## 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| ptr | 输入 | 分配的内存指针。 |
| stream | 输入 | 指定Stream，类型为 [aclrtStream](aclrtStream.md)。|

## 返回值说明
返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。