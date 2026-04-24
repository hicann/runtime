# -*- coding: utf-8 -*-
"""
根据 api_classification.md 的分类，将 03_api_ref 中的单个 API 文档合并为按分类组织的大文档。
"""
import os
import re
import shutil

# 基于当前工作目录（项目根）定位
SRC_DIR = os.path.abspath(os.path.join("docs", "03_api_ref_bak"))
DST_DIR = os.path.abspath(os.path.join("docs", "03_api_ref"))

# ──────────────────────────────────────────────
# 工具函数
# ──────────────────────────────────────────────

def read_file(filepath):
    try:
        with open(filepath, "r", encoding="utf-8") as f:
            return f.read().rstrip("\n")
    except FileNotFoundError:
        print(f"  WARNING: 未找到文件 {os.path.basename(filepath)}")
        return None

def shift_headings(content, levels=1):
    """将 markdown 标题层级下移 levels 层"""
    def replacer(m):
        hashes = m.group(1)
        new_len = min(len(hashes) + levels, 6)
        return "#" * new_len + m.group(2)
    return re.sub(r"^(#{1,6})(\s)", replacer, content, flags=re.MULTILINE)

def read_api_doc(api_name):
    """读取单个 API 文档，返回原始内容"""
    # 处理特殊文件名
    fname = api_name + ".md"
    path = os.path.join(SRC_DIR, fname)
    return read_file(path)

def extract_prototype(content):
    """从 API 文档中提取函数原型"""
    m = re.search(r'#+ *函数原型\s*\n+```\w*\n(.*?)\n```', content, re.DOTALL)
    if m:
        return m.group(1).strip()
    return None

def extract_brief(content):
    """从 API 文档的"功能说明"章节提取第一句话作为简述"""
    m = re.search(r'#+ *功能说明\s*\n+(.*?)(?=\n#+\s|\Z)', content, re.DOTALL)
    if not m:
        return None
    text = m.group(1).strip()
    # 取第一行
    first_line = text.split('\n')[0].strip()
    # 若第一行过长，截取到第一个句号
    if len(first_line) > 80:
        idx = first_line.find('。')
        if idx > 0:
            first_line = first_line[:idx + 1]
    return first_line or None

def build_api_toc(api_names):
    """构建 API 签名快速跳转列表（含功能简述）"""
    toc_lines = []
    for api_name in api_names:
        content = read_api_doc(api_name)
        prototype = extract_prototype(content) if content else None
        brief = extract_brief(content) if content else None
        if prototype:
            proto_oneline = ' '.join(prototype.split())  # 合并多行为单行
            line = f"- [`{proto_oneline}`](#{api_name})"
        else:
            line = f"- [{api_name}](#{api_name})"
        if brief:
            line += f"：{brief}"
        toc_lines.append(line)
    return "\n".join(toc_lines)


def parse_param_types(prototype):
    """从函数原型中解析参数名→数据类型的映射（仅已知数据类型）

    示例: "aclError aclrtMemcpy(..., aclrtMemcpyKind kind)"
    返回: {"kind": "aclrtMemcpyKind"}
    """
    if not _DATA_TYPE_NAMES:
        return {}
    m = re.search(r'\((.+)\)', prototype, re.DOTALL)
    if not m:
        return {}
    type_set = set(_DATA_TYPE_NAMES)
    result = {}
    for param in m.group(1).split(','):
        tokens = param.strip().split()
        if len(tokens) < 2:
            continue
        param_name = tokens[-1].lstrip('*')
        for token in tokens[:-1]:
            clean = token.lstrip('*').rstrip('*').replace('const', '').strip()
            if clean in type_set:
                result[param_name] = clean
                break
    return result

def inject_param_type_links(content, prototype):
    """在参数说明表格中，为已知数据类型的参数注入类型链接

    仅当参数描述中尚未提及该类型名时，在描述末尾追加引用。
    """
    if not prototype:
        return content
    param_types = parse_param_types(prototype)
    if not param_types:
        return content

    def replace_row(m):
        name = m.group(1).strip()
        io = m.group(2)
        desc = m.group(3).rstrip()
        type_name = param_types.get(name)
        if type_name and type_name not in desc:
            # 在描述末尾追加类型链接
            desc = desc.rstrip(' |')
            desc += f"<br>取值详见[{type_name}]({type_name}.md)。"
        return f"| {name} | {io} | {desc} |"

    # 匹配参数表格中的数据行（跳过表头和分隔行）
    content = re.sub(
        r'^\| (\w+) \| (输入|输出) \| (.+?) \|$',
        replace_row, content, flags=re.MULTILINE
    )
    return content

def format_api_section(api_name, heading_level=2):
    """格式化单个 API 文档为合并后的段落"""
    content = read_api_doc(api_name)
    if content is None:
        hashes = "#" * heading_level
        return f"{hashes} {api_name}\n\n> 文档暂缺\n"

    # 提取函数原型
    prototype = extract_prototype(content)

    # 为参数表中的已知数据类型注入链接
    content = inject_param_type_links(content, prototype)

    # 删除原文档中的"函数原型"章节（标题 + 代码块），避免重复
    content = re.sub(r'\n#+ *函数原型\s*\n+```\w*\n.*?\n```\s*', '\n', content, count=1, flags=re.DOTALL)

    # 原始文档第一行是 # apiName，内部小节是 ##
    # 下移 heading_level 层，使内部小节变为 h(heading_level+2)，避免 h2 自带分割线
    shifted = shift_headings(content, heading_level)

    # shift 后 API 名称标题多了一级，需要找到它再替换回正确的级别
    shifted_hashes = "#" * (heading_level + 1)
    shifted_heading = f"{shifted_hashes} {api_name}"

    # 在标题前插入 HTML 锚点，标题后插入函数原型
    hashes = "#" * heading_level
    heading = f"{hashes} {api_name}"
    anchor = f'<a id="{api_name}"></a>'
    if prototype:
        proto_block = f"```c\n{prototype}\n```"
        shifted = shifted.replace(shifted_heading, anchor + "\n\n" + heading + "\n\n" + proto_block, 1)
    else:
        shifted = shifted.replace(shifted_heading, anchor + "\n\n" + heading, 1)

    return shifted

# 需要居中对齐的列名
CENTER_COLUMNS = {"是否支持", "输入/输出"}

def fix_table_alignment(content):
    """优化 Markdown 表格的列对齐：短值列居中，其余左对齐"""
    lines = content.split('\n')
    result = []
    i = 0
    while i < len(lines):
        # 检测表头行 + 分隔行的组合
        if (i + 1 < len(lines)
                and '|' in lines[i]
                and re.match(r'^\|[\s:]*-+[\s:]*(\|[\s:]*-+[\s:]*)*\|?\s*$', lines[i + 1])):
            header_line = lines[i]
            headers = [h.strip() for h in header_line.split('|')[1:-1]]
            new_seps = []
            for header in headers:
                if header in CENTER_COLUMNS:
                    new_seps.append(' :---: ')
                else:
                    new_seps.append(' --- ')
            result.append(header_line)
            result.append('|' + '|'.join(new_seps) + '|')
            i += 2
        else:
            result.append(lines[i])
            i += 1
    return '\n'.join(result)

# API 名称 → 所在输出文件的映射（在 main() 中初始化）
_API_FILE_MAP = {}

# 数据类型名称列表（按长度降序，在 main() 中初始化）
_DATA_TYPE_NAMES = []

