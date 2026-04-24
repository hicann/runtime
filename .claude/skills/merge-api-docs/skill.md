---
name: merge-api-docs
description: 合并和管理 CANN Runtime API 参考文档。当用户需要重新生成 API 文档、修改分类结构、调整格式或添加新接口到合并管线时使用。也适用于"重新生成文档"、"跑一下合并脚本"、"添加新分类"、"调整文档格式"等场景。
---

# CANN Runtime API 文档合并管理

将 `docs/03_api_ref_bak/` 下 600+ 个独立 API 文档合并为按分类组织的 42 个 Markdown 文件，输出到 `docs/03_api_ref/`。

## 项目结构

| 路径 | 说明 |
| --- | --- |
| `docs/03_api_ref_bak/` | 源文件目录，每个 API 一个 .md 文件（如 `aclrtMalloc.md`） |
| `~/.claude/skills/merge-api-docs/merge_api_docs.py` | 合并脚本（核心文件，位于 skill 目录） |
| `docs/03_api_ref/*.md` | 输出的分类合并文件（42 个） |
| `docs/03_api_ref/api_ref.md` | 总索引文件 |
| `docs/03_api_ref/figures/` | 图片资源（从源目录复制） |

## 文件命名规则

### 一级分类文件

格式：`{NN}_{分类名}.md`，编号从 `01` 起始，两位零填充。

| 编号 | 文件名 | 标题格式 |
| --- | --- | --- |
| 01 | `01_概述.md` | `# 1. 概述` |
| 02 | `02_初始化与去初始化.md` | `# 2. 初始化与去初始化` |
| ... | ... | ... |
| 24 | `24_数据类型及其操作接口.md` | `# 24. 数据类型及其操作接口` |

### 二级子分类文件

格式：`{父编号}-{子编号}_{子分类名}.md`，父子编号均两位零填充，用 **短横线 `-`** 分隔（不是点号 `.`）。

| 父分类 | 文件名 | 标题格式 |
| --- | --- | --- |
| 11 内存管理 | `11-01_设备内存分配与释放.md` | `# 11-01 设备内存分配与释放` |
| 11 内存管理 | `11-02_主机内存管理.md` | `# 11-02 主机内存管理` |
| 17 数据传输 | `17-01_Tensor数据传输.md` | `# 17-01 Tensor数据传输` |
| 19 Profiling | `19-01_Profiling数据采集接口.md` | `# 19-01 Profiling数据采集接口` |

### CATEGORIES 中的对应字段

```python
# 一级分类
{"num": "11", "title": "内存管理", "output": "11_内存管理.md", ...}

# 二级子分类
{"title": "11-01 设备内存分配与释放", "output": "11-01_设备内存分配与释放.md", ...}
```

### 命名规则要点

- **编号从 01 起始**，不使用 00
- **一级分隔符用下划线 `_`**：`{NN}_{名称}.md`
- **二级父子编号用短横线 `-`**：`{父NN}-{子NN}_{名称}.md`
- **编号必须两位零填充**：`01` 而非 `1`，`11-01` 而非 `11-1`
- **标题中一级编号不零填充**：`# 1. 概述`（不是 `# 01. 概述`）
- **标题中二级编号保持零填充**：`# 11-01 设备内存分配与释放`

## 合并管线架构

### 单个 API 处理流程（`format_api_section()`）

```
read_api_doc()           读取源 .md 文件
    ↓
extract_prototype()      提取函数原型（```代码块中的签名）
    ↓
inject_param_type_links()  解析原型中的参数类型，在参数表中注入类型链接
    ↓
shift_headings()         下移标题层级，避免合并后层级冲突
    ↓
插入 HTML 锚点 + 标题 + 签名代码块
```

### 输出管线（`write_merged()`）

```
fix_table_alignment()    优化表格列对齐（居中/左对齐）
    ↓
auto_link_types()        为裸露的数据类型名自动添加 [name](name.md) 链接
    ↓
fix_internal_links()     将 (apiName.md) 解析为合并后的跨文件锚点链接
    ↓
