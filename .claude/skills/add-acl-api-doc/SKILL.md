---
name: add-acl-api-doc
description: 向 CANN Runtime 已合并的 API 参考文档中添加新接口或数据类型。Use when 用户要向 docs/03_api_ref/ 添加新接口、新数据类型，或说"添加接口"、"补充API"、"加个新函数"、"添加数据类型"。
---

# 添加 ACL API 文档（V1）

将新的 ACL 接口文档直接插入 `docs/03_api_ref/` 下已合并的 Markdown 文件中。

## 项目路径

| 路径 | 说明 |
| --- | --- |
| `docs/03_api_ref/*.md` | 合并文档（42 个分类文件）— 编辑目标 |
| `docs/03_api_ref/api_ref.md` | 总索引文件 |
| `docs/03_api_ref/25_数据类型及其操作接口.md` | 数据类型文档 |
| `docs/dataStructCase.md` | 数据类型排序定义 |
| `scratch/reorder_docs.py` | 数据类型文档重排脚本 |
| `include/external/acl/` | 头文件目录（Doxygen 声明） |
| `docs/03_api_ref/figures/` | 图片资源目录 |

## Instructions

### Step 1: 获取接口信息

1. **确认接口名称和签名**：用户提供函数签名（如 `aclError aclrtNewFunc(int32_t param)`）或接口名称。
2. **查找头文件声明**：在 `include/external/acl/` 下搜索接口的 Doxygen 注释块，提取：
   - `@brief` → 功能简述（用于 TOC 简介）
   - `@param name [IN]/[OUT]` → 参数方向和英文说明
   - `@retval` → 返回值说明
   - `@see` → 关联接口
   - 函数签名（`ACL_FUNC_VISIBILITY` 之后的完整声明）
3. **查找实现**（可选）：在 `src/acl/aclrt_impl/` 下搜索实现细节，获取更详细的功能描述和约束信息。
4. **确定目标分类文件**：根据下方「分类前缀推断规则」推断目标文件，不确定时使用 `AskUserQuestion` 询问用户。
5. **确认产品支持**：默认三款产品全部支持（√）。若用户指定了限定产品范围，按用户要求填写。

### 分类前缀推断规则