def get_data_type_names():
    """从 CATEGORIES 第 23 类提取所有数据类型名称，按长度降序排列"""
    for cat in CATEGORIES:
        if cat["num"] == "24":
            names = []
            for name in cat.get("apis", []):
                # 提取纯英文标识符部分（去掉如"（废弃）"后缀）
                m = re.match(r'([a-zA-Z_]\w*)', name)
                if m:
                    names.append(m.group(1))
            # 按长度降序排列，避免短名称先匹配导致长名称部分匹配
            return sorted(set(names), key=len, reverse=True)
    return []

def auto_link_types(content):
    """为未链接的数据类型名称自动添加 Markdown 跳转链接

    处理逻辑：
    1. 用占位符保护代码块、已有链接、HTML 锚点、标题行
    2. 对剩余文本中的裸数据类型名添加 [name](name.md) 链接
    3. 逆序还原占位符（确保嵌套正确恢复）
    """
    if not _DATA_TYPE_NAMES:
        return content

    placeholders = []

    def save(m):
        idx = len(placeholders)
        placeholders.append(m.group(0))
        return f"XXPH{idx}XXPH"

    # 保护围栏代码块
    content = re.sub(r'```.*?```', save, content, flags=re.DOTALL)
    # 保护行内代码
    content = re.sub(r'`[^`\n]+`', save, content)
    # 保护已有 Markdown 链接 [text](url)
    content = re.sub(r'\[[^\]]*\]\([^\)]*\)', save, content)
    # 保护 HTML 锚点 <a ...>...</a>
    content = re.sub(r'<a\s[^>]*>.*?</a>', save, content, flags=re.DOTALL)
    # 保护标题行（# xxx）
    content = re.sub(r'^#+\s+.*$', save, content, flags=re.MULTILINE)

    # 对每个数据类型名进行词边界匹配并添加链接
    for name in _DATA_TYPE_NAMES:
        content = re.sub(rf'\b({re.escape(name)})\b', rf'[\1](\1.md)', content)

    # 逆序还原占位符（先还原后创建的，确保嵌套正确恢复）
    for idx in range(len(placeholders) - 1, -1, -1):
        content = content.replace(f"XXPH{idx}XXPH", placeholders[idx])

    return content

def build_api_file_map():
    """遍历 CATEGORIES 构建 API名称 → 输出文件名 的映射"""
    api_map = {}
    for cat in CATEGORIES:
        output = cat["output"]
        for api in cat.get("apis", []):
            api_map[api] = output
            # 处理含中文后缀的名称，如 "aclGetDataBufferSize（废弃）"
            base = re.match(r'([a-zA-Z_]\w*)', api)
            if base and base.group(1) != api:
                api_map[base.group(1)] = output
        for sub in cat.get("subcategories", []):
            sub_output = sub.get("output", output)
            for api in sub["apis"]:
                api_map[api] = sub_output
                base = re.match(r'([a-zA-Z_]\w*)', api)
                if base and base.group(1) != api:
                    api_map[base.group(1)] = sub_output
    return api_map

def fix_internal_links(content, current_file):
    """将 (apiName.md) 链接替换为合并后文件的锚点链接

    同文件：](apiName.md) → ](#apiName)
    跨文件：](apiName.md) → ](targetFile.md#apiName)
    """
    def replacer(m):
        api_name = m.group(1)
        if api_name not in _API_FILE_MAP:
            return m.group(0)  # 未知 API，保持原样
        target_file = _API_FILE_MAP[api_name]
        if target_file == current_file:
            return f"](#{api_name})"
        else:
            return f"]({target_file}#{api_name})"
    return re.sub(r'\]\(([a-zA-Z_]\w*)\.md\)', replacer, content)

def write_merged(filename, sections_text):
    path = os.path.join(DST_DIR, filename)
    sections_text = fix_table_alignment(sections_text)
    sections_text = auto_link_types(sections_text)
    sections_text = fix_internal_links(sections_text, filename)
    with open(path, "w", encoding="utf-8") as f:
        f.write(sections_text + "\n")
    print(f"  -> {filename}")

# ──────────────────────────────────────────────
# 分类定义（来自 api_classification.md）
# ──────────────────────────────────────────────

