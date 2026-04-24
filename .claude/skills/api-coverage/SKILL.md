---
name: api-coverage
description: 分析CANN Runtime example的API覆盖率。当用户询问API覆盖情况、example覆盖分析、或需要生成覆盖报告时使用。
argument-hint: "[coverage|compare|improve] [--filter <header|category>]"
allowed-tools:
  - Bash
  - Read
  - Write
  - Grep
  - Glob
  - Agent
---

# CANN Runtime API Coverage Analyzer

你是一个API覆盖率分析助手。根据用户的参数执行不同类型的分析。

## 分析工具

项目中有一个Python分析脚本，位于 `${CLAUDE_SKILL_DIR}/analyze_coverage.py`，用于从头文件提取API并扫描example代码的覆盖情况。

运行方式：
```bash
python "${CLAUDE_SKILL_DIR}/analyze_coverage.py" \
  --headers-dir include/external/acl/ \
  --examples-dir example/ \
  --categories "${CLAUDE_SKILL_DIR}/categories.json" \
  --format <json|summary|markdown>
```

## 报告类型

根据第一个参数（$0）决定报告类型，默认为 `coverage`：

### 1. `coverage`（默认）— 基础覆盖率报告

1. 运行分析脚本获取JSON数据：`--format json`
2. 基于JSON数据生成完整的中文覆盖率报告
3. 报告应包含：总体概览、按头文件统计、按功能分类统计、各分类未覆盖API详情、各example使用API统计
4. 输出到 `report/example_api_coverage_report.md`

你也可以直接使用 `--format markdown` 让脚本生成基础报告，然后在此基础上补充分析。

### 2. `compare` — CUDA对比分析

1. 运行分析脚本获取JSON数据
2. 读取 `report/cann_api_cuda_classification.md` 获取CUDA映射关系
3. 读取 `report/cuda_api_coverage_report.md` 获取CUDA覆盖率数据
4. 生成对比分析报告，包含：
   - CANN vs CUDA 各模块覆盖率对比
   - CANN优势领域和差距领域
   - 改进建议
5. 输出到 `report/cuda_comparison_report.md`

### 3. `improve` — 改进建议分析

1. 运行分析脚本获取JSON数据
2. 读取已有报告作为参考
3. 对每个现有example生成具体的改进建议（应添加哪些API）
4. 提出新example创建建议（覆盖零覆盖模块）
5. 按P0/P1/P2优先级排列
6. 输出到 `report/example_improvement_analysis.md`

## 过滤选项

如果用户提供了 `--filter` 参数：
- 头文件过滤：如 `--filter acl_rt.h` — 只分析指定头文件的API
- 分类过滤：如 `--filter "设备管理"` — 只分析指定分类

## 输出规范

- 所有报告用**中文**撰写
- 使用Markdown表格格式
- 包含生成时间戳
- 数据必须基于脚本输出的JSON，不要猜测数字
- 报告文件保存在 `report/` 目录

## 执行步骤

1. 首先运行Python脚本获取准确的覆盖率数据
2. 根据报告类型，读取必要的参考文件
3. 基于数据生成分析报告
4. 将报告写入指定文件
5. 向用户报告关键数字（总API数、覆盖率、主要发现）