| 前缀/模式 | 目标文件 |
| --- | --- |
| `aclInit`, `aclFinalize*` | `02_初始化与去初始化.md` |
| `aclrtSetSysParamOpt`, `aclrt*ResLimit` | `03_运行时配置.md` |
| `aclrtSetDevice`, `aclrtResetDevice`, `aclrtGetDevice*`, `aclrtSynchronizeDevice*` | `04_Device管理.md` |
| `aclrtCreateContext`, `aclrtDestroyContext`, `aclrtCtx*` | `05_Context管理.md` |
| `aclrtCreateStream`, `aclrtDestroyStream`, `aclrtStream*`, `aclrtSynchronizeStream*` | `06_Stream管理.md` |
| `aclrtCreateEvent`, `aclrtDestroyEvent`, `aclrt*Event*` | `07_Event管理.md` |
| `aclrtCreateNotify`, `aclrtDestroyNotify`, `aclrtNotify*` | `08_Notify管理.md` |
| `aclrtCntNotify*` | `09_CntNotify管理.md` |
| `aclrtCreateLabel`, `aclrtDestroyLabel`, `aclrtLabel*` | `10_Label管理.md` |
| `aclrtMalloc`, `aclrtFree` (非Host) | `11-01_设备内存分配与释放.md` |
| `aclrtMallocHost*`, `aclrtFreeHost*`, `aclrtHostRegister*` | `11-02_主机内存管理.md` |
| `aclrtMemcpy*`, `aclrtMemset*` | `11-03_内存拷贝与设置.md` |
| `aclrtMem*Reserve`, `aclrtMem*Map`, `aclrtMem*Physical*` | `11-04_虚拟内存管理.md` |
| `aclrtMallocManaged*`, `aclrtMemManaged*` | `11-05_统一寻址.md` |
| `aclrtCMO*`, `aclrtDCacheFlush*`, `aclrtBarrier*` | `11-06_CMO缓存操作.md` |
| `aclrtIpc*` | `11-07_IPC进程间内存共享.md` |
| `aclrtAllocator*` | `11-08_自定义内存分配器.md` |
| `aclrtStreamMem*` | `11-09_流内存操作.md` |
| `aclrtMemPool*` | `11-10_Stream有序内存分配.md` |
| `aclrtLaunchCallback`, `aclrt*Report`, `aclrtReduceAsync` | `12_执行控制.md` |
| `aclGetRecentErrMsg`, `aclrtSetExceptionInfoCallback` | `13_异常处理.md` |
| `aclrtBinaryLoad*`, `aclrtLaunchKernel*`, `aclrtKernelArgs*` | `14_Kernel加载与执行.md` |
| `aclmdlRI*` | `15_模型运行实例管理.md` |
| `aclrtSetGroup`, `aclrtGetGroup*` | `16_算力Group查询与设置.md` |
| `acltdtSendTensor`, `acltdt*Channel*` | `17-01_Tensor数据传输.md` |
| `acltdt*Queue*` | `17-02_共享队列管理.md` |
| `acltdt*Buf*` | `17-03_共享Buffer管理.md` |
| `aclmdlInitDump`, `acldump*` | `18_Dump配置.md` |
| `aclprofInit`, `aclprofStart`, `aclprofStop` | `19-01_Profiling数据采集接口.md` |
| `msproftx*`, `aclprofRangePush*`, `aclprofRangePop*` | `19-02_msproftx扩展接口.md` |
| `aclprofSubscribe*` | `19-03_订阅算子信息.md` |
| `aclprofSetStep*` | `19-04_PyTorch场景标记迭代时间.md` |
| `aclrtSnapShot*` | `21_快照管理.md` |
| `aclrt*ErrReport*`, `Register*ErrMsg`, `Report*ErrMsg` | `22_错误上报接口.md` |
| `Alog*`, `aclApp*` | `23_日志接口.md` |
| `aclsys*`, `aclDataTypeSize`, 其他杂项 | `24_其他接口.md` |
| 枚举/结构体/typedef 数据类型 | `25_数据类型及其操作接口.md` |
| 不确定时 | **必须询问用户** |

### Step 2: 插入 API 文档段落

读取目标文件 `docs/03_api_ref/{target}.md`，按以下模板生成内容并使用 Edit 工具插入。

#### 函数 API 插入模板

```markdown


<br>
<br>
<br>



<a id="{apiName}"></a>

## {apiName}

```c
{returnType} {apiName}({param1Type} {param1Name}, {param2Type} {param2Name})
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

{功能描述，从 @brief 翻译为中文，补充详细说明}

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| {param1Name} | {输入/输出} | {参数说明} |
| {param2Name} | {输入/输出} | {参数说明} |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。
```

#### 数据类型（枚举）插入模板

```markdown


<br>
<br>
<br>



<a id="{typeName}"></a>

## {typeName}

```
typedef enum {
    {VALUE_1} = 0,     // {说明1}
    {VALUE_2} = 1,     // {说明2}
} {typeName};
```
```

> 如果枚举含义不够自明，可在代码块下方追加说明文字或表格。

#### 数据类型（结构体/typedef）插入模板

```markdown


<br>
<br>
<br>



<a id="{typeName}"></a>

## {typeName}

```
typedef {baseType} {typeName};
```
```

> 对于简单 typedef（如 `typedef int aclError;`、`typedef void *aclrtStream;`），直接使用上述格式。
> 复杂结构体需添加成员说明表格。

#### 插入位置规则

- **分类 01-24**：默认追加到文件末尾（最后一个 API 段落之后）。
- **分类 25（数据类型）**：按**字母序（case-insensitive）**找到正确位置插入。方法：搜索现有 `<a id="..."></a>` 锚点，比较字母顺序，在正确位置插入。
- **用户指定位置**：如用户要求"插入到 aclrtXxx 之后"，找到该 API 段落末尾处插入。

#### 分隔符规则

API 段落之间使用以下分隔（精确到空行数量）：

```
{上一个 API 的最后一行}
                          ← 空行
                          ← 空行
