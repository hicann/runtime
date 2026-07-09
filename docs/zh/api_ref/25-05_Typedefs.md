# Typedefs

typedef 类型数据。

<br>

- [aclFloat16](#aclFloat16)
- [aclmdlRI](#aclmdlRI)
- [aclmdlRICondHandle](#aclmdlRICondHandle)
- [aclmdlRITask](#aclmdlRITask)
- [aclrtAllocator](#aclrtAllocator)
- [aclrtAllocatorAddr](#aclrtAllocatorAddr)
- [aclrtAllocatorBlock](#aclrtAllocatorBlock)
- [aclrtArgsHandle](#aclrtArgsHandle)
- [aclrtBinHandle](#aclrtBinHandle)
- [aclrtCntNotify](#aclrtCntNotify)
- [aclrtContext](#aclrtContext)
- [aclrtDrvMemHandle](#aclrtDrvMemHandle)
- [aclrtEvent](#aclrtEvent)
- [aclrtFuncHandle](#aclrtFuncHandle)
- [aclrtLabel](#aclrtLabel)
- [aclrtLabelList](#aclrtLabelList)
- [aclrtMbuf](#aclrtMbuf)
- [aclrtMemPool](#aclrtMemPool)
- [aclrtNotify](#aclrtNotify)
- [aclrtParamHandle](#aclrtParamHandle)
- [aclrtStream](#aclrtStream)
- [aclrtTaskGrp](#aclrtTaskGrp)
- [aclrtUpdateTaskAttrVal](#aclrtUpdateTaskAttrVal)
- [acltdtBuf](#acltdtBuf)

<br>

<a id="aclFloat16"></a>

## aclFloat16

该数据类型仅用于数据传递，不能用于加减乘除等运算。

```c
typedef uint16_t aclFloat16;
```

<br>

<a id="aclmdlRI"></a>

## aclmdlRI

```c
typedef void *aclmdlRI;
```

<br>

<a id="aclmdlRICondHandle"></a>

## aclmdlRICondHandle

```c
typedef void* aclmdlRICondHandle;
```

<br>

<a id="aclmdlRITask"></a>

## aclmdlRITask

```c
typedef void *aclmdlRITask;
```

<br>

<a id="aclrtAllocator"></a>

## aclrtAllocator

```c
typedef void *aclrtAllocator;
```

<br>

<a id="aclrtAllocatorAddr"></a>

## aclrtAllocatorAddr

```c
typedef void *aclrtAllocatorAddr;
```

<br>

<a id="aclrtAllocatorBlock"></a>

## aclrtAllocatorBlock

```c
typedef void *aclrtAllocatorBlock;
```

<br>

<a id="aclrtArgsHandle"></a>

## aclrtArgsHandle

```c
typedef void* aclrtArgsHandle;
```

<br>

<a id="aclrtBinHandle"></a>

## aclrtBinHandle

```c
typedef void* aclrtBinHandle;
```

<br>

<a id="aclrtCntNotify"></a>

## aclrtCntNotify

```c
typedef void *aclrtCntNotify;
```

<br>

<a id="aclrtContext"></a>

## aclrtContext

```c
typedef void *aclrtContext;
```

<br>

<a id="aclrtDrvMemHandle"></a>

## aclrtDrvMemHandle

```c
typedef void* aclrtDrvMemHandle;
```

<br>

<a id="aclrtEvent"></a>

## aclrtEvent

```c
typedef void *aclrtEvent;
```

<br>

<a id="aclrtFuncHandle"></a>

## aclrtFuncHandle

```c
typedef void* aclrtFuncHandle;
```

<br>

<a id="aclrtLabel"></a>

## aclrtLabel

```c
typedef void *aclrtLabel; 
```

<br>

<a id="aclrtLabelList"></a>

## aclrtLabelList

```c
typedef void *aclrtLabelList;
```

<br>

<a id="aclrtMbuf"></a>

## aclrtMbuf

```c
typedef void *aclrtMbuf;
```

<br>

<a id="aclrtMemPool"></a>

## aclrtMemPool

```c
typedef void *aclrtMemPool;
```

<br>

<a id="aclrtNotify"></a>

## aclrtNotify

```c
typedef void *aclrtNotify;
```

<br>

<a id="aclrtParamHandle"></a>

## aclrtParamHandle

```c
typedef void* aclrtParamHandle;
```

<br>

<a id="aclrtStream"></a>

## aclrtStream

```c
typedef void *aclrtStream;
```

<br>

<a id="aclrtTaskGrp"></a>

## aclrtTaskGrp

```c
typedef void *aclrtTaskGrp;
```

<br>

<a id="aclrtUpdateTaskAttrVal"></a>

## aclrtUpdateTaskAttrVal

```c
typedef union { 
    aclrtRandomTaskUpdateAttr randomTaskAttr; 
    aclrtAicAivTaskUpdateAttr aicAivTaskAttr; 
} aclrtUpdateTaskAttrVal;
```

| 成员名称 | 说明 |
| --- | --- |
| randomTaskAttr | 随机数生成任务。类型定义请参见[aclrtRandomTaskUpdateAttr](25-04_Structs.md#aclrtRandomTaskUpdateAttr)。<br>不同型号对该任务支持的情况不同：<br>Atlas A3 训练系列产品/Atlas A3 推理系列产品支持随机数生成任务<br>Atlas A2 训练系列产品/Atlas A2 推理系列产品支持随机数生成任务 |
| aicAivTaskAttr | 在Cube\Vector计算单元上执行的计算任务。类型定义请参见[aclrtAicAivTaskUpdateAttr](25-04_Structs.md#aclrtAicAivTaskUpdateAttr)。 |

<br>

<a id="acltdtBuf"></a>

## acltdtBuf

```c
typedef void *acltdtBuf;
```