CATEGORIES = [
    # ── 1. 概述（通用说明文档）──
    {
        "num": "01",
        "title": "概述",
        "output": "01_概述.md",
        "guide_files": ["简介.md", "头文件-库文件说明.md", "同步-异步API说明.md", "废弃接口-返回码列表.md"],
        "apis": [],
    },
    # ── 2. 初始化&去初始化 ──
    {
        "num": "02",
        "title": "初始化与去初始化",
        "output": "02_初始化与去初始化.md",
        "apis": [
            "aclInit", "aclFinalize", "aclFinalizeReference",
            "aclInitCallbackRegister", "aclInitCallbackUnRegister",
            "aclFinalizeCallbackRegister", "aclFinalizeCallbackUnRegister",
        ],
    },
    # ── 3. 运行时配置 ──
    {
        "num": "03",
        "title": "运行时配置",
        "output": "03_运行时配置.md",
        "apis": [
            "aclrtSetSysParamOpt", "aclrtGetSysParamOpt",
            "aclrtGetDeviceResLimit", "aclrtSetDeviceResLimit", "aclrtResetDeviceResLimit",
            "aclrtGetStreamResLimit", "aclrtSetStreamResLimit", "aclrtResetStreamResLimit",
            "aclrtUseStreamResInCurrentThread", "aclrtUnuseStreamResInCurrentThread",
            "aclrtGetResInCurrentThread",
        ],
    },
    # ── 4. Device管理 ──
    {
        "num": "04",
        "title": "Device管理",
        "output": "04_Device管理.md",
        "apis": [
            "aclrtSetDevice", "aclrtResetDevice", "aclrtResetDeviceForce",
            "aclrtGetDevice", "aclrtGetRunMode", "aclrtSetTsDevice",
            "aclrtGetDeviceCount", "aclrtGetDeviceUtilizationRate",
            "aclrtQueryDeviceStatus", "aclrtGetSocName",
            "aclrtSetDeviceSatMode", "aclrtGetDeviceSatMode",
            "aclrtDeviceCanAccessPeer", "aclrtDeviceEnablePeerAccess",
            "aclrtDeviceDisablePeerAccess", "aclrtDevicePeerAccessStatus",
            "aclrtGetOverflowStatus", "aclrtResetOverflowStatus",
            "aclrtSynchronizeDevice", "aclrtSynchronizeDeviceWithTimeout",
            "aclrtGetDeviceInfo", "aclrtDeviceGetStreamPriorityRange",
            "aclrtGetDeviceCapability", "aclrtGetDevicesTopo",
            "aclrtRegDeviceStateCallback",
            "aclrtGetLogicDevIdByUserDevId", "aclrtGetUserDevIdByLogicDevId",
            "aclrtGetLogicDevIdByPhyDevId", "aclrtGetPhyDevIdByLogicDevId",
            "aclrtDeviceGetUuid", "aclrtDeviceGetBareTgid",
            "aclrtDeviceGetHostAtomicCapabilities", "aclrtDeviceGetP2PAtomicCapabilities",
        ],
    },
    # ── 5. Context管理 ──
    {
        "num": "05",
        "title": "Context管理",
        "output": "05_Context管理.md",
        "apis": [
            "aclrtCreateContext", "aclrtDestroyContext",
            "aclrtSetCurrentContext", "aclrtGetCurrentContext",
            "aclrtCtxSetSysParamOpt", "aclrtCtxGetSysParamOpt",
            "aclrtCtxGetCurrentDefaultStream", "aclrtGetPrimaryCtxState",
            "aclrtCtxGetFloatOverflowAddr",
        ],
    },
    # ── 6. Stream管理 ──
    {
        "num": "06",
        "title": "Stream管理",
        "output": "06_Stream管理.md",
        "apis": [
            "aclrtCreateStream", "aclrtCreateStreamV2",
            "aclrtSetStreamConfigOpt", "aclrtCreateStreamWithConfig",
            "aclrtDestroyStream", "aclrtDestroyStreamForce",
            "aclrtSetStreamOverflowSwitch", "aclrtGetStreamOverflowSwitch",
            "aclrtSetStreamFailureMode", "aclrtStreamQuery",
            "aclrtSynchronizeStream", "aclrtSynchronizeStreamWithTimeout",
            "aclrtStreamAbort", "aclrtStreamGetId",
            "aclrtGetStreamAvailableNum",
            "aclrtSetStreamAttribute", "aclrtGetStreamAttribute",
            "aclrtActiveStream", "aclrtSwitchStream",
            "aclrtRegStreamStateCallback", "aclrtStreamStop",
            "acIrtStreamStop",
            "aclrtPersistentTaskClean",
            "aclrtStreamGetPriority", "aclrtStreamGetFlags",
        ],
    },
    # ── 7. Event管理 ──
    {
        "num": "07",
        "title": "Event管理",
        "output": "07_Event管理.md",
        "apis": [
            "aclrtCreateEvent", "aclrtCreateEventWithFlag", "aclrtCreateEventExWithFlag",
            "aclrtDestroyEvent", "aclrtRecordEvent", "aclrtResetEvent",
            "aclrtQueryEvent（废弃）", "aclrtQueryEventStatus", "aclrtQueryEventWaitStatus",
            "aclrtSynchronizeEvent", "aclrtSynchronizeEventWithTimeout",
            "aclrtEventElapsedTime",
            "aclrtStreamWaitEvent", "aclrtStreamWaitEventWithTimeout",
            "aclrtSetOpWaitTimeout", "aclrtEventGetTimestamp",
            "aclrtGetEventId", "aclrtGetEventAvailNum",
            "aclrtIpcGetEventHandle", "aclrtIpcOpenEventHandle",
        ],
    },
    # ── 8. Notify管理 ──
    {
        "num": "08",
        "title": "Notify管理",
        "output": "08_Notify管理.md",
        "apis": [
            "aclrtCreateNotify", "aclrtDestroyNotify",
            "aclrtRecordNotify", "aclrtWaitAndResetNotify",
            "aclrtGetNotifyId", "aclrtNotifyBatchReset",
            "aclrtNotifyGetExportKey", "aclrtNotifySetImportPid",
            "aclrtNotifySetImportPidInterServer", "aclrtNotifyImportByKey",
        ],
    },
    # ── 9. CntNotify管理 ──
    {
        "num": "09",
        "title": "CntNotify管理",
        "output": "09_CntNotify管理.md",
        "apis": [
            "aclrtCntNotifyCreate", "aclrtCntNotifyRecord",
            "aclrtCntNotifyWaitWithTimeout", "aclrtCntNotifyReset",
            "aclrtCntNotifyGetId", "aclrtCntNotifyDestroy",
        ],
    },
    # ── 10. Label管理 ──
    {
        "num": "10",
        "title": "Label管理",
        "output": "10_Label管理.md",
        "apis": [
            "aclrtCreateLabel", "aclrtSetLabel", "aclrtDestroyLabel",
            "aclrtCreateLabelList", "aclrtDestroyLabelList",
            "aclrtSwitchLabelByIndex",
        ],
    },
    # ── 11. 内存管理（有二级分类，每个子类独立文件）──
    {
        "num": "11",
        "title": "内存管理",
        "output": "11_内存管理.md",
        "guide_files": ["内存使用说明.md"],
        "subcategories": [
            {
                "title": "11-01 设备内存分配与释放",
                "output": "11-01_设备内存分配与释放.md",

                "apis": [
                    "aclrtMalloc", "aclrtMallocAlign32", "aclrtMallocCached",
                    "aclrtMallocWithCfg", "aclrtMallocForTaskScheduler",
                    "aclrtFree", "aclrtFreeWithDevSync",
                ],
            },
            {
                "title": "11-02 主机内存管理",
                "output": "11-02_主机内存管理.md",

                "apis": [
                    "aclrtMallocHost", "aclrtMallocHostWithCfg",
                    "aclrtFreeHost", "aclrtFreeHostWithDevSync",
                    "aclrtHostRegister", "aclrtHostRegisterV2",
                    "aclrtHostGetDevicePointer", "aclrtHostMemMapCapabilities",
                    "aclrtHostUnregister",
                ],
            },
            {
                "title": "11-03 内存拷贝与设置",
                "output": "11-03_内存拷贝与设置.md",

                "apis": [
                    "aclrtMemcpy", "aclrtMemcpyAsync", "aclrtMemcpyAsyncWithCondition",
                    "aclrtMemcpyBatch", "aclrtMemcpyBatchAsync",
                    "aclrtMemcpyBatchV2", "aclrtMemcpyBatchAsyncV2",
                    "aclrtMemcpy2d", "aclrtMemcpy2dAsync",
                    "aclrtGetMemcpyDescSize", "aclrtSetMemcpyDesc",
                    "aclrtMemcpyAsyncWithDesc", "aclrtMemcpyAsyncWithOffset",
                    "aclrtMemset", "aclrtMemsetAsync",
                ],
            },
            {
                "title": "11-04 虚拟内存管理",
                "output": "11-04_虚拟内存管理.md",

                "apis": [
                    "aclrtMallocPhysical", "aclrtFreePhysical",
                    "aclrtReserveMemAddress", "aclrtReserveMemAddressNoUCMemory",
                    "aclrtReleaseMemAddress",
                    "aclrtMapMem", "aclrtUnmapMem",
                    "aclrtMemExportToShareableHandle", "aclrtMemSetPidToShareableHandle",
                    "aclrtMemImportFromShareableHandle",
                    "aclrtMemExportToShareableHandleV2", "aclrtMemSetPidToShareableHandleV2",
                    "aclrtMemImportFromShareableHandleV2",
                    "aclrtMemGetAllocationGranularity",
                    "aclrtMemSetAccess", "aclrtMemGetAccess",
                    "aclrtMemRetainAllocationHandle",
                    "aclrtMemGetAllocationPropertiesFromHandle",
                    "aclrtMemGetAddressRange",
                ],
            },
            {
                "title": "11-05 统一/托管内存",
                "output": "11-05_统一托管内存.md",

                "apis": [
                    "aclrtMemAllocManaged", "aclrtMemManagedAdvise",
                    "aclrtMemManagedGetAttr", "aclrtMemManagedGetAttrs",
                    "aclrtMemManagedPrefetchAsync", "aclrtMemManagedPrefetchBatchAsync",
                    "aclrtMemP2PMap",
                ],
            },
            {
                "title": "11-06 CMO 缓存操作",
                "output": "11-06_CMO缓存操作.md",

                "apis": [
                    "aclrtMemFlush", "aclrtMemInvalidate",
                    "aclrtCmoAsync", "aclrtCmoAsyncWithBarrier",
                    "aclrtCmoWaitBarrier",
                    "aclrtCmoGetDescSize", "aclrtCmoSetDesc", "aclrtCmoAsyncWithDesc",
                ],
            },
            {
                "title": "11-07 IPC 进程间内存共享",
                "output": "11-07_IPC进程间内存共享.md",

                "apis": [
                    "aclrtIpcMemGetExportKey", "aclrtIpcMemSetImportPid",
                    "aclrtIpcMemImportPidInterServer", "aclrtIpcMemImportByKey",
                    "aclrtIpcMemSetAttr", "aclrtIpcMemClose",
                ],
            },
            {
                "title": "11-08 内存信息查询与属性",
                "output": "11-08_内存信息查询与属性.md",

                "apis": [
                    "aclrtGetMemInfo", "aclrtGetMemUsageInfo",
                    "aclrtPointerGetAttributes", "aclrtCheckMemType",
                ],
            },
            {
                "title": "11-09 自定义 Allocator",
                "output": "11-09_自定义Allocator.md",

                "apis": [
                    "aclrtAllocatorRegister", "aclrtAllocatorGetByStream",
                    "aclrtAllocatorUnregister",
                ],
            },
            {
                "title": "11-10 内存值写入与等待",
                "output": "11-10_内存值写入与等待.md",

                "apis": [
                    "aclrtValueWrite", "aclrtValueWait",
                ],
            },
        ],
    },
    # ── 12. 执行控制 ──
    {
        "num": "12",
        "title": "执行控制",
        "output": "12_执行控制.md",
        "apis": [
            "aclrtLaunchCallback",
            "aclrtSubscribeReport", "aclrtProcessReport", "aclrtUnSubscribeReport",
            "aclrtSubscribeHostFunc", "aclrtProcessHostFunc", "aclrtUnSubscribeHostFunc",
            "aclrtGetOpTimeoutInterval",
            "aclrtSetOpExecuteTimeOut", "aclrtSetOpExecuteTimeOutV2",
            "aclrtSetOpExecuteTimeOutWithMs", "aclrtGetOpExecuteTimeOut",
            "aclrtGetThreadLastTaskId",
            "aclrtReduceAsync", "aclrtLaunchHostFunc",
            "aclrtRandomNumAsync", "aclrtTaskUpdateAsync",
        ],
    },
    # ── 13. 异常处理 ──
    {
        "num": "13",
        "title": "异常处理",
        "output": "13_异常处理.md",
        "apis": [
            "aclGetRecentErrMsg",
            "aclrtSetExceptionInfoCallback",
            "aclrtGetTaskIdFromExceptionInfo", "aclrtGetStreamIdFromExceptionInfo",
            "aclrtGetThreadIdFromExceptionInfo", "aclrtGetDeviceIdFromExceptionInfo",
            "aclrtGetErrorCodeFromExceptionInfo",
            "aclrtPeekAtLastError", "aclrtGetLastError",
            "aclrtGetMemUceInfo", "aclrtMemUceRepair",
            "aclrtDeviceTaskAbort", "aclRecoverAllHcclTasks",
            "aclrtGetErrorVerbose", "aclrtRepairError",
            "aclrtSetDeviceTaskAbortCallback",
            "RegisterFormatErrorMessage",
            "ReportInnerErrMsg", "ReportPredefinedErrMsg", "ReportUserDefinedErrMsg",
        ],
    },
    # ── 14. Kernel加载与执行 ──
    {
        "num": "14",
        "title": "Kernel加载与执行",
        "output": "14_Kernel加载与执行.md",
        "guide_files": ["概念及使用说明.md"],
        "apis": [
            "aclrtBinaryLoadFromFile", "aclrtBinaryLoadFromData",
            "aclrtBinaryGetFunction", "aclrtBinaryGetFunctionByEntry",
            "aclrtBinaryGetDevAddress", "aclrtBinarySetExceptionCallback",
            "aclrtGetArgsFromExceptionInfo", "aclrtGetFuncHandleFromExceptionInfo",
            "aclrtGetFunctionAddr", "aclrtGetFunctionSize",
            "aclrtGetFunctionName", "aclrtGetFunctionAttribute",
            "aclrtGetHardwareSyncAddr", "aclrtRegisterCpuFunc",
            "aclrtKernelArgsInit", "aclrtKernelArgsInitByUserMem",
            "aclrtKernelArgsGetMemSize", "aclrtKernelArgsGetHandleMemSize",
            "aclrtKernelArgsAppend", "aclrtKernelArgsAppendPlaceHolder",
            "aclrtKernelArgsGetPlaceHolderBuffer", "aclrtKernelArgsParaUpdate",
            "aclrtKernelArgsFinalize",
            "aclrtLaunchKernel", "aclrtLaunchKernelV2",
            "aclrtLaunchKernelWithConfig", "aclrtLaunchKernelWithHostArgs",
            "aclrtCreateBinary", "aclrtDestroyBinary",
            "aclrtBinaryLoad", "aclrtBinaryUnLoad",
            "aclrtFunctionGetBinary",
        ],
    },
    # ── 15. 模型运行实例管理 ──
    {
        "num": "15",
        "title": "模型运行实例管理",
        "output": "15_模型运行实例管理.md",
        "apis": [
            "aclmdlRICaptureBegin", "aclmdlRICaptureGetInfo",
            "aclmdlRICaptureThreadExchangeMode", "aclmdlRICaptureEnd",
            "aclmdlRICaptureTaskGrpBegin", "aclmdlRICaptureTaskGrpEnd",
            "aclmdlRICaptureTaskUpdateBegin", "aclmdlRICaptureTaskUpdateEnd",
            "aclmdlRIDebugJsonPrint", "aclmdlRIDebugPrint",
            "aclmdlRIBuildBegin", "aclmdlRIBindStream",
            "aclmdlRIEndTask", "aclmdlRIBuildEnd",
            "aclmdlRIUnbindStream",
            "aclmdlRIExecute", "aclmdlRIExecuteAsync",
            "aclmdlRIDestroy", "aclmdlRISetName", "aclmdlRIGetName",
            "aclrtCheckArchCompatibility",
            "aclmdlRIAbort", "aclmdlRIGetStreams",
            "aclmdlRIGetTasksByStream", "aclmdlRITaskGetSeqId",
            "aclmdlRITaskGetParams", "aclmdlRITaskSetParams",
            "aclmdlRITaskDisable", "aclmdlRIUpdate",
            "aclmdlRITaskGetType",
            "aclmdlRIDestroyRegisterCallback", "aclmdlRIDestroyUnregisterCallback",
        ],
    },
    # ── 16. 算力Group查询与设置 ──
    {
        "num": "16",
        "title": "算力Group查询与设置",
        "output": "16_算力Group查询与设置.md",
        "apis": [
            "aclrtSetGroup", "aclrtGetGroupCount",
            "aclrtGetAllGroupInfo", "aclrtGetGroupInfoDetail",
            "aclrtCreateGroupInfo", "aclrtDestroyGroupInfo",
        ],
    },
    # ── 17. 数据传输（有二级分类）──
    {
        "num": "17",
        "title": "数据传输",
        "output": "17_数据传输.md",
        "subcategories": [
            {
                "title": "17-01 Tensor数据传输",
                "output": "17-01_Tensor数据传输.md",
                "apis": [
                    "acltdtCreateChannel", "acltdtCreateChannelWithCapacity",
                    "acltdtSendTensor", "acltdtReceiveTensor",
                    "acltdtStopChannel", "acltdtDestroyChannel",
                    "acltdtQueryChannelSize", "acltdtGetSliceInfoFromItem",
                    "acltdtCleanChannel",
                ],
            },
            {
                "title": "17-02 共享队列管理",
                "output": "17-02_共享队列管理.md",
                "guide_files": ["使用说明.md"],
                "apis": [
                    "acltdtCreateQueue", "acltdtDestroyQueue",
                    "acltdtEnqueueData", "acltdtDequeueData",
                    "acltdtEnqueue", "acltdtDequeue",
                    "acltdtBindQueueRoutes", "acltdtUnbindQueueRoutes",
                    "acltdtQueryQueueRoutes",
                    "acltdtGrantQueue", "acltdtAttachQueue",
                ],
            },
            {
                "title": "17-03 共享Buffer管理",
                "output": "17-03_共享Buffer管理.md",
                "apis": [
                    "acltdtAllocBuf", "acltdtFreeBuf",
                    "acltdtGetBufData", "acltdtSetBufUserData", "acltdtGetBufUserData",
                    "acltdtSetBufDataLen", "acltdtGetBufDataLen",
                    "acltdtCopyBufRef", "acltdtAppendBufChain",
                    "acltdtGetBufChainNum", "acltdtGetBufFromChain",
                ],
            },
        ],
    },
    # ── 18. Dump配置 ──
    {
        "num": "18",
        "title": "Dump配置",
        "output": "18_Dump配置.md",
        "apis": [
            "aclmdlInitDump", "aclmdlSetDump",
            "acldumpRegCallback", "acldumpUnregCallback",
            "acldumpGetPath", "aclmdlFinalizeDump",
            "aclopStartDumpArgs", "aclopStopDumpArgs",
        ],
    },
    # ── 19. Profiling数据采集（有二级分类）──
    {
        "num": "19",
        "title": "Profiling数据采集",
        "output": "19_Profiling数据采集.md",
        "subcategories": [
            {
                "title": "19-01 Profiling数据采集接口",
                "output": "19-01_Profiling数据采集接口.md",
                "guide_files": ["数据采集说明.md"],
                "apis": [
                    "aclprofInit", "aclprofSetConfig",
                    "aclprofStart", "aclprofStop", "aclprofFinalize",
                    "aclprofStr2Id",
                ],
            },
            {
                "title": "19-02 msproftx扩展接口",
                "output": "19-02_msproftx扩展接口.md",
                "guide_files": ["扩展接口使用说明.md"],
                "apis": [
                    "aclprofCreateStamp", "aclprofSetStampTraceMessage",
                    "aclprofMark", "aclprofMarkEx",
                    "aclprofPush", "aclprofPop",
                    "aclprofRangeStart", "aclprofRangeStop",
                    "aclprofRangePushEx", "aclprofRangePop",
                    "aclprofDestroyStamp",
                ],
            },
            {
                "title": "19-03 订阅算子信息",
                "output": "19-03_订阅算子信息.md",
                "guide_files": ["订阅接口使用说明.md"],
                "apis": [
                    "aclprofModelSubscribe", "aclprofModelUnSubscribe",
                    "aclprofGetOpDescSize", "aclprofGetOpNum",
                    "aclprofGetOpTypeLen", "aclprofGetOpType",
                    "aclprofGetOpNameLen", "aclprofGetOpName",
                    "aclprofGetOpStart", "aclprofGetOpEnd",
                    "aclprofGetOpDuration", "aclprofGetModelId",
                ],
            },
            {
                "title": "19-04 PyTorch场景标记迭代时间",
                "output": "19-04_PyTorch场景标记迭代时间.md",
                "apis": ["aclprofGetStepTimestamp"],
            },
        ],
    },
    # ── 20. 共享Buffer管理（预留） ──
    {
        "num": "20",
        "title": "共享Buffer管理（预留，暂不支持）",
        "output": "20_共享Buffer管理_预留.md",
        "apis": [
            "aclrtAllocBuf", "aclrtFreeBuf",
            "aclrtGetBufData", "aclrtSetBufUserData", "aclrtGetBufUserData",
            "aclrtGetBufDataLen", "aclrtSetBufDataLen",
            "aclrtCopyBufRef", "aclrtAppendBufChain",
            "aclrtGetBufFromChain", "aclrtGetBufChainNum",
        ],
    },
    # ── 21. 快照管理 ──
    {
        "num": "21",
        "title": "快照管理",
        "output": "21_快照管理.md",
        "apis": [
            "aclrtSnapShotProcessLock", "aclrtSnapShotProcessBackup",
            "aclrtSnapShotProcessRestore", "aclrtSnapShotProcessUnlock",
            "aclrtSnapShotCallbackRegister", "aclrtSnapShotCallbackUnregister",
        ],
    },
    # ── 22. Stream有序内存分配 ──
    {
        "num": "22",
        "title": "Stream有序内存分配",
        "output": "22_Stream有序内存分配.md",
        "guide_files": ["SOMA原理说明.md", "Stream有序内存分配使用说明.md"],
        "apis": [
            "aclrtMemPoolCreate", "aclrtMemPoolDestroy",
            "aclrtMemPoolSetAttr", "aclrtMemPoolGetAttr",
            "aclrtMemPoolMallocAsync", "aclrtMemPoolFreeAsync",
            "aclrtMemPoolTrimTo",
        ],
    },
    # ── 23. 其他接口 ──
    {
        "num": "23",
        "title": "其他接口",
        "output": "23_其他接口.md",
        "apis": [
            "AlogCheckDebugLevel", "AlogRecord",
            "aclAppLog", "aclDataTypeSize",
            "aclFloat16ToFloat", "aclFloatToFloat16",
            "aclrtGetVersion", "aclsysGetCANNVersion", "aclsysGetCANNVersion（废弃）",
            "aclGetCannAttributeList", "aclGetCannAttribute",
            "aclGetDeviceCapability",
            "aclrtCacheLastTaskOpInfo", "aclrtProfTrace",
            "aclsysGetVersionNum", "aclsysGetVersionStr",
        ],
    },
    # ── 24. 数据类型及其操作接口 ──
    {
        "num": "24",
        "title": "数据类型及其操作接口",
        "output": "24_数据类型及其操作接口.md",
        "apis": [
            "aclCannAttr", "aclCANNPackageName", "aclCANNPackageVersion",
            "aclCreateDataBuffer",
            "aclDataBuffer", "aclDataType",
            "aclDestroyDataBuffer", "aclDeviceInfo", "acldumpType",
            "aclError", "aclFloat16", "aclFormat",
            "aclGetDataBufferAddr", "aclGetDataBufferSizeV2", "aclGetDataBufferSize（废弃）",
            "aclmdlRI", "aclmdlRICaptureMode", "aclmdlRICaptureStatus",
            "aclmdlRIEventRecordTaskParams", "aclmdlRIEventResetTaskParams", "aclmdlRIEventWaitTaskParams",
            "aclmdlRIKernelTaskParams",
            "aclmdlRITask", "aclmdlRITaskParams", "aclmdlRITaskType",
            "aclmdlRIValueWaitTaskParams", "aclmdlRIValueWriteTaskParams",
            "aclMemType",
            "aclprofAicoreMetrics",
            "aclprofConfig", "aclprofConfigType",
            "aclprofCreateConfig", "aclprofCreateStepInfo", "aclprofCreateSubscribeConfig",
            "aclprofDestroyConfig", "aclprofDestroyStepInfo", "aclprofDestroySubscribeConfig",
            "aclprofEventAttributes",
            "aclprofStepInfo", "aclprofStepTag", "aclprofSubscribeConfig",
            "aclRegisterCallbackType",
            "aclrtAicAivTaskUpdateAttr",
            "aclrtAllocator", "aclrtAllocatorAddr", "aclrtAllocatorBlock",
            "aclrtAllocatorCreateDesc", "aclrtAllocatorDesc", "aclrtAllocatorDestroyDesc",
            "aclrtAllocatorSetAllocAdviseFuncToDesc", "aclrtAllocatorSetAllocFuncToDesc",
            "aclrtAllocatorSetFreeFuncToDesc", "aclrtAllocatorSetGetAddrFromBlockFuncToDesc",
            "aclrtAllocatorSetObjToDesc",
            "aclrtArgsHandle",
            "aclrtAtomicOperation", "aclrtAtomicOperationCapability",
            "aclrtBarrierCmoInfo", "aclrtBarrierTaskInfo",
            "aclrtBinaryLoadOption", "aclrtBinaryLoadOptions",
            "aclrtBinaryLoadOptionType", "aclrtBinaryLoadOptionValue",
            "aclrtBinHandle",
            "aclrtCmoType",
            "aclrtCntNotify", "aclrtCntNotifyRecordInfo", "aclrtCntNotifyRecordMode",
            "aclrtCntNotifyWaitInfo", "aclrtCntNotifyWaitMode",
            "aclrtCompareDataType", "aclrtCondition", "aclrtContext",
            "aclrtCreateStreamConfigHandle",
            "aclrtDestroyStreamConfigHandle",
            "aclrtDevAttr", "aclrtDevFeatureType", "aclrtDeviceStatus", "aclrtDevResLimitType",
            "aclrtDropoutBitmaskInfo", "aclrtDrvMemHandle",
            "aclrtEngineType", "aclrtEvent",
            "aclrtEventRecordedStatus", "aclrtEventStatus", "aclrtEventWaitStatus",
            "aclrtFloatOverflowMode",
            "aclrtFuncAttribute", "aclrtFuncHandle",
            "aclrtGroupAttr",
            "aclrtHacType", "aclrtHostMemMapCapability", "aclrtHostRegisterType",
            "aclrtIpcEventHandle", "aclrtIpcMemAttrType",
            "aclrtKernelType",
            "aclrtLabel", "aclrtLabelList", "aclrtLastErrLevel",
            "aclrtLaunchKernelAttr", "aclrtLaunchKernelAttrId",
            "aclrtLaunchKernelAttrValue", "aclrtLaunchKernelCfg",
            "aclrtMallocAttribute", "aclrtMallocAttrType", "aclrtMallocAttrValue", "aclrtMallocConfig",
            "aclrtMbuf",
            "aclrtMemAccessDesc", "aclrtMemAccessFlags", "aclrtMemAllocationType", "aclrtMemAttr",
            "aclrtMemcpyBatchAttr", "aclrtMemcpyKind",
            "aclrtMemGranularityOptions", "aclrtMemHandleType",
            "aclrtMemLocation", "aclrtMemLocationType", "aclrtMemMallocPolicy",
            "aclrtMemManagedAdviseType", "aclrtMemManagedLocation",
            "aclrtMemManagedLocationType", "aclrtMemManagedRangeAttribute",
            "aclrtMemPool", "aclrtMemPoolAttr", "aclrtMemPoolProps",
            "aclrtMemSharedHandleType", "aclrtMemUceInfo", "aclrtMemUsageInfo",
            "aclrtNormalDisInfo", "aclrtNotify",
            "aclrtParamHandle", "aclrtPhysicalMemProp", "aclrtPtrAttributes",
            "aclrtRandomNumFuncParaInfo", "aclrtRandomNumFuncType",
            "aclrtRandomNumTaskInfo", "aclrtRandomParaInfo", "aclrtRandomTaskUpdateAttr",
            "aclrtReduceKind", "aclrtRunMode",
            "aclrtServerPid", "aclrtSnapShotStage",
            "aclrtStream", "aclrtStreamAttr", "aclrtStreamAttrValue",
            "aclrtStreamConfigAttr", "aclrtStreamConfigHandle", "aclrtStreamStatus",
            "aclrtTaskGrp", "aclrtTaskUpdateInfo", "aclrtTimeoutUs",
            "aclrtUniformDisInfo",
            "aclrtUpdateTaskAttrId", "aclrtUpdateTaskAttrVal",
            "aclrtUtilizationInfo", "aclrtUuid",
            "aclSysParamOpt",
            "acltdtAddDataItem", "acltdtAddQueueRoute", "acltdtBuf",
            "acltdtCreateDataItem", "acltdtCreateDataset",
            "acltdtCreateQueueAttr", "acltdtCreateQueueRoute",
            "acltdtCreateQueueRouteList", "acltdtCreateQueueRouteQueryInfo",
            "acltdtDataItem", "acltdtDataset",
            "acltdtDestroyDataItem", "acltdtDestroyDataset",
            "acltdtDestroyQueueAttr", "acltdtDestroyQueueRoute",
            "acltdtDestroyQueueRouteList", "acltdtDestroyQueueRouteQueryInfo",
            "acltdtGetDataAddrFromItem", "acltdtGetDataItem",
            "acltdtGetDatasetName", "acltdtGetDatasetSize",
            "acltdtGetDataSizeFromItem", "acltdtGetDataTypeFromItem",
            "acltdtGetDimNumFromItem", "acltdtGetDimsFromItem",
            "acltdtGetQueueAttr", "acltdtGetQueueRoute",
            "acltdtGetQueueRouteNum", "acltdtGetQueueRouteParam",
            "acltdtGetTensorTypeFromItem",
            "acltdtQueueAttr", "acltdtQueueAttrType",
            "acltdtQueueRoute", "acltdtQueueRouteList",
            "acltdtQueueRouteParamType", "acltdtQueueRouteQueryInfo",
            "acltdtQueueRouteQueryInfoParamType", "acltdtQueueRouteQueryMode",
            "acltdtSetQueueAttr", "acltdtSetQueueRouteQueryInfo",
            "acltdtTensorType",
            "aclUpdateDataBuffer",
        ],
    },
]

