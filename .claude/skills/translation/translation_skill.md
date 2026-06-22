# PR文档翻译Skill

## 功能描述
根据用户指定的md文件路径，将中文文档翻译成英文文档。支持：
- 用户指定单个或多个md文件路径
- 非docs目录下的md文档
- docs目录下的md文档

## 触发条件
- 用户明确指定需要翻译的md文件路径（一个或多个）
- 指定的md文件不存在对应的英文翻译文档（`_en.md`），或存在文档变更

## 执行流程

### 1. 接收用户指定的翻译文件

用户可以指定以下形式的文件：
- **单个文件**：`M:\path\to\README.md`
- **多个文件**：`M:\path\to\README.md, M:\path\to\CONTRIBUTING.md`
- **目录**：`M:\path\to\docs`（翻译该目录下所有md文件）

**处理步骤：**
1. 解析用户指定的路径列表
2. 验证路径是否存在且为md文件（或包含md文件的目录）
3. 如果是目录，扫描目录下所有md文件
4. 统计实际需要翻译的文件数量
5. 向用户确认翻译范围

**统计报告示例：**
```
待翻译文件：
- M:\path\to\README.md
- M:\path\to\CONTRIBUTING.md
- M:\path\to\docs\api\guide.md
总计：3个文件
```

### 2. 确定翻译文件存放路径

**非“docs/zh”目录文档：**
- 存放规则：与原文件同级目录
- 文件命名：`<原文件名>_en.md`
- 示例：`README.md` → `README_en.md`

**“docs/zh”目录文档：**
- **docs/zh目录下的md文件（如docs/zh/FAQ.md）**：存放在`docs/en/`目录下，保持原有目录层级
  - 文件命名：`<原文件名>.md`
  - 示例：`docs/README.md` → `docs/en/README.md`
  - 示例：`docs/zh/FAQ.md` → `docs/en/FAQ.md`
  - 示例：`docs/zh/QUICKSTART.md` → `docs/en/QUICKSTART.md`


### 3. 检查是否存在翻译文件

根据文档路径类型检查对应的翻译文件是否存在。

**非“docs/zh”目录文档：**
```bash
# 检查同级目录下是否存在_en.md文件
ls README_en.md
ls examples/README_en.md
```

**docs/zh目录下的md文件：**
```bash
# 检查docs/en/目录下是否存在翻译文件（保持原有目录层级）
ls docs/en/README.md
ls docs/en/FAQ.md
ls docs/en/QUICKSTART.md
```


### 4. 检查文档变更

如果翻译文件已存在，检查原文档是否有变更。

**方式1：与上一次提交比较**
```bash
git diff HEAD~1 -- README.md
git diff HEAD~1 -- docs/api/quantize.md
```

**方式2：检查工作区状态**
```bash
git status README.md
git status docs/api/quantize.md
```

### 5. 读取翻译标准（必须执行）

> **⚠️ 重要警告：翻译前必须先读取翻译标准！遗漏此步骤会导致翻译不符合规范，需要返工修正！**

**必须在翻译任何内容之前**，读取`https://developers.google.com/style`英文风格指南的关键内容。

#### 翻译标准核心要点（必须遵守）

**一、语态规范**

| 规范 | 要求 | 示例 |
|------|------|------|
| 主动语态优先 | 面向用户的资料以主动语态为主 | ❌ "Designed for..." → ✅ "This guide provides..." |
| 操作类用祈使句 | 操作步骤省去you，直接使用动词开头 | ❌ "You can enter the password" → ✅ "Enter the password" |
| 被动语态例外 | 动作执行者未知/无关、错误提示中避免责备用户时可用被动 | "The dialog box is displayed" |

**二、时态规范**

| 场景 | 使用时态 | 示例 |
|------|---------|------|
| 陈述规律/原理/机制 | 一般现在时 | "A ping command sends packets to test connectivity." |
| 操作后的瞬时结果 | 一般现在时 | ❌ "The dialog box will appear" → ✅ "The dialog box appears" |
| 需间隔较长时间的结果 | 将来时 | "The system will restart after installation." |
| 已完成的动作 | 现在完成时 | "You have successfully logged in." |

**三、词汇规范**

| 禁止使用 | 正确用法 |
|---------|---------|
| etc. | and so on（需限定范围） |
| e.g. | for example |
| i.e. | that is |
| via | through / by / using |
| can't, it's, don't | cannot, it is, do not |
| you're, they're | you are, they are |
| won't, shouldn't | will not, should not |

**四、句子和段落规范**

| 规范 | 要求 |
|------|------|
| 重要信息置前 | 将关键信息放在句首或段落开头 |
| 避免超长句子 | 每句不超过25个单词 |
| 使用并行结构 | 相似描述使用统一句式 |
| 避免双重否定 | 使用直接陈述 |

**五、好的英文风格必须满足**

- 使用前后一致的术语
- 使用简单词汇
- 定义缩略语（首次出现时定义）
- 尽量使用主动语态
- 尽量使用一般现在时态
- 使用并行结构
- 使用第二人称（操作类用祈使句）
- 清晰、正确地组织信息

**六、好的英文风格必须避免**

- 虚悬前置词
- 无谓重复或累赘
- 外来语（etc、e.g.、i.e.、via）
- 过时词汇（thus、hereinafter、hence）
- 口语词汇（figure out）
- 词汇简缩（char、config）
- 缩略词（can't、it's）

### 6. 执行翻译

**不存在翻译文件（完整翻译）：**
1. 使用read工具读取中文文档完整内容
2. 参考翻译标准进行完整翻译
3. 根据文档路径类型确定存放位置并创建翻译文件