写入输出文件
```

### 关键函数速查

| 函数 | 作用 |
| --- | --- |
| `extract_prototype()` | 从 `## 函数原型` 章节提取 C 签名 |
| `extract_brief()` | 从 `## 功能说明` 提取第一句话作为简述 |
| `build_api_toc()` | 构建签名+简述的快速跳转列表 |
| `parse_param_types()` | 从函数原型解析 参数名→数据类型 映射 |
| `inject_param_type_links()` | 在参数表中为已知类型追加 `取值详见[type](type.md)` |
| `format_api_section()` | 组装单个 API 的完整 Markdown 段落 |
| `fix_table_alignment()` | 表格列对齐：`是否支持`/`输入/输出` 居中 |
| `auto_link_types()` | 用占位符保护代码块/链接/标题，再对裸类型名加链接 |
| `fix_internal_links()` | `(api.md)` → `(target_file.md#api)` 跨文件引用 |
| `build_api_file_map()` | 构建 API名→输出文件名 的全局映射 |
| `get_data_type_names()` | 从第 24 类提取所有数据类型名（200 个） |

## Instructions

当用户触发此 skill 时（如"重新生成文档"、"跑一下合并脚本"），按以下步骤依次执行：

### Step 1: 检测未注册的源文件

运行脚本的检测功能，扫描 `docs/03_api_ref/` 中的 .md 源文件与 `CATEGORIES` 对比（此时尚未备份，源文件就在 `03_api_ref/` 中）：

```bash
python -X utf8 -c "
import sys, os
sys.path.insert(0, os.path.expanduser('~/.claude/skills/merge-api-docs'))
from merge_api_docs import detect_unregistered_files
detect_unregistered_files(scan_dir=os.path.abspath('docs/03_api_ref'))
"
```

> **说明**：脚本位于 `~/.claude/skills/merge-api-docs/merge_api_docs.py`，通过 `sys.path.insert` 导入。`detect_unregistered_files()` 接受 `scan_dir` 参数指定扫描目录。备份前传入 `docs/03_api_ref`，备份后自动扫描 `docs/03_api_ref_bak`。

将检测结果整理为报告，向用户展示：
- 未注册的 API 接口列表（以 `acl`/`msprof` 开头的文件）
- 未注册的非 API 文件（中文命名的旧分类索引，通常可忽略）
- 如果全部已注册，告知用户无需额外操作

### Step 2: 询问用户是否注册新接口

如果 Step 1 检测到未注册的 API 文件，使用 `AskUserQuestion` 工具询问用户：
- 是否将这些新接口/数据类型全部注册到 `CATEGORIES` 中？
- 用户可以选择：全部注册 / 选择部分注册 / 跳过不注册

### Step 3: 执行注册

根据用户的选择：

**如果用户选择注册**，对每个需要注册的 API，判断归属分类并编辑 `~/.claude/skills/merge-api-docs/merge_api_docs.py`：

- **接口函数**（如 `aclrtXxx`）：根据函数名前缀和功能，添加到对应分类的 `apis` 列表中。分类判断规则：
  - `aclrtDevice*` → 第 04 类（Device管理）
  - `aclrtMalloc*` / `aclrtMem*` / `aclrtFree*` → 第 11 类（内存管理）对应子分类
  - `aclrtStream*` → 第 06 类（Stream管理）
  - `aclsys*` / `aclApp*` / `aclDataTypeSize` 等 → 第 23 类（其他接口）
  - 其他按功能归类，不确定时询问用户

- **数据类型**（枚举/结构体，如 `aclrtXxxType`、`aclrtXxxAttr`）：添加到第 24 类（数据类型及其操作接口）的 `apis` 列表中，**必须保持字母顺序插入**

**如果用户选择跳过**，不做修改，直接进入 Step 4。

### Step 4: 询问是否重新生成文档

使用 `AskUserQuestion` 工具询问用户是否开始重新生成 API 文档。

**如果用户确认生成**，依次执行：