# ──────────────────────────────────────────────
# 分类描述（按 output 文件名索引）
# ──────────────────────────────────────────────

DESCRIPTIONS = {
    # 一级分类
    "01_概述.md":
        "本章节介绍 CANN Runtime API 的基本概念、头文件与库文件说明、同步/异步接口说明及废弃接口列表。",
    "02_初始化与去初始化.md":
        "本章节描述 CANN Runtime 的初始化与去初始化接口，包括 ACL 环境的初始化、反初始化及相关回调注册。",
    "03_运行时配置.md":
        "本章节描述 CANN Runtime 的运行时配置接口，用于设置和查询系统参数、设备资源限制及 Stream 资源限制。",
    "04_Device管理.md":
        "本章节描述 CANN Runtime 的设备管理接口，用于设备的设置、重置、查询、同步及 P2P 访问等操作。",
    "05_Context管理.md":
        "本章节描述 CANN Runtime 的 Context 管理接口，用于 Context 的创建、销毁、切换及参数配置。",
    "06_Stream管理.md":
        "本章节描述 CANN Runtime 的 Stream 管理接口，用于 Stream 的创建、销毁、同步、查询及属性配置。",
    "07_Event管理.md":
        "本章节描述 CANN Runtime 的 Event 管理接口，用于事件的创建、记录、同步、计时及 IPC 跨进程共享。",
    "08_Notify管理.md":
        "本章节描述 CANN Runtime 的 Notify 管理接口，用于 Notify 的创建、记录、等待/重置及跨进程共享。",
    "09_CntNotify管理.md":
        "本章节描述 CANN Runtime 的 CntNotify（计数型通知）管理接口，用于 CntNotify 的创建、记录、等待及销毁。",
    "10_Label管理.md":
        "本章节描述 CANN Runtime 的 Label 管理接口，用于 Label 的创建、设置、销毁及条件分支控制。",
    "11_内存管理.md":
        "本章节描述 CANN Runtime 的内存管理接口，涵盖设备内存分配、主机内存管理、内存拷贝、虚拟内存、统一内存、缓存操作、IPC 内存共享等功能。",
    "12_执行控制.md":
        "本章节描述 CANN Runtime 的执行控制接口，包括回调函数启动、Host 函数订阅、超时设置及异步 Reduce 操作。",
    "13_异常处理.md":
        "本章节描述 CANN Runtime 的异常处理接口，包括错误信息获取、异常回调注册、内存 UCE 修复及任务中止。",
    "14_Kernel加载与执行.md":
        "本章节描述 CANN Runtime 的 Kernel 加载与执行接口，包括二进制加载、函数获取、参数组装及 Kernel 启动。",
    "15_模型运行实例管理.md":
        "本章节描述 CANN Runtime 的模型运行实例（RI）管理接口，用于 RI 的捕获、构建、执行及任务管理。",
    "16_算力Group查询与设置.md":
        "本章节描述 CANN Runtime 的算力 Group 接口，用于 AI Core 分组的设置、查询及信息获取。",
    "17_数据传输.md":
        "本章节描述 CANN Runtime 的数据传输接口，涵盖 Tensor 数据传输、共享队列管理及共享 Buffer 管理。",
    "18_Dump配置.md":
        "本章节描述 CANN Runtime 的 Dump 配置接口，用于算子数据 Dump 的初始化、配置及回调注册。",
    "19_Profiling数据采集.md":
        "本章节描述 CANN Runtime 的 Profiling 数据采集接口，涵盖性能数据采集、msproftx 扩展标记及算子信息订阅。",
    "20_共享Buffer管理_预留.md":
        "本章节描述预留的共享 Buffer 管理接口（当前版本暂不支持）。",
    "21_快照管理.md":
        "本章节描述 CANN Runtime 的快照管理接口，用于进程状态的锁定、备份、恢复及回调注册。",
    "22_Stream有序内存分配.md":
        "本章节描述 CANN Runtime 的 Stream 有序内存分配（SOMA）接口，用于内存池的创建、配置及异步内存分配与释放。",
    "23_其他接口.md":
        "本章节描述 CANN Runtime 的其他辅助接口，包括版本查询、数据类型转换、日志记录等。",
    "24_数据类型及其操作接口.md":
        "本章节描述 CANN Runtime 使用的数据类型定义及其操作接口，包括基础类型、DataBuffer、Dataset、QueueAttr 等系列。",
    # 二级分类 —— 内存管理
    "11-01_设备内存分配与释放.md":
        "本章节描述设备（Device）内存的分配与释放接口。",
    "11-02_主机内存管理.md":
        "本章节描述主机（Host）内存的分配、释放、注册及指针获取接口。",
    "11-03_内存拷贝与设置.md":
        "本章节描述 Host-Device 间及 Device-Device 间的内存拷贝与内存设置接口。",
    "11-04_虚拟内存管理.md":
        "本章节描述虚拟内存管理接口，包括物理内存分配、虚拟地址预留、内存映射及跨进程共享。",
    "11-05_统一托管内存.md":
        "本章节描述统一/托管内存（Unified/Managed Memory）接口，用于自动迁移的内存分配、预取及属性查询。",
    "11-06_CMO缓存操作.md":
        "本章节描述 CMO（Cache Maintenance Operations）缓存操作接口，用于缓存刷新与失效操作。",
    "11-07_IPC进程间内存共享.md":
        "本章节描述 IPC（Inter-Process Communication）进程间内存共享接口，用于跨进程的内存导出与导入。",
    "11-08_内存信息查询与属性.md":
        "本章节描述内存信息查询与属性接口，用于查询空闲内存信息、指针属性及内存类型。",
    "11-09_自定义Allocator.md":
        "本章节描述自定义 Allocator 接口，用于注册、查询和注销用户自定义的内存分配器。",
    "11-10_内存值写入与等待.md":
        "本章节描述内存值写入与等待接口，用于在 Stream 上异步写入/等待内存值。",
    # 二级分类 —— 数据传输
    "17-01_Tensor数据传输.md":
        "本章节描述 Tensor 数据传输接口，用于 Host-Device 间 Tensor 数据的通道创建、发送与接收。",
    "17-02_共享队列管理.md":
        "本章节描述共享队列管理接口，用于队列的创建、销毁、入队、出队及路由管理。",
    "17-03_共享Buffer管理.md":
        "本章节描述共享 Buffer 管理接口，用于 Buffer 的分配、释放、数据操作及 Buffer 链管理。",
    # 二级分类 —— Profiling数据采集
    "19-01_Profiling数据采集接口.md":
        "本章节描述 Profiling 数据采集的核心接口，用于性能采集的初始化、配置、启停控制。",
    "19-02_msproftx扩展接口.md":
        "本章节描述 msproftx 扩展接口，用于自定义性能标记（Stamp）、范围标记及调用栈标记。",
    "19-03_订阅算子信息.md":
        "本章节描述算子信息订阅接口，用于订阅模型中算子的执行信息（类型、名称、耗时等）。",
    "19-04_PyTorch场景标记迭代时间.md":
        "本章节描述 PyTorch 场景下标记迭代时间的接口。",
}