<br>
<br>
<br>
                          ← 空行
                          ← 空行
                          ← 空行
<a id="{nextApi}"></a>
```

即：2 个空行 → 3 个 `<br>` → 3 个空行 → 锚点。

**注意**：数据类型文件（25_）中的分隔更简洁，仅 2 个空行 → 锚点，无 `<br>` 分隔。

### Step 3: 更新 TOC（文件头部函数列表）

在文件头部的 TOC 列表中添加新条目。

#### TOC 区域定界

- **起始**：章节描述段落之后的第一个 `- ` 行
- **结束**：TOC 最后一个 `- ` 行之后的空行（空行后面是 `<a id=` 锚点）

#### 函数 API 的 TOC 条目格式

```
- [`{returnType} {apiName}({完整参数列表})`](#{apiName})：{一句话功能描述}
```

示例：
```
- [`aclError aclrtMalloc(void **devPtr, size_t size, aclrtMemMallocPolicy policy)`](#aclrtMalloc)：在Device上分配内存。
```

#### 纯数据类型的 TOC 条目格式

```
- [{typeName}](#{typeName})
```

示例：
```
- [aclrtMemcpyKind](#aclrtMemcpyKind)
```

#### 带操作函数的数据类型 TOC 条目格式

有些数据类型同时有 Create/Destroy/Get/Set 等操作函数，其 TOC 需包含父类型和子函数：

```
- [{typeName}](#{typeName})
    - [`{prototype}`](#{apiName})：{brief}
    - [`{prototype}`](#{apiName})：{brief}
```

示例：
```
- [aclDataBuffer](#aclDataBuffer)
    - [`aclDataBuffer *aclCreateDataBuffer(void *data, size_t size)`](#aclCreateDataBuffer)：创建aclDataBuffer类型的数据。
    - [`aclError aclDestroyDataBuffer(const aclDataBuffer *dataBuffer)`](#aclDestroyDataBuffer)：销毁aclDataBuffer类型的数据。
```

#### TOC 插入位置

- **分类 01-24**：追加到 TOC 列表末尾（最后一个 `- ` 行之后）
- **分类 25**：按**字母序（case-insensitive）**插入到正确位置

### Step 4: 联动处理

#### 4a. 新数据类型联动

如果新增函数 API 的参数引用了一个**尚不存在**的数据类型（在 `25_数据类型及其操作接口.md` 中没有对应锚点），需要：
1. 提醒用户该数据类型尚无文档
2. 使用 `AskUserQuestion` 询问用户是否同时添加该数据类型
3. 如果用户确认，按数据类型模板同步插入到 `25_数据类型及其操作接口.md`
4. 在 `docs/dataStructCase.md` 中按层级关系添加新条目
5. 运行 `python scratch/reorder_docs.py` 确保排序一致

#### 4b. 新分类联动

如果接口属于一个**全新分类**（当前 42 个分类文件均无法容纳），需要：
1. 使用 `AskUserQuestion` 确认新分类名称和编号
2. 创建新分类文件 `docs/03_api_ref/{NN}_{分类名}.md`
3. 在 `docs/03_api_ref/api_ref.md` 总索引中添加对应条目

#### 4c. 参数类型链接

如果参数类型是已知的枚举/结构体（存在于 `25_数据类型及其操作接口.md` 中），在参数说明列中补充类型链接：

```
| policy | 输入 | 内存分配规则。类型定义请参见[aclrtMemMallocPolicy](25_数据类型及其操作接口.md#aclrtMemMallocPolicy)。 |
```

### Step 5: 验证

完成插入后，检查以下项目：

1. **锚点一致性**：`<a id="{name}"></a>` 中的 name 必须与 TOC 链接 `(#{name})` 完全一致
2. **表格对齐**：`是否支持` 和 `输入/输出` 列的分隔行是 `:---:` 居中对齐
3. **代码块标记**：函数签名用 ` ```c `，数据类型定义用 ` ``` `（无语言标记）
4. **链接格式**：同文件用 `(#name)`，跨文件用 `(targetFile.md#name)`
5. **空行模式**：API 之间的分隔符前后空行数与模板一致
6. **TOC 完整**：每个新插入的 API/类型都有对应的 TOC 条目
7. **标题层级**：函数/类型名称为 H2（`##`），子节为 H3（`###`）

## 格式规则速查

| 项目 | 格式 |
| --- | --- |
| 章节标题 | `# N. 分类名`（H1） |
| API 名称标题 | `## apiName`（H2） |
| 小节标题 | `### 产品支持情况`、`### 功能说明` 等（H3） |
| 锚点 | `<a id="apiName"></a>`，必须用双引号 |
| 函数签名代码块 | ` ```c `（带 c 语言标记） |
| 数据类型代码块 | ` ``` `（不带语言标记） |
| API 间分隔（01-24） | 2 空行 → `<br>\n<br>\n<br>` → 3 空行 → 锚点 |
| API 间分隔（25 数据类型） | 2 空行 → 锚点（无 `<br>`） |
| 表格 `是否支持` 列 | `:---:` 居中对齐 |
| 表格 `输入/输出` 列 | `:---:` 居中对齐 |
| 表格 `说明` 列 | `---` 左对齐 |
| 同文件链接 | `[name](#name)` |
| 跨文件链接 | `[name](targetFile.md#name)` |
| aclError 引用 | `[aclError](25_数据类型及其操作接口.md#aclError)` |
| 产品支持行顺序 | 1. Ascend 950PR/950DT  2. Atlas A3  3. Atlas A2 |
| `√` 字符 | Unicode U+221A |
| 转义字符 | Markdown 中 `*` 需转义为 `\*`（如 `\*devPtr`） |

## 返回值格式规范

| 返回类型 | 格式 |
| --- | --- |
| `aclError` | `返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。` |
| 指针类型 | `返回{typeName}类型的指针。返回NULL表示失败。` |
| `void` | 不需要 `### 返回值说明` 章节 |
| 其他值 | 根据头文件 `@retval` 描述翻译 |

## 可选章节

- **`### 约束说明`**：仅在有约束信息时才添加，放在 `### 返回值说明` 之后。格式为缩进 4 空格的无序列表：

  ```
  ### 约束说明

  -   约束内容1
  -   约束内容2
  ```

## 不确定时必须询问用户

在添加接口文档过程中，如果遇到以下情况，**必须使用 `AskUserQuestion` 向用户确认**，严禁自行猜测：

- **接口功能不明确**：头文件 Doxygen 注释缺失或描述模糊
- **参数含义不清**：参数名称或类型无法自明其用途、输入/输出方向不确定
- **枚举/结构体字段含义不确定**：数据类型中某些字段或枚举值的具体业务含义不明
- **返回值语义不明**：除标准 `aclError` 外，返回值的成功/失败含义不明确
- **约束条件不确定**：不清楚接口的调用前置条件、线程安全性、调用顺序等约束
- **中文翻译拿不准**：英文描述翻译为中文时，技术术语的翻译不确定

**原则：宁可多问一次，也不要写出错误或含糊的文档。**

## 批量添加规则

如果用户一次提供多个接口：
1. 所有接口属于同一分类文件时，逐个插入到同一文件
2. 接口属于不同分类文件时，按分类文件分组处理
3. 每个接口都需要有对应的 TOC 条目

## 注意事项

- **签名代码块内不加链接**：Markdown 代码块内不支持链接语法，类型链接只在参数说明表格中添加
- **不创建独立源文件**：本 skill 直接编辑合并后的分类文件，不在其他目录创建独立 .md 文件
- **不修改合并脚本**：本 skill 不涉及 merge_api_docs.py