```bash
# 1. 备份当前源文件目录（脚本从 03_api_ref_bak 读取，输出到 03_api_ref）
mv docs/03_api_ref docs/03_api_ref_bak

# 2. 运行合并脚本（脚本位于 skill 目录，不受备份影响）
python -X utf8 ~/.claude/skills/merge-api-docs/merge_api_docs.py
```

> **注意**：脚本位于 `~/.claude/skills/merge-api-docs/`，与项目目录独立，备份操作不影响脚本路径。脚本基于当前工作目录读取 `docs/03_api_ref_bak/` 并输出到 `docs/03_api_ref/`。

脚本会：
1. 读取 `CATEGORIES` 中定义的所有分类和 API
2. 从 `docs/03_api_ref_bak/` 读取每个 API 的源文档
3. 执行合并管线处理
4. 输出 42 个分类文件 + 1 个总索引到 `docs/03_api_ref/`
5. 再次运行未注册文件检测，确认无遗漏

**如果用户取消**，结束流程。

---

### 附录：手动操作参考

#### 添加新 API 到现有分类

在 `~/.claude/skills/merge-api-docs/merge_api_docs.py` 的 `CATEGORIES` 对应分类的 `apis` 列表中添加 API 名称：

```python
{
    "title": "11-01 设备内存分配与释放",
    "output": "11-01_设备内存分配与释放.md",
    "apis": [
        "aclrtMalloc", "aclrtMallocAlign32", ...,
        "aclrtNewApi",  # 新增
    ],
},
```

#### 添加新一级分类

在 `CATEGORIES` 列表中添加新 dict，同时在 `DESCRIPTIONS` 中添加描述：

```python
# CATEGORIES
{"num": "25", "title": "新分类名称", "output": "25_新分类名称.md", "apis": ["api1", "api2"]},

# DESCRIPTIONS
"25_新分类名称.md": "本章节描述...",
```

#### 添加新二级子分类

在父分类的 `subcategories` 列表中添加，同时在 `DESCRIPTIONS` 中添加描述：

```python
# subcategories
{"title": "11-11 新子分类", "output": "11-11_新子分类.md", "apis": ["api1", "api2"]},

# DESCRIPTIONS
"11-11_新子分类.md": "本章节描述...",
```

#### 修改文档格式

| 需求 | 修改位置 |
| --- | --- |
| 调整表格对齐规则 | `fix_table_alignment()` 和 `CENTER_COLUMNS` 集合 |
| 修改签名展示格式 | `format_api_section()` 中的 `proto_block` 构建 |
| 修改 TOC 格式 | `build_api_toc()` |
| 调整 API 间分隔样式 | `build_category()` / `build_subcategory_file()` 中的 `<br>` 分隔 |
| 修改总索引格式 | `build_index()` |
| 调整数据类型链接行为 | `auto_link_types()` 或 `inject_param_type_links()` |

## 注意事项

- **文件命名规则**：一级 `{NN}_{名称}.md`，二级 `{父NN}-{子NN}_{名称}.md`，编号从 01 起始，短横线分隔父子编号
- **编号必须两位零填充**：`11-01_` 而非 `11-1_`，`17-01_` 而非 `17-1_`
- **DESCRIPTIONS 的 key 必须与 output 文件名完全一致**
- **签名代码块保持 ` ```c ` 格式**，不在代码块内添加链接（Markdown 不支持）
- **数据类型链接由脚本自动处理**：`auto_link_types()` 处理文本中的裸类型名，`inject_param_type_links()` 处理参数表
- **占位符格式**：`auto_link_types()` 使用 `XXPH{N}XXPH` 占位符保护代码块等区域，勿使用 `\x00` 等特殊字符
- 合并管线处理顺序不可随意调整：`fix_table_alignment → auto_link_types → fix_internal_links`
- 新增的数据类型（枚举/结构体）需加入第 24 类的 `apis` 列表才能被自动链接识别
- **第 24 类的 `apis` 列表必须保持字母顺序（case-insensitive）**，新增条目需插入到正确的字母位置，不要追加到末尾