# ──────────────────────────────────────────────
# 主逻辑
# ──────────────────────────────────────────────

def build_guide_section(guide_files, heading_shift=1):
    """读取指导文档并拼合"""
    parts = []
    for gf in (guide_files or []):
        path = os.path.join(SRC_DIR, gf)
        content = read_file(path)
        if content:
            shifted = shift_headings(content, heading_shift)
            parts.append(shifted)
    return parts

def build_subcategory_file(sub):
    """构建一个二级分类的独立 markdown 文本"""
    lines = []
    sub_title = sub["title"]
    lines.append(f"# {sub_title}\n")
    desc = DESCRIPTIONS.get(sub.get("output", ""), "")
    if desc:
        lines.append(f"{desc}\n")

    # API 签名目录
    api_names = sub["apis"]
    if api_names:
        lines.append(build_api_toc(api_names))
        lines.append("")

    # 子分类指导文档
    for part in build_guide_section(sub.get("guide_files"), heading_shift=1):
        lines.append(part)
        lines.append("\n---\n")

    for i, api in enumerate(api_names):
        if i > 0:
            lines.append("\n\n<br>\n<br>\n<br>\n\n")
        section = format_api_section(api, heading_level=1)
        lines.append(f"\n{section}")

    return "\n".join(lines)