**已存在翻译文件且有变更（增量翻译）：**
1. 使用bash工具获取中文文档的变更内容（diff）
2. 分析变更点
3. 将变更点翻译成英文
4. 使用edit工具更新对应的英文文档

### 7. 使用todowrite跟踪进度

创建任务列表跟踪翻译进度。

**示例：**
```
[
  {"content": "读取翻译标准文档（必须执行）", "status": "in_progress", "priority": "high"},
  {"content": "翻译文件1：README.md", "status": "pending", "priority": "high"},
  {"content": "翻译文件2：CONTRIBUTING.md", "status": "pending", "priority": "high"},
  {"content": "翻译文件3：docs/api/guide.md", "status": "pending", "priority": "high"}
]
```

## 翻译标准文档
- **主文档**：https://developers.google.com/style

## 目录结构示例

```
仓库根目录/
├── README.md                  # 原始中文文档（非docs）
├── README_en.md               # 翻译后英文文档（同级目录）
├── CONTRIBUTING.md            # 原始中文文档（非docs）
├── CONTRIBUTING_en.md         # 翻译后英文文档（同级目录）
├── docs/                      # docs目录
│   ├── README.md              # 原始文档（docs根目录）
│   ├── README_en.md           # 翻译后的英文文档（docs根目录）
│   ├── zh/                    # docs目录
│   │   ├── FAQ.md             # 原始文档
│   │   ├── QUICKSTART.md      # 原始文档
│   │   └── Ascend_910B_DCMI_API/  # 原始docs目录
│   │       ├── README.md      # 原始文档
│   │       └── dcmi_init.md   # 原始文档
│   ├── en/                    # 翻译后的docs目录
│   │   ├── FAQ.md             # 翻译后的文档
│   │   ├── QUICKSTART.md      # 翻译后的文档
│   │   └── Ascend_910B_DCMI_API/  # docs二级子目录
│   │       ├── README.md      # 翻译后的文档
│   │       └── dcmi_init.md   # 翻译后的文档
├── examples/
│   └── README.md              # 原始中文文档（非docs）
│   └── README_en.md           # 翻译后英文文档（同级目录）
└── npu_ops/
    └── README.md              # 原始中文文档（非docs）
    └── README_en.md           # 翻译后英文文档（同级目录）
```

## 工具使用建议

### 并行操作提高效率
- 并行读取多个相关文件（中文原文、英文版本、风格指南等）
- 并行执行多个bash命令获取不同信息

## 注意事项

1. **必须先读取翻译标准**：翻译任何内容前，必须先读取英文风格指南
2. **文件存放路径**：非docs目录与原文件同级；docs根目录及其一级子目录的md文件存放在`docs/en/`下保持原有层级
3. **增量更新**：已存在翻译文件时，仅翻译变更部分，避免重复翻译
4. **格式一致性**：保持Markdown格式、表格结构、链接引用等一致

## 常见问题处理

### Q1: 翻译时保留中文链接

对于引用其他中文文档的链接，保持原链接路径不变，待对应文档翻译后再更新。

### Q2: 为什么必须先读取翻译标准

**不读取翻译标准会导致以下问题：**

1. **被动语态滥用**：中文常见"面向..."、"设计用于..."等表达，直接翻译为"Designed for..."是被动语态，应改为主动语态"This guide provides..."

2. **外来语使用**：中文常用"等"、"例如"、"即"，直接翻译为etc、e.g.、i.e.是外来语，应改为and so on、for example、that is

3. **缩写形式**：翻译中使用can't、it's等缩写，应改为cannot、it is

4. **时态错误**：操作步骤后的结果使用将来时"will appear"，应改为一般现在时"appears"

**后果：** 翻译完成后发现不符合规范，需要返工修正，浪费时间。因此必须在翻译前先读取标准。

### Q3: 如何处理已存在的翻译文件

**处理流程：**
1. 检查原文档是否有变更
2. 如有变更，分析变更内容
3. 仅翻译变更部分
4. 根据文档路径类型，更新对应的翻译文件：
   - **非docs目录**：使用edit工具更新同级目录的翻译文件
   - **docs根目录及其一级子目录**：使用edit工具更新docs/en/目录下对应目录层级的翻译文件
   - **docs二级及更深子目录**：使用edit工具更新同级目录的翻译文件

**增量翻译示例：**
```bash
# 1. 获取变更内容
git diff HEAD~1 -- README.md

# 2. 分析变更点
# 3. 翻译变更部分
# 4. 使用edit工具更新翻译文件
```

### Q4: 用户指定目录时如何处理

当用户指定一个目录时：
1. 扫描该目录下所有`.md`文件
2. 排除`.git`目录
3. 生成待翻译文件列表
4. 向用户确认翻译范围
5. 按文件路径类型确定翻译文件存放位置

**示例：**
用户指定：`M:\path\to\docs`
扫描结果：
```
待翻译文件：
- docs/README.md → docs/en/README_en.md
- docs/zh/FAQ.md → docs/en/FAQ_en.md
- docs/zh/Ascend_910B_DCMI_API/README.md → docs/en/Ascend_910B_DCMI_API/README.md
总计：3个文件
```

### Q5: 用户指定多个文件时如何处理

当用户指定多个文件路径时：
1. 解析每个路径
2. 验证每个路径是否存在
3. 汇总待翻译文件列表
4. 向用户确认翻译范围
5. 逐个处理翻译

**示例：**
用户指定：`README.md, CONTRIBUTING.md, docs/zh/FAQ.md`
待翻译文件：
```
- README.md → README_en.md
- CONTRIBUTING.md → CONTRIBUTING_en.md
- docs/zh/FAQ.md → docs/en/FAQ_en.md
总计：3个文件
```