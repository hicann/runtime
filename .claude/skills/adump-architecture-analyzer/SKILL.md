---
name: adump-architecture-analyzer
description: Analyze the software architecture of the adump codebase, which provides tensor dump capabilities including normal data dump and exception dump scenarios. Exception dump is categorized into three levels based on information granularity: aic_err_brief_dump (L0), aic_err_norm_dump (L1), and aic_err_detail_dump (L2). Use this skill whenever the user wants to understand the adump codebase architecture, analyze dump functionality, or examine exception dump implementations, especially the detailed exception dump mechanism.
---

# Adump Architecture Analyzer

This skill analyzes the software architecture of the adump codebase, focusing on tensor dump capabilities and exception dump implementations.

## Overview

The adump codebase provides comprehensive tensor dump functionality for debugging and analysis:

1. **Normal Data Dump**: Dump tensor data during normal business operations
2. **Exception Dump**: Capture diagnostic information when exceptions occur, with three levels of detail

## Analysis Scope

### 1. Codebase Structure

Analyze the overall directory structure and identify key components:

- `adcore/`: Core infrastructure (common utilities, communication, device management)
- `ad`ump/: Dump functionality implementation
- `inc/`: Public header files and APIs
- `proto/`: Protocol buffer definitions for dump data structures
- `init/`: Initialization and configuration
对外头文件目录：pkg_inc\dump

### 2. Key Modules and Classes

Identify and analyze the main components:

#### Dump Management
- `DumpManager`: Singleton class managing all dump operations
- `DumpSetting`: Configuration management for dump settings
- `DumpConfigConverter`: Converts JSON config to internal structures

#### Dump开关定义
第一层开关：data dump（枚举值定义为OPERATOR），overflow dump（枚举值定义为OP_OVERFLOW），exception dump
第二层开关：data dump分为算子级别的op dump，kernel级别的kernel dump。data dump可以控制dump不同的tensor（input、output、workspace） 。data dump可以配置dump tesnor的数据（tensor），还是统计值（stats）
                   exception dump分为普通的异常dump(枚举值定义为EXCEPTION )，轻量化异常dump（枚举值定义为ARGS_EXCEPTION），细化的异常dump（枚举值定义为AIC_ERR_DETAIL_DUMP）

#### 业务流程
data dump核心功能是对外提供了AdumpDumpTensorV2接口，支持为调用者下发dump算子，dump算子的参数就是算子的tensor信息，内容是基于op_mapping.proto定义的。dump算子的能力是其他代码仓提供的，会基于参数信息完成tensor dump。
exception dump基于runtime提供的exception回调机制，在回调函数中获取算子的tensor信息，将算子的tensor保存到dump文件中，dump文件头是基于op_mapping.proto定义的。

### 5. Data Structures and Protocols

Analyze the protobuf definitions:

#### dump_task.proto
- `DumpData`: Main dump data structure
- `OpInput`/`OpOutput`: Tensor data structures
- `Workspace`: Memory workspace information
- Data type and format definitions

#### op_mapping.proto
- `OpMappingInfo`: Operator mapping information
- `Task`: Task-level dump information
- Address type definitions

### 6. API Surface

Analyze the public API:

#### Main APIs
- `AdumpSetDump`: Configure dump settings，参数的格式是按照json组织
- `AdumpDumpTensorV2`: data dump功能的主要对外接口，提供下发dump算子的能力 
- `AdumpAddExceptionOperatorInfoV2`：exception dump中的普通异常dump功能的主要对外接口，支持调用者将算子的tensor信息保存本模块中，用于后续的exception回调
- `AdumpGetDFXInfoAddrForDynamic`和`AdumpGetDFXInfoAddrForStatic`：exception dump中的轻量化异常dump的主要对外接口，支持调用者获取一块dump维护的内存和索引，调用者将算子的tensor信息保存到这块内存，用于后续的exception回调
- Exception callback registration

#### Configuration
- JSON-based configuration
- Environment variable support
- Dump level selection
- Path and mode configuration

## Analysis Guidelines

### Code Reading Strategy
1. Start with entry points (`adump_api.h`, `dump_manager.h`)
2. Follow the exception dump flow from callback to file I/O
3. Analyze data structures in protobuf files
4. Examine platform-specific implementations
5. Study configuration and initialization

### Key Questions to Answer
- How does the system handle large data dumps efficiently?
- What mechanisms ensure thread safety during concurrent dumps?
- How are exception operators tracked and identified?
- What is the memory footprint of detailed exception dumps?
- How do the three exception dump levels differ in implementation?
- What platform-specific optimizations exist?

### Code Patterns to Identify
- Singleton usage (`DumpManager`)
- RAII patterns for resource management
- Template usage for generic data handling
- Callback mechanisms for exception handling
- Plugin architecture for extensibility

## Analysis Execution

When performing the analysis:

1. **Systematic Exploration**: Read files in logical order, following dependencies
2. **Deep Dive**: Spend extra time on aic_err_detail_dump implementation
3. **Cross-Reference**: Verify understanding by checking multiple related files
4. **Documentation**: Take notes on complex algorithms and data structures
5. **Validation**: Cross-check implementation against API contracts

## Output Generation

Generate both Markdown and JSON outputs:

### Markdown Format
- Human-readable architecture documentation
- Code examples and diagrams
- Detailed explanations of complex components

### JSON Format
- Structured representation of the architecture
- Machine-readable component metadata
- Dependency graph information
- API specifications

## Notes

- Focus on understanding the "why" behind design decisions, not just the "what"
- Pay special attention to memory management in detailed exception dumps
- Identify potential bottlenecks or performance concerns
- Note any unusual or clever implementation techniques
- Document platform-specific variations clearly