def build_category(cat):
    """构建一个分类的完整 markdown 文本"""
    lines = []
    num = str(int(cat["num"]))  # "03" → "3"
    title = cat["title"]
    lines.append(f"# {num}. {title}\n")
    desc = DESCRIPTIONS.get(cat["output"], "")
    if desc:
        lines.append(f"{desc}\n")

    # 指导文档（一级）
    for part in build_guide_section(cat.get("guide_files"), heading_shift=1):
        lines.append(part)
        lines.append("\n---\n")

    subcategories = cat.get("subcategories")
    apis = cat.get("apis", [])

    if subcategories:
        # 有二级分类 → 父文件只写概述 + 子类链接列表
        lines.append("\n本分类包含以下子类：\n")
        for sub in subcategories:
            sub_title = sub["title"]
            sub_output = sub.get("output", "")
            api_count = len(sub["apis"])
            lines.append(f"- [{sub_title}]({sub_output})（{api_count} 个接口）")
        lines.append("")
    elif apis:
        # API 签名目录
        lines.append(build_api_toc(apis))
        lines.append("")
        # 无二级分类，直接列出 API
        for i, api in enumerate(apis):
            if i > 0:
                lines.append("\n\n<br>\n<br>\n<br>\n\n")
            section = format_api_section(api, heading_level=1)
            lines.append(f"\n{section}")
    elif cat.get("guide_files"):
        # 纯指导文档（如概述）
        pass

    return "\n".join(lines)

