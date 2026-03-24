/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <limits.h>
#include <stdlib.h>
#include <math.h>
#include <ctype.h>
#include "securec.h"
#include "mmpa_api.h"
#include "json_parser.h"
#ifdef __cplusplus
extern "C" {
#endif

#define JSON_CONTANT_LEN_MAX 0x7FFFFFFFU
typedef struct {
    const char *jsonContent;
    size_t contentLen;
    size_t parserIndex;
    bool fileJson;
} CJsonParser;

typedef struct {
    char *key;
    CJsonObj value;
} CJsonKeyObj;

typedef struct {
    const char *data;
    size_t len;
    size_t escapeCharNum;
} CJsonString;

static char g_decimalPoint = '.';

CJsonObj *CJsonArrayAt(CJsonObj *obj, size_t i)
{
    return (CJsonObj *)((obj->type != CJSON_ARRAY) ? NULL : VectorAt(&obj->value.array, i));
}

static inline char GetDecimalPoint(void)
{
    return g_decimalPoint;
}

static inline void InitCJsonParseZero(CJsonParser *parser)
{
    parser->contentLen = 0;
    parser->jsonContent = NULL;
    parser->parserIndex = 0;
    parser->fileJson = false;
}

static void InitCJsonParser(CJsonParser *parser, const char *jsonContent, size_t jsonLen)
{
    parser->contentLen = jsonLen;
    parser->jsonContent = jsonContent;
    parser->parserIndex = 0;
    parser->fileJson = false;
}

static void InitCJsonFileParser(CJsonParser *parser, const char *filePath)
{
    char resolvedPath[PATH_MAX];
    int32_t ret = mmRealPath(filePath, resolvedPath, PATH_MAX);
    InitCJsonParseZero(parser);
    if (ret != EN_OK) {
        return;
    }
    mmFileHandle *fd = mmOpenFile(resolvedPath, FILE_READ);
    if (fd == NULL) {
        return;
    }
    (void)mmSeekFile(fd, 0, MM_SEEK_FILE_END);
    long contentLen = mmTellFile(fd);
    if ((contentLen > 0) && ((uint32_t)contentLen <= JSON_CONTANT_LEN_MAX)) {
        if (mmSeekFile(fd, 0, MM_SEEK_FILE_BEGIN) == EN_OK) {
            char *jsonContent = (char *)mmMalloc((unsigned long long)contentLen);
            if (jsonContent == NULL) {
                mmCloseFile(fd);
                return;
            }
            mmReadFile(jsonContent, sizeof(char), (int32_t)contentLen, fd);
            parser->jsonContent = jsonContent;
            parser->contentLen = (size_t)contentLen;
            parser->fileJson = (parser->jsonContent != NULL);
        }
    }

    mmCloseFile(fd);
    return;
}

static void DeInitCJsonParser(CJsonParser *parser)
{
    if (parser->fileJson) {
        (void)mmFree((void *)parser->jsonContent);
        parser->jsonContent = NULL;
        parser->contentLen = 0;
    }
    InitCJsonParseZero(parser);
}

static inline bool CheckValidSpace(CJsonParser *parser, size_t space)
{
    return (space <= (parser->contentLen - parser->parserIndex));
}

static inline const char *ParseContent(CJsonParser *parser)
{
    return &parser->jsonContent[parser->parserIndex];
}

static inline bool CheckCJsonKey(CJsonParser *parser, const char *key, size_t keyLen)
{
    return CheckValidSpace(parser, keyLen) ? (strncmp(ParseContent(parser), key, keyLen) == 0) : false;
}

static inline bool CheckCJsonKeyChar(CJsonParser *parser, char key)
{
    return (CheckValidSpace(parser, 1) && (ParseContent(parser)[0] == key));
}

static inline void SkipUtf8Bom(CJsonParser *parser)
{
    const char *bom = "\xEF\xBB\xBF";
    const size_t bomlen = 3;
    if (CheckCJsonKey(parser, bom, bomlen)) {
        parser->parserIndex += bomlen;
    }
}

static inline void SkipWhiteSpace(CJsonParser *parser)
{
#define MIN_VISIBLE_CHAR 33
    size_t index = parser->parserIndex;
    while ((index < parser->contentLen) && (parser->jsonContent[index] < MIN_VISIBLE_CHAR)) {
        index++;
    }
    parser->parserIndex = index;
}

static inline bool ParseNullKey(CJsonParser *parser, CJsonObj *value)
{
#define KEY_NULL_LEN 4UL
    if (CheckCJsonKey(parser, "null", KEY_NULL_LEN)) {
        parser->parserIndex += KEY_NULL_LEN;
        if (value != NULL) {
            value->type = CJSON_NULL;
        }
        return true;
    }
    return false;
}

static inline bool ParseTrueKey(CJsonParser *parser, CJsonObj *value)
{
#define KEY_TRUE_LEN 4UL
    if (CheckCJsonKey(parser, "true", KEY_TRUE_LEN)) {
        parser->parserIndex += KEY_TRUE_LEN;
        if (value != NULL) {
            value->type = CJSON_BOOL;
            value->value.value = true;
        }
        return true;
    }
    return false;
}

static inline bool ParseFalseKey(CJsonParser *parser, CJsonObj *value)
{
#define KEY_FALSE_LEN 5UL
    if (CheckCJsonKey(parser, "false", KEY_FALSE_LEN)) {
        parser->parserIndex += KEY_FALSE_LEN;
        if (value != NULL) {
            value->type = CJSON_BOOL;
            value->value.value = false;
        }
        return true;
    }
    return false;
}

static double StrTod(char *str, char **endPtr)
{
#define TEN 10
    char *strIn = str;
    int32_t sign = 1;
    double result = 0.0;
    int32_t decimalPoint = 0;
    int32_t exponent = 0;
    int32_t expSign = 1;

    // 跳过空白字符
    while (isspace((int32_t)(*strIn))) {
        ++strIn;
    }

    // 处理正负号
    if (*strIn == '+') {
        ++strIn;
    } else if (*strIn == '-') {
        sign = -1;
        ++strIn;
    }

    // 转换整数部分
    while (isdigit((int32_t)(*strIn))) {
        result = result * TEN + (*strIn - '0');
        ++strIn;
    }

    // 处理小数点
    if (*strIn == '.') {
        ++strIn;
        while (isdigit((int32_t)(*strIn))) {
            ++decimalPoint;
            result = result * TEN + (*strIn - '0');
            ++strIn;
        }
        result /= pow(TEN, decimalPoint);
    }

    // 处理指数
    if (*strIn == 'e' || *strIn == 'E') {
        ++strIn;
        if (*strIn == '+') {
            ++strIn;
        } else if (*strIn == '-') {
            expSign = -1;
            ++strIn;
        }
        while (isdigit((int32_t)(*strIn))) {
            exponent = exponent * TEN + (*strIn - '0');
            ++strIn;
        }
        result *= pow(TEN, exponent * expSign);
    }

    // 设置endPtr
    if (endPtr != NULL) {
        *endPtr = strIn;
    }

    return sign * result;
}

static bool ParseNumber(CJsonParser *parser, CJsonObj *value)
{
#define MAX_NUMBER_LEN 64U
    char numStr[MAX_NUMBER_LEN + 1] = "\0";
    size_t end = parser->contentLen - parser->parserIndex;
    const char *data = &parser->jsonContent[parser->parserIndex];
    size_t i;
    CJSON_TYPE type = CJSON_INT;

    end = (end > MAX_NUMBER_LEN) ? MAX_NUMBER_LEN : end;
    for (i = 0; i < end; i++, data++) {
        if (((*data >= '0') && (*data <= '9')) || (*data == '+') || (*data == '-')) {
            numStr[i] = *data;
            continue;
        }

        if ((*data == 'e') || (*data == 'E')) {
            type = CJSON_DOUBLE;
            numStr[i] = *data;
            continue;
        }

        if (*data == '.') {
            numStr[i] = GetDecimalPoint();
            type = CJSON_DOUBLE;
            continue;
        }

        break;
    }
    if (i == 0) {
        return false;
    }

    numStr[i] = '\0';
    char *afterEnd = numStr;
    int64_t iNumber = 0;
    double fNumber = 0;
    if (type == CJSON_INT) {
        iNumber = strtoll(numStr, &afterEnd, 0);
    } else {
        fNumber = StrTod(numStr, &afterEnd);
    }
    if (numStr == afterEnd) {
        return false;
    }

    if (value != NULL) {
        value->type = type;
        if (type == CJSON_INT) {
            value->value.iNumber = iNumber;
        } else {
            value->value.fNumber = fNumber;
        }
    }

    parser->parserIndex += afterEnd - numStr;
    return true;
}

static char *NewCStringByJsonString(CJsonString *jsonString)
{
    size_t validLen = jsonString->len - jsonString->escapeCharNum;
    char *string = (char *)mmMalloc(validLen + 1);
    if (string == NULL) {
        return NULL;
    }

    if (jsonString->escapeCharNum == 0) {
        errno_t ret = memcpy_s(string, validLen, jsonString->data, jsonString->len);
        if (ret != EOK) {
            mmFree(string);
            return NULL;
        }
        string[validLen] = '\0';
        return string;
    }

    size_t index = 0;
    const char *endData = jsonString->data + jsonString->len;
    for (const char *srcString = jsonString->data; (srcString < endData) && (index < validLen); srcString++, index++) {
        if (*srcString != '\\') {
            string[index] = *(srcString);
            continue;
        }

        srcString++;
        switch (*srcString) {
            case 'b':
                string[index] = '\b';
                break;
            case 'f':
                string[index] = '\f';
                break;
            case 'n':
                string[index] = '\n';
                break;
            case 'r':
                string[index] = '\r';
                break;
            case 't':
                string[index] = '\t';
                break;
            case '\"':
            case '\\':
            case '/':
                string[index] = *srcString;
                break;
            // 暂不支持 utf16
            default:
                mmFree(string);
                return NULL;
        }
    }
    string[index] = '\0';
    return string;
}

static bool ParseCJsonString(CJsonParser *parser, CJsonString *string)
{
    if (!CheckCJsonKeyChar(parser, '\"')) {
        return false;
    }

    size_t index = parser->parserIndex + 1;
    const char *data = &parser->jsonContent[index];
    string->escapeCharNum = 0;
    while ((index < parser->contentLen) && (*data != '\"')) {
        if (*data == '\\') {
            (string->escapeCharNum)++;
            index++;
            data++;
            if (index >= parser->contentLen) {
                return false;
            }
        }
        index++;
        data++;
    }

    if ((index >= parser->contentLen) || (*data != '\"')) {
        return false;
    }

    parser->parserIndex++;
    string->data = &parser->jsonContent[parser->parserIndex];
    string->len = (size_t)(((uintptr_t)data) - ((uintptr_t)string->data));
    parser->parserIndex = index + 1;
    return true;
}

static bool ParseString(CJsonParser *parser, CJsonObj *value)
{
    CJsonString jsonString;
    if (!ParseCJsonString(parser, &jsonString)) {
        return false;
    }

    if (value == NULL) {
        return true;
    }
    value->value.string = NewCStringByJsonString(&jsonString);
    if (value->value.string == NULL) {
        return false;
    }
    value->type = CJSON_STRING;
    return true;
}

static int CJsonKeyCmp(void *a, void *b, void *appInfo)
{
    (void)appInfo;
    return strcmp(((CJsonKeyObj *)a)->key, ((CJsonKeyObj *)b)->key);
}

static inline CJsonObj *NewCJsonObj(void)
{
    CJsonObj *obj = (CJsonObj *)mmMalloc(sizeof(CJsonObj));
    if (obj != NULL) {
        obj->type = CJSON_NULL;
    }
    return obj;
}

static inline void DeInitCJsonObj(CJsonObj *obj)
{
    switch (obj->type) {
        case CJSON_STRING:
            mmFree(obj->value.string);
            break;
        case CJSON_OBJ:
            DeInitSortVector(&obj->value.objs);
            break;
        case CJSON_ARRAY:
            DeInitVector(&obj->value.array);
            break;
        default:
            break;
    }
}

void FreeCJsonObj(CJsonObj *obj)
{
    if (obj == NULL) {
        return;
    }
    DeInitCJsonObj(obj);
    mmFree((void *)obj);
}

typedef bool (*PFN_ParseValue)(CJsonParser *parser, CJsonObj *value);
typedef struct {
    char key;
    PFN_ParseValue pfnParse;
} KeyCharParsePair;

static inline bool ParseKey(CJsonParser *parser, char **key)
{
    CJsonString jsonString;
    if (!ParseCJsonString(parser, &jsonString)) {
        return false;
    }

    if (key == NULL) {
        return true;
    }

    *key = NewCStringByJsonString(&jsonString);
    return (*key != NULL);
}

static bool ParseSimpleValue(CJsonParser *parser, CJsonObj *value)
{
    static PFN_ParseValue keyValueParse[] = {ParseNullKey, ParseTrueKey, ParseFalseKey, ParseNumber};
    static size_t count = sizeof(keyValueParse) / sizeof(keyValueParse[0]);
    for (size_t i = 0; i < count; i++) {
        if (keyValueParse[i](parser, value)) {
            return true;
        }
    }
    return false;
}

extern bool ParseCJsonObj(CJsonParser *parser, CJsonObj *value);
static inline size_t ParseKeyValuePair(CJsonParser *parser, char **key, CJsonObj *obj)
{
    // parse key
    if (!ParseKey(parser, key)) {
        return 0;
    }

    // parse :
    SkipWhiteSpace(parser);
    bool validJson = CheckValidSpace(parser, 1) && (ParseContent(parser)[0] == ':');
    size_t valueIndex = 0;
    if (validJson) {
        parser->parserIndex++;

        // parse value
        SkipWhiteSpace(parser);
        valueIndex = parser->parserIndex;
        validJson = ParseCJsonObj(parser, obj);
    }

    if (!validJson && (key != NULL) && (*key != NULL)) {
        mmFree(*key);
    }
    return validJson ? valueIndex : 0;
}

static void DeInitCJsonKeyObj(void *item)
{
    CJsonKeyObj *obj = (CJsonKeyObj *)item;
    if (obj->key != NULL) {
        mmFree(obj->key);
        DeInitCJsonObj(&obj->value);
    }
}

static bool ParseObj(CJsonParser *parser, CJsonObj *value)
{
    // skip {
    parser->parserIndex++;

    if (value != NULL) {
        value->type = CJSON_OBJ;
        InitSortVector(&value->value.objs, sizeof(CJsonKeyObj), CJsonKeyCmp, NULL);
        SetSortVectorDestroyItem(&value->value.objs, DeInitCJsonKeyObj);
    }

    size_t itemSize = 0;
    bool validJson = true;
    SkipWhiteSpace(parser);
    while (validJson && CheckValidSpace(parser, 1) && (ParseContent(parser)[0] != '}')) {
        if (itemSize > 0) {
            // parse ,
            if (CheckValidSpace(parser, 1) && (ParseContent(parser)[0] != ',')) {
                validJson = false;
                break;
            }
            parser->parserIndex++;
            SkipWhiteSpace(parser);
        }

        if (value != NULL) {
            CJsonKeyObj obj;
            validJson = (ParseKeyValuePair(parser, &obj.key, &obj.value) != 0);
            if (!validJson) {
                break;
            }
            if (EmplaceSortVector(&value->value.objs, &obj) == NULL) {
                DeInitCJsonKeyObj(&obj);
                validJson = false;
                break;
            }
        } else {
            validJson = (ParseKeyValuePair(parser, NULL, NULL) != 0);
        }

        itemSize++;
        SkipWhiteSpace(parser);
    }

    if ((!validJson) || (!CheckCJsonKeyChar(parser, '}'))) {
        if (value != NULL) {
            DeInitSortVector(&value->value.objs);
        }
        return false;
    }

    parser->parserIndex++;
    return true;
}

static void DestroyCJsonArrayItem(void *item)
{
    DeInitCJsonObj((CJsonObj *)item);
}

static bool ParseArray(CJsonParser *parser, CJsonObj *value)
{
    parser->parserIndex++;

    Vector *array = NULL;
    if (value != NULL) {
        value->type = CJSON_ARRAY;
        array = &value->value.array;
        InitVector(array, sizeof(CJsonObj));
        SetVectorDestroyItem(array, DestroyCJsonArrayItem);
    }

    size_t itemSize = 0;
    bool validJson = true;
    SkipWhiteSpace(parser);
    while (validJson && CheckValidSpace(parser, 1) && (ParseContent(parser)[0] != ']')) {
        if (itemSize > 0) {
            if (!CheckCJsonKeyChar(parser, ',')) {
                validJson = false;
                break;
            }
            parser->parserIndex++;
            SkipWhiteSpace(parser);
        }
        if (array != NULL) {
            CJsonObj obj;
            validJson = ParseCJsonObj(parser, &obj);
            if (!validJson) {
                break;
            }
            if (EmplaceBackVector(array, &obj) == NULL) {
                validJson = false;
                DeInitCJsonObj(&obj);
                break;
            }
        } else {
            validJson = ParseCJsonObj(parser, NULL);
        }

        itemSize++;
        SkipWhiteSpace(parser);
    }

    if ((!validJson) || (!CheckCJsonKeyChar(parser, ']'))) {
        if (array != NULL) {
            DeInitVector(array);
        }
        return false;
    }

    parser->parserIndex++;
    return true;
}

static bool ParseStructValue(CJsonParser *parser, CJsonObj *value)
{
    static KeyCharParsePair keyCharParsePair[] = {{'\"', ParseString}, {'{', ParseObj}, {'[', ParseArray}};
    static const size_t count = sizeof(keyCharParsePair) / sizeof(keyCharParsePair[0]);
    for (size_t i = 0; i < count; i++) {
        if (CheckCJsonKeyChar(parser, keyCharParsePair[i].key)) {
            return keyCharParsePair[i].pfnParse(parser, value);
        }
    }
    return false;
}

bool ParseCJsonObj(CJsonParser *parser, CJsonObj *value)
{
    SkipWhiteSpace(parser);
    if (ParseSimpleValue(parser, value)) {
        return true;
    }

    return ParseStructValue(parser, value);
}

static CJsonObj *CJsonParseByParser(CJsonParser *parser)
{
    CJsonObj *obj = NewCJsonObj();
    if (obj == NULL) {
        return NULL;
    }

    SkipUtf8Bom(parser);
    if (!ParseCJsonObj(parser, obj) || (parser->parserIndex != parser->contentLen)) {
        FreeCJsonObj(obj);
        return NULL;
    }
    return obj;
}

CJsonObj *CJsonParse(const char *jsonContent, size_t jsonLen)
{
    CJsonParser parser;
    InitCJsonParser(&parser, jsonContent, jsonLen);
    return CJsonParseByParser(&parser);
}

CJsonObj *CJsonFileParse(const char *filePath)
{
    CJsonParser parser;
    InitCJsonFileParser(&parser, filePath);
    CJsonObj *jsonObj = CJsonParseByParser(&parser);
    DeInitCJsonParser(&parser);
    return jsonObj;
}

CJsonObj *GetCJsonSubObj(CJsonObj *obj, const char *key)
{
    if (obj->type != CJSON_OBJ) {
        return NULL;
    }
    CJsonKeyObj cmpKey = {(char*)key, {0}};
    CJsonKeyObj *keyObj = (CJsonKeyObj *)SortVectorAtKey(&obj->value.objs, &cmpKey);
    if (keyObj == NULL) {
        return NULL;
    }
    return &keyObj->value;
}

static size_t ParseObjSubKeyPosition(CJsonParser *parser, const char *key, size_t *offset)
{
    // skip {
    parser->parserIndex++;

    size_t objSize = 0;
    size_t len = 0;
    SkipWhiteSpace(parser);
    while (CheckValidSpace(parser, 1) && (ParseContent(parser)[0] != '}')) {
        if (objSize > 0) {
            // parse ,
            if (CheckValidSpace(parser, 1) && (ParseContent(parser)[0] != ',')) {
                return 0;
            }
            parser->parserIndex++;
            SkipWhiteSpace(parser);
        }

        char *curkey = NULL;
        size_t valueIndex = ParseKeyValuePair(parser, &curkey, NULL);
        if (valueIndex == 0) {
            return 0;
        }

        if (strcmp(curkey, key) == 0) {
            *offset = valueIndex;
            len = parser->parserIndex - valueIndex;
        }

        objSize++;
        SkipWhiteSpace(parser);
        mmFree(curkey);
    }

    if (!CheckCJsonKeyChar(parser, '}')) {
        return 0;
    }

    parser->parserIndex++;
    return len;
}

static size_t ParseCJsonKeyObjPosition(CJsonParser *parser, const char *key, size_t *offset)
{
    SkipUtf8Bom(parser);
    SkipWhiteSpace(parser);

    if (!CheckCJsonKeyChar(parser, '{')) {
        return 0;
    }
    return ParseObjSubKeyPosition(parser, key, offset);
}

char *CJsonFileParseKey(const char *filePath, const char *key)
{
    CJsonParser parser;
    InitCJsonFileParser(&parser, filePath);

    size_t offset;
    size_t len = ParseCJsonKeyObjPosition(&parser, key, &offset);
    char *value = NULL;
    if (len > 0) {
        value = (char *)mmMalloc(len + 1);
        if (value != NULL) {
            errno_t ret = memcpy_s(value, len, parser.jsonContent + offset, len);
            if (ret != EOK) {
                mmFree(value);
                value = NULL;
            } else {
                value[len] = '\0';
            }
        }
    }
    DeInitCJsonParser(&parser);
    return value;
}

size_t CJsonParseKeyPosition(const char *jsonContent, size_t jsonLen, const char *key, size_t *offset)
{
    CJsonParser parser;
    InitCJsonParser(&parser, jsonContent, jsonLen);
    return ParseCJsonKeyObjPosition(&parser, key, offset);
}

#ifdef __cplusplus
}
#endif