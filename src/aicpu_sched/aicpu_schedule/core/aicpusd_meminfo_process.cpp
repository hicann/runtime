/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <fstream>
#include <climits>
#include <cstdlib>
#include <cerrno>
#include <securec.h>
#include "ascend_hal_define.h"
#include "aicpusd_util.h"
#include "aicpusd_drv_manager.h"
#include "aicpu_context.h"
#include "aicpusd_meminfo_process.h"

namespace AicpuSchedule {
namespace {
// Field names expected in each memzone cfg entry of the json file.
const char_t* const CFG_FIELD_NAMES[] = {"cfg_id", "total_size", "blk_size", "max_buf_size", "page_type"};
const size_t CFG_FIELD_COUNT = sizeof(CFG_FIELD_NAMES) / sizeof(CFG_FIELD_NAMES[0]);

// Forward declarations of internal helpers (definitions below).
size_t SkipWhiteSpace(const std::string& s, size_t pos);
bool ReadJsonString(const std::string& s, size_t& pos, std::string& out);
size_t FindMatchingBrace(const std::string& s, size_t openPos);
size_t FindMatchingBracket(const std::string& s, size_t openPos);
bool SkipJsonValue(const std::string& s, size_t& pos);

// Skip whitespace starting at pos. Return new pos (end if none found).
size_t SkipWhiteSpace(const std::string& s, size_t pos)
{
    while (pos < s.size()) {
        const char_t c = s[pos];
        if ((c != ' ') && (c != '\t') && (c != '\n') && (c != '\r')) {
            break;
        }
        ++pos;
    }
    return pos;
}

// Read a quoted string starting at pos (s[pos] must be '"'). On success, return true and
// set out to the decoded string content; advance pos past the closing quote.
bool ReadJsonString(const std::string& s, size_t& pos, std::string& out)
{
    if ((pos >= s.size()) || (s[pos] != '"')) {
        return false;
    }
    ++pos;
    out.clear();
    while (pos < s.size()) {
        const char_t c = s[pos];
        if (c == '"') {
            ++pos;
            return true;
        }
        if (c == '\\') {
            ++pos;
            if (pos >= s.size()) {
                return false;
            }
            const char_t esc = s[pos];
            switch (esc) {
                case '"':
                    out.push_back('"');
                    break;
                case '\\':
                    out.push_back('\\');
                    break;
                case '/':
                    out.push_back('/');
                    break;
                case 'b':
                    out.push_back('\b');
                    break;
                case 'f':
                    out.push_back('\f');
                    break;
                case 'n':
                    out.push_back('\n');
                    break;
                case 'r':
                    out.push_back('\r');
                    break;
                case 't':
                    out.push_back('\t');
                    break;
                default:
                    // unknown escape, reject to keep parser strict-but-simple
                    return false;
            }
            ++pos;
        } else {
            out.push_back(c);
            ++pos;
        }
    }
    return false; // unterminated string
}

// Read an unsigned/signed integer literal starting at pos. On success, return true and
// store the value in outVal (unsigned long long). Caller validates range as needed.
bool ReadJsonInteger(const std::string& s, size_t& pos, unsigned long long& outVal)
{
    size_t p = SkipWhiteSpace(s, pos);
    if (p >= s.size()) {
        return false;
    }
    bool negative = false;
    if (s[p] == '-') {
        negative = true;
        ++p;
        if (p >= s.size()) {
            return false;
        }
    }
    if (s[p] == '+') { // tolerate leading '+'
        ++p;
        if (p >= s.size()) {
            return false;
        }
    }
    if ((s[p] < '0') || (s[p] > '9')) {
        return false;
    }
    errno = 0;
    char_t* endPtr = nullptr;
    const unsigned long long v = strtoull(s.c_str() + p, &endPtr, 10);
    if (errno != 0) {
        return false;
    }
    const size_t consumed = static_cast<size_t>(endPtr - (s.c_str() + p));
    if (consumed == 0U) {
        return false;
    }
    // strtoull silently accepts trailing garbage; we require the number to be followed
    // by whitespace, comma, } or end-of-buffer — anything else is a syntax error.
    const size_t after = p + consumed;
    if (after < s.size()) {
        const char_t t = s[after];
        if ((t != ' ') && (t != '\t') && (t != '\n') && (t != '\r') && (t != ',') && (t != '}')) {
            return false;
        }
    }
    pos = after;
    outVal = negative ? 0ULL : v; // negative values are not meaningful for cfg; clamp to 0
    return true;
}

// Parse a single memzone entry object substring [objStart, objEnd) and fill cfg.
// objStart points at the opening '{', objEnd at the matching '}'.
bool ParseOneEntry(const std::string& s, size_t objStart, size_t objEnd, memZoneCfg& cfg)
{
    cfg = {};
    bool found[CFG_FIELD_COUNT] = {false, false, false, false, false};
    size_t pos = objStart + 1U;
    while (pos < objEnd) {
        pos = SkipWhiteSpace(s, pos);
        if (pos >= objEnd) {
            break;
        }
        if (s[pos] == '}') {
            break;
        }
        std::string key;
        if (!ReadJsonString(s, pos, key)) {
            return false;
        }
        pos = SkipWhiteSpace(s, pos);
        if ((pos >= objEnd) || (s[pos] != ':')) {
            return false;
        }
        ++pos;
        pos = SkipWhiteSpace(s, pos);
        // Match against known field names
        size_t fieldIdx = CFG_FIELD_COUNT;
        for (size_t i = 0U; i < CFG_FIELD_COUNT; ++i) {
            if (key == CFG_FIELD_NAMES[i]) {
                fieldIdx = i;
                break;
            }
        }
        if (fieldIdx >= CFG_FIELD_COUNT) {
            // Unknown field: silently skip its value to align with the original
            // nlohmann-based behaviour, which only fetched the 5 known fields and
            // ignored any others present in the entry object.
            if (!SkipJsonValue(s, pos)) {
                return false;
            }
        } else {
            unsigned long long v = 0ULL;
            if (!ReadJsonInteger(s, pos, v)) {
                return false;
            }
            switch (fieldIdx) {
                case 0U:
                    cfg.cfg_id = static_cast<unsigned int>(v);
                    break;
                case 1U:
                    cfg.total_size = v;
                    break;
                case 2U:
                    cfg.blk_size = static_cast<unsigned int>(v);
                    break;
                case 3U:
                    cfg.max_buf_size = v;
                    break;
                case 4U:
                    cfg.page_type = static_cast<unsigned int>(v);
                    break;
                default:
                    return false;
            }
            found[fieldIdx] = true;
        }
        pos = SkipWhiteSpace(s, pos);
        if (pos < objEnd) {
            if (s[pos] == ',') {
                ++pos;
                // RFC 8259 disallows trailing comma: a key must follow the comma.
                pos = SkipWhiteSpace(s, pos);
                if ((pos >= objEnd) || (s[pos] != '"')) {
                    return false;
                }
            } else if (s[pos] == '}') {
                break;
            } else {
                return false;
            }
        }
    }
    for (size_t i = 0U; i < CFG_FIELD_COUNT; ++i) {
        if (!found[i]) {
            return false;
        }
    }
    return true;
}

// Find the matching closing '}' for an opening '{' at openPos, skipping nested strings.
// Returns the index of the matching '}' or std::string::npos if unbalanced.
size_t FindMatchingBrace(const std::string& s, size_t openPos)
{
    if ((openPos >= s.size()) || (s[openPos] != '{')) {
        return std::string::npos;
    }
    size_t pos = openPos + 1U;
    int depth = 1;
    while (pos < s.size()) {
        const char_t c = s[pos];
        if (c == '"') {
            std::string ignored;
            size_t p = pos;
            if (!ReadJsonString(s, p, ignored)) {
                return std::string::npos;
            }
            pos = p;
            continue;
        }
        if (c == '{') {
            ++depth;
        } else if (c == '}') {
            --depth;
            if (depth == 0) {
                return pos;
            }
        }
        ++pos;
    }
    return std::string::npos;
}

// Find the matching closing ']' for an opening '[' at openPos, skipping nested strings.
// Returns the index of the matching ']' or std::string::npos if unbalanced.
size_t FindMatchingBracket(const std::string& s, size_t openPos)
{
    if ((openPos >= s.size()) || (s[openPos] != '[')) {
        return std::string::npos;
    }
    size_t pos = openPos + 1U;
    int depth = 1;
    while (pos < s.size()) {
        const char_t c = s[pos];
        if (c == '"') {
            std::string ignored;
            size_t p = pos;
            if (!ReadJsonString(s, p, ignored)) {
                return std::string::npos;
            }
            pos = p;
            continue;
        }
        if (c == '[') {
            ++depth;
        } else if (c == ']') {
            --depth;
            if (depth == 0) {
                return pos;
            }
        }
        ++pos;
    }
    return std::string::npos;
}

// Skip an arbitrary JSON value starting at pos (after leading whitespace). Used to ignore
// unknown fields in a memzone entry. Returns true on success and advances pos past the
// value; returns false if the value is malformed.
bool SkipJsonValue(const std::string& s, size_t& pos)
{
    pos = SkipWhiteSpace(s, pos);
    if (pos >= s.size()) {
        return false;
    }
    const char_t c = s[pos];
    if (c == '"') {
        std::string ignored;
        return ReadJsonString(s, pos, ignored);
    }
    if (c == '{') {
        const size_t end = FindMatchingBrace(s, pos);
        if (end == std::string::npos) {
            return false;
        }
        pos = end + 1U;
        return true;
    }
    if (c == '[') {
        const size_t end = FindMatchingBracket(s, pos);
        if (end == std::string::npos) {
            return false;
        }
        pos = end + 1U;
        return true;
    }
    // primitive: number, true, false, null — scan until value terminator.
    while (pos < s.size()) {
        const char_t t = s[pos];
        if ((t == ',') || (t == '}') || (t == ']') || (t == ' ') || (t == '\t') || (t == '\n') || (t == '\r')) {
            break;
        }
        ++pos;
    }
    return true;
}
} // namespace

StatusCode AicpuMemInfoProcess::GetMemZoneInfo(BuffCfg& buffCfg)
{
    aicpusd_info("Start get memzone info!");
    buffCfg = {}; // default
    auto ret = CheckRunMode();
    if (ret != AICPU_SCHEDULE_OK) {
        return ret;
    }

    std::string blockModePath = "";
    const bool envRet = AicpuUtil::GetEnvVal(ENV_NAME_BLOCK_CFG_PATH, blockModePath);
    if (!envRet) {
        aicpusd_run_info("The pointer of BLOCK_CFG_PATH is nullptr");
        return AICPU_SCHEDULE_OK;
    }

    if ((blockModePath.size() > 0U) && (blockModePath[blockModePath.size() - 1U] != '/')) {
        (void)blockModePath.append("/");
    }

    const std::string procName = AicpuDrvManager::GetInstance().GetHostProcName();
    const std::string memBuffCfgFile = blockModePath + "aifmk/" + procName + ".json";
    ret = CheckPathValid(memBuffCfgFile);
    if (ret != AICPU_SCHEDULE_OK) {
        aicpusd_run_info("The memBufCfgFile path is invalid: [%s]!", memBuffCfgFile.c_str());
        return AICPU_SCHEDULE_ERROR_GET_PATH_FAILED;
    }

    ret = LoadMemCfgFromFile(memBuffCfgFile, buffCfg);
    if (ret != AICPU_SCHEDULE_OK) {
        aicpusd_run_info("Execute LoadMemCfgFromFile returned [%d].", ret);
        return AICPU_SCHEDULE_ERROR_READ_JSON_FAILED;
    }
    return AICPU_SCHEDULE_OK;
}

StatusCode AicpuMemInfoProcess::LoadMemCfgFromFile(const std::string& filePath, BuffCfg& output)
{
    aicpusd_info("Read [%s] file", filePath.c_str());
    std::ifstream ifs(filePath);
    if (!ifs.is_open()) {
        aicpusd_run_info("Cant not open [%s], please check!", filePath.c_str());
        return AICPU_SCHEDULE_ERROR_READ_JSON_FAILED;
    }
    std::string content((std::istreambuf_iterator<char_t>(ifs)), std::istreambuf_iterator<char_t>());
    ifs.close();

    aicpusd_info("Read [%s] file successfully, size is [%zu].", filePath.c_str(), content.size());

    // Locate the outermost '{'
    size_t pos = SkipWhiteSpace(content, 0U);
    if ((pos >= content.size()) || (content[pos] != '{')) {
        aicpusd_run_info("Invalid json: top-level object expected in [%s].", filePath.c_str());
        return AICPU_SCHEDULE_ERROR_READ_JSON_FAILED;
    }
    size_t topEnd = FindMatchingBrace(content, pos);
    if (topEnd == std::string::npos) {
        aicpusd_run_info("Unbalanced braces in json [%s].", filePath.c_str());
        return AICPU_SCHEDULE_ERROR_READ_JSON_FAILED;
    }

    size_t entryCount = 0U;
    pos = pos + 1U; // step past outer '{'
    while (pos < topEnd) {
        pos = SkipWhiteSpace(content, pos);
        if (pos >= topEnd) {
            break;
        }
        if (content[pos] == '}') {
            break;
        }
        if (entryCount >= static_cast<size_t>(BUFF_MAX_CFG_NUM)) {
            aicpusd_run_info("Json entry count exceeds BUFF_MAX_CFG_NUM[%d], truncating.", BUFF_MAX_CFG_NUM);
            break;
        }
        // Read top-level key (must be a quoted string, expected numeric like "0","1",...)
        std::string key;
        if (!ReadJsonString(content, pos, key)) {
            aicpusd_run_info("Invalid top-level key at pos [%zu] in [%s].", pos, filePath.c_str());
            return AICPU_SCHEDULE_ERROR_READ_JSON_FAILED;
        }
        // Legacy semantics: top-level keys must be contiguous decimal integers starting at
        // "0" (the original parsing logic iterated i=0..N and required the key std::to_string(i)).
        const std::string expectedKey = std::to_string(entryCount);
        if (key != expectedKey) {
            aicpusd_run_info(
                "Top-level key [%s] does not match expected [%s] at index [%zu] in [%s].", key.c_str(),
                expectedKey.c_str(), entryCount, filePath.c_str());
            return AICPU_SCHEDULE_ERROR_READ_JSON_FAILED;
        }
        pos = SkipWhiteSpace(content, pos);
        if ((pos >= topEnd) || (content[pos] != ':')) {
            aicpusd_run_info("Expected ':' after key [%s] in [%s].", key.c_str(), filePath.c_str());
            return AICPU_SCHEDULE_ERROR_READ_JSON_FAILED;
        }
        ++pos;
        pos = SkipWhiteSpace(content, pos);
        if ((pos >= topEnd) || (content[pos] != '{')) {
            aicpusd_run_info("Expected object value for key [%s] in [%s].", key.c_str(), filePath.c_str());
            return AICPU_SCHEDULE_ERROR_READ_JSON_FAILED;
        }
        size_t entryEnd = FindMatchingBrace(content, pos);
        if (entryEnd == std::string::npos) {
            aicpusd_run_info("Unbalanced entry object for key [%s] in [%s].", key.c_str(), filePath.c_str());
            return AICPU_SCHEDULE_ERROR_READ_JSON_FAILED;
        }
        if (!ParseOneEntry(content, pos, entryEnd, output.cfg[entryCount])) {
            aicpusd_run_info("Failed to parse entry for key [%s] in [%s].", key.c_str(), filePath.c_str());
            return AICPU_SCHEDULE_ERROR_READ_JSON_FAILED;
        }
        ++entryCount;
        pos = entryEnd + 1U;
        pos = SkipWhiteSpace(content, pos);
        if (pos < topEnd) {
            if (content[pos] == ',') {
                ++pos;
                // RFC 8259 disallows trailing comma: a key must follow the comma.
                pos = SkipWhiteSpace(content, pos);
                if ((pos >= topEnd) || (content[pos] != '"')) {
                    aicpusd_run_info("Trailing comma or missing key after entry in [%s].", filePath.c_str());
                    return AICPU_SCHEDULE_ERROR_READ_JSON_FAILED;
                }
            } else if (content[pos] == '}') {
                break;
            } else {
                aicpusd_run_info("Unexpected char [%c] after entry in [%s].", content[pos], filePath.c_str());
                return AICPU_SCHEDULE_ERROR_READ_JSON_FAILED;
            }
        }
    }
    aicpusd_info("Parsed [%zu] memzone cfg entries from [%s].", entryCount, filePath.c_str());
    return AICPU_SCHEDULE_OK;
}

StatusCode AicpuMemInfoProcess::CheckPathValid(const std::string& cfgFullPath)
{
    if (cfgFullPath.length() >= static_cast<size_t>(PATH_MAX)) {
        aicpusd_run_info("cfgFullPath file length[%zu] must less than PATH_MAX[%u]", cfgFullPath.length(), PATH_MAX);
        return AICPU_SCHEDULE_ERROR_GET_PATH_FAILED;
    }

    std::unique_ptr<char_t[]> path(new (std::nothrow) char_t[PATH_MAX]);
    if (path == nullptr) {
        aicpusd_run_info("Alloc memory for path failed.");
        return AICPU_SCHEDULE_ERROR_GET_PATH_FAILED;
    }

    const auto eRet = memset_s(path.get(), PATH_MAX, 0, PATH_MAX);
    if (eRet != EOK) {
        aicpusd_run_info("Mem set was not successful, ret=%d", eRet);
        return AICPU_SCHEDULE_ERROR_GET_PATH_FAILED;
    }

    if (realpath(cfgFullPath.data(), path.get()) == nullptr) {
        aicpusd_run_info("Check cfg file full path:[%s], path:[%s]", cfgFullPath.c_str(), path.get());
        return AICPU_SCHEDULE_ERROR_GET_PATH_FAILED;
    }
    const std::string normalPath(path.get());
    if (normalPath != cfgFullPath) {
        aicpusd_run_info("Invalid mem cfg file:[%s], should be [%s]", cfgFullPath.c_str(), normalPath.c_str());
        return AICPU_SCHEDULE_ERROR_GET_PATH_FAILED;
    }
    aicpusd_info("Check mem cfg file [%s] success.", cfgFullPath.c_str());
    return AICPU_SCHEDULE_OK;
}

StatusCode AicpuMemInfoProcess::CheckRunMode()
{
    uint32_t runMode;
    const aicpu::status_t status = aicpu::GetAicpuRunMode(runMode);
    if (status != aicpu::AICPU_ERROR_NONE) {
        aicpusd_err("GetAicpuRunMode returned [%u]", status);
        return AICPU_SCHEDULE_ERROR_GET_RUN_MODE_FAILED;
    }
    if (runMode != static_cast<uint32_t>(aicpu::AicpuRunMode::PROCESS_SOCKET_MODE)) {
        aicpusd_run_info("Current aicpu mode is not MDC, please check!");
        return AICPU_SCHEDULE_OK;
    }
    return AICPU_SCHEDULE_OK;
}
} // namespace AicpuSchedule