def build_index():
    """生成总索引文件"""
    lines = ["# Runtime API 参考\n"]
    for cat in CATEGORIES:
        output = cat["output"]
        num = str(int(cat["num"]))
        title = cat["title"]
        lines.append(f"- ## [{num}. {title}]({output})")
        # 如有子分类，也列出
        for sub in cat.get("subcategories", []):
            sub_output = sub.get("output", "")
            sub_title = sub["title"]
            lines.append(f"    - ### [{sub_title}]({sub_output})")
    return "\n".join(lines)

def copy_figures():
    """复制 figures 目录"""
    src_figures = os.path.join(SRC_DIR, "figures")
    dst_figures = os.path.join(DST_DIR, "figures")
    if os.path.isdir(src_figures) and not os.path.isdir(dst_figures):
        shutil.copytree(src_figures, dst_figures)
        print("  -> 复制 figures/ 目录")

def detect_unregistered_files(scan_dir=None):
    """检测指定目录中未在 CATEGORIES 中注册的 .md 文件。

    Args:
        scan_dir: 要扫描的目录路径。默认为 SRC_DIR（03_api_ref_bak）。
                  备份前可传入 03_api_ref 目录路径。
    """
    target_dir = scan_dir or SRC_DIR
    # 收集所有已注册的文件名
    registered = set()
    for cat in CATEGORIES:
        for api in cat.get("apis", []):
            registered.add(api + ".md")
        for gf in cat.get("guide_files", []):
            registered.add(gf)
        for sub in cat.get("subcategories", []):
            for api in sub.get("apis", []):
                registered.add(api + ".md")
            for gf in sub.get("guide_files", []):
                registered.add(gf)

    # 扫描目录中的所有 .md 文件
    if not os.path.isdir(target_dir):
        print(f"\n  WARNING: 目录不存在: {target_dir}")
        return []

    print(f"\n扫描目录: {target_dir}")
    src_files = {f for f in os.listdir(target_dir)
                 if f.endswith(".md") and os.path.isfile(os.path.join(target_dir, f))}

    # 排除非 API 文件（索引文件、分类输出文件等）
    exclude = {"api_ref.md", "README.md"}
    # 排除所有分类输出文件名（旧目录中可能残留这些分类索引文件）
    for cat in CATEGORIES:
        # 带编号的输出文件名，如 "11_内存管理.md"
        exclude.add(cat["output"])
        # 不带编号的分类名，如 "内存管理.md"
        title = cat["title"]
        exclude.add(title + ".md")
        # 替换特殊字符的变体，如 "共享Buffer管理（预留-暂不支持）.md"
        exclude.add(title.replace("，", "-").replace("、", "-") + ".md")
        for sub in cat.get("subcategories", []):
            if sub.get("output"):
                exclude.add(sub["output"])
            sub_title = sub["title"]
            # 去掉编号前缀，如 "11-01 设备内存分配与释放" -> "设备内存分配与释放"
            bare_title = re.sub(r'^[\d.\-]+ *', '', sub_title)
            exclude.add(bare_title + ".md")
            exclude.add(sub_title + ".md")
    src_files -= exclude

    unregistered = sorted(src_files - registered)

    # 分类：API 文件 vs 非 API 文件（分类索引/说明文档等）
    new_apis = [f for f in unregistered if re.match(r'^[a-zA-Z]', f)]
    other_files = [f for f in unregistered if not re.match(r'^[a-zA-Z]', f)]

    if new_apis:
        print(f"\n{'='*50}")
        print(f"[WARNING] 检测到 {len(new_apis)} 个未注册的 API 源文件：")
        for f in new_apis:
            print(f"  - {f}")
        print(f"\n请将这些文件添加到 CATEGORIES 对应分类的 apis 列表中，然后重新运行脚本。")
        print(f"如果是数据类型，请添加到第 23 类的 apis 列表中。")
    elif not other_files:
        print(f"\n[OK] 所有源文件均已在 CATEGORIES 中注册（共 {len(registered)} 个）")

    if other_files:
        print(f"\n[INFO] 另有 {len(other_files)} 个非 API 文件未纳入合并（可能是旧分类索引）：")
        for f in other_files:
            print(f"  - {f}")

    return new_apis


def main():
    global _API_FILE_MAP, _DATA_TYPE_NAMES
    os.makedirs(DST_DIR, exist_ok=True)
    copy_figures()
    _API_FILE_MAP = build_api_file_map()
    _DATA_TYPE_NAMES = get_data_type_names()
    print(f"已构建 API 链接映射：{len(_API_FILE_MAP)} 个条目")
    print(f"已加载数据类型名称：{len(_DATA_TYPE_NAMES)} 个")

    total_apis = 0
    file_count = 0

    for cat in CATEGORIES:
        print(f"\n[{cat['num']}] {cat['title']}")
        text = build_category(cat)
        write_merged(cat["output"], text)
        file_count += 1

        # 如果有二级分类，为每个子分类生成独立文件
        if cat.get("subcategories"):
            for sub in cat["subcategories"]:
                sub_output = sub.get("output")
                if sub_output:
                    sub_text = build_subcategory_file(sub)
                    write_merged(sub_output, sub_text)
                    file_count += 1
                total_apis += len(sub["apis"])

        total_apis += len(cat.get("apis", []))

    # 写总索引
    index_text = build_index()
    write_merged("api_ref.md", index_text)
    file_count += 1

    print(f"\n{'='*50}")
    print(f"合并完成！共处理 {total_apis} 个 API 接口，生成 {file_count} 个文件")
    print(f"输出目录: {DST_DIR}")

    # 检测未注册的源文件
    detect_unregistered_files()

if __name__ == "__main__":
    main()
