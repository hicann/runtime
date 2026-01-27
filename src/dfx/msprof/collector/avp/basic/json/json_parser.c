/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "json_parser.h"
#include <limits.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <securec.h>
#include "logger/logger.h"
#include "utils/utils.h"
#include "osal/osal_mem.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef struct {
    const char *jsonContent;
    size_t contentLen;
    size_t parserIndex;
} JsonParser;

typedef struct {
    const char *data;
    size_t len;
    size_t escapeCharNum;
} JsonString;

JsonObj *JsonArrayAt(JsonObj *obj, size_t i)
{
    return (JsonObj *)((obj->type != CJSON_ARRAY) ? NULL : CVectorAt(&obj->value.arrayValue, i));
}

static void InitJsonParser(JsonParser *parser, const char *jsonContent, size_t jsonLen)
{
    parser->contentLen = jsonLen;
    parser->jsonContent = jsonContent;
    parser->parserIndex = 0;
}

static inline bool CheckValidSpace(JsonParser *parser, size_t space)
{
    return (space <= (parser->contentLen - parser->parserIndex));
}

static inline const char *ParseContent(JsonParser *parser)
{
    return &parser->jsonContent[parser->parserIndex];
}

static inline bool CheckJsonKey(JsonParser *parser, const char *key, size_t keyLen)
{
    return CheckValidSpace(parser, keyLen) ? (strncmp(ParseContent(parser), key, keyLen) == 0) : false;
}

static inline bool CheckJsonKeyChar(JsonParser *parser, char key)
{
    return (CheckValidSpace(parser, 1) && (ParseContent(parser)[0] == key));
}

static inline void SkipUtf8Bom(JsonParser *parser)
{
    const char *bom = "\xEF\xBB\xBF";
    const size_t bomlen = 3;
    if (CheckJsonKey(parser, bom, bomlen)) {
        parser->parserIndex += bomlen;
    }
}

static inline void SkipWhiteSpace(JsonParser *parser)
{
#define MIN_VISIBLE_CHAR 33
    size_t index = parser->parserIndex;
    while ((index < parser->contentLen) && (parser->jsonContent[index] < MIN_VISIBLE_CHAR)) {
        index++;
    }
    parser->parserIndex = index;
}

static inline bool ParseNullKey(JsonParser *parser, JsonObj *value)
{
#define KEY_NULL_LEN 4UL
    if (CheckJsonKey(parser, "null", KEY_NULL_LEN)) {
        parser->parserIndex += KEY_NULL_LEN;
        if (value != NULL) {
            value->type = CJSON_NULL;
        }
        return true;
    }
    return false;
}

static inline bool ParseTrueKey(JsonParser *parser, JsonObj *value)
{
#define KEY_TRUE_LEN 4UL
    if (CheckJsonKey(parser, "true", KEY_TRUE_LEN)) {
        parser->parserIndex += KEY_TRUE_LEN;
        if (value != NULL) {
            value->type = CJSON_BOOL;
            value->value.boolValue = true;
        }
        return true;
    }
    return false;
}

static inline bool ParseFalseKey(JsonParser *parser, JsonObj *value)
{
#define KEY_FALSE_LEN 5UL
    if (CheckJsonKey(parser, "false", KEY_FALSE_LEN)) {
        parser->parserIndex += KEY_FALSE_LEN;
        if (value != NULL) {
            value->type = CJSON_BOOL;
            value->value.boolValue = false;
        }
        return true;
    }
    return false;
}

#define MAX_NUMBER_LENGTH 64U
static bool ParseNumStrAndType(JsonParser *parser, char numStr[], CJSON_TYPE *typePtr)
{
    size_t end = parser->contentLen - parser->parserIndex;
    const char *data = &parser->jsonContent[parser->parserIndex];
    size_t i;
 
    end = (end > MAX_NUMBER_LENGTH) ? MAX_NUMBER_LENGTH : end;
    for (i = 0; i < end; i++, data++) {
        if (((*data >= '0') && (*data <= '9')) || (*data == '+') || (*data == '-')) {
            numStr[i] = *data;
            continue;
        }
        if ((*data == 'e') || (*data == 'E')) {
            return false;
        }
        if (*data == '.') {
            numStr[i] = '.';
            *typePtr = CJSON_DOUBLE;
            continue;
        }
        break;
    }
    numStr[i] = '\0';
    return true;
}

static bool ParseNumber(JsonParser *parser, JsonObj *value)
{
    char numStr[MAX_NUMBER_LENGTH + 1];
    CJSON_TYPE type = CJSON_INT;
    if (!ParseNumStrAndType(parser, numStr, &type)) {
        return false;
    }
    char *afterEnd = NULL;
    int64_t intValue = 0;
    uint64_t uintValue = 0;
    double doubleValue = 0.0;
    if (type == CJSON_INT) {
        if (numStr[0] != '-') {
            uintValue = TransferStringToInt(numStr, sizeof(numStr), &afterEnd, DECIMAL_NOTATION);
            type = CJSON_UINT;
            if (uintValue <= INT64_MAX) {
                intValue = (int64_t)uintValue;
                type = CJSON_INT;
            }
        } else {
            intValue = (int64_t)TransferStringToInt(numStr, sizeof(numStr), &afterEnd, DECIMAL_NOTATION);
        }
    } else {
        doubleValue = TransferStringToDouble(numStr, sizeof(numStr), &afterEnd);
    }
    if (numStr == afterEnd) {
        return false;
    }
    if (value != NULL) {
        value->type = type;
        if (type == CJSON_INT) {
            value->value.intValue = intValue;
        } else if (type == CJSON_UINT) {
            value->value.uintValue = uintValue;
        } else {
            value->value.doubleValue = doubleValue;
        }
    }
    parser->parserIndex += afterEnd - numStr;
    return true;
}

static char *NewCStringByJsonString(JsonString *jsonString)
{
    size_t validLen = jsonString->len - jsonString->escapeCharNum;
    char *string = (char *)OsalMalloc(validLen + 1);
    if (string == NULL) {
        MSPROF_LOGE("string malloc failed.");
        return NULL;
    }
    if (jsonString->escapeCharNum == 0) {
        if (validLen != 0) {
            errno_t ret = memcpy_s(string, validLen, jsonString->data, jsonString->len);
            if (ret != EOK) {
                OsalFree(string);
                return NULL;
            }
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
            case 'b': string[index] = '\b'; break;
            case 'f': string[index] = '\f'; break;
            case 'n': string[index] = '\n'; break;
            case 'r': string[index] = '\r'; break;
            case 't': string[index] = '\t'; break;
            case '\"':
            case '\\':
            case '/':
                string[index] = *srcString;
                break;
            // 暂不支持 utf16
            default:
                OsalFree(string);
                return NULL;
        }
    }
    string[index] = '\0';
    return string;
}

static bool ParseJsonString(JsonParser *parser, JsonString *string)
{
    if (!CheckJsonKeyChar(parser, '\"')) {
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

static bool ParseString(JsonParser *parser, JsonObj *value)
{
    JsonString jsonString;
    if (!ParseJsonString(parser, &jsonString)) {
        return false;
    }

    if (value == NULL) {
        return true;
    }
    value->value.stringValue = NewCStringByJsonString(&jsonString);
    if (value->value.stringValue == NULL) {
        return false;
    }
    value->type = CJSON_STRING;
    return true;
}

static int32_t JsonKeyCmp(void *a, void *b, void *appInfo)
{
    (void)appInfo;
    return strcmp(((JsonKeyObj *)a)->key, ((JsonKeyObj *)b)->key);
}

JsonKeyObj *KeyValuePairAt(const JsonObj *obj, size_t index);
JsonObj *SetValueByKey(JsonObj *obj, const char *key, JsonObj valueObj);
JsonValue *GetValueByKey(JsonObj *obj, char *key);
JsonObj *TravelByKey(JsonObj **obj, char *key);
bool Contains(JsonObj *obj, char *key);
JsonObj *AddArrayItem(JsonObj *obj, JsonObj value);
size_t GetSize(const JsonObj *obj);

static void JsonObjInit(JsonObj *obj)
{
    if (obj == NULL) {
        return;
    }
    obj->type = CJSON_NULL;
    obj->KeyValuePairAt = KeyValuePairAt;
    obj->SetValueByKey = SetValueByKey;
    obj->GetValueByKey = GetValueByKey;
    obj->TravelByKey = TravelByKey;
    obj->Contains = Contains;
    obj->AddArrayItem = AddArrayItem;
    obj->GetSize = GetSize;
}

static inline JsonObj *NewJsonObj(void)
{
    JsonObj *obj = (JsonObj *)OsalMalloc(sizeof(JsonObj));
    if (obj == NULL) {
        MSPROF_LOGE("JsonObj malloc failed.");
        return NULL;
    }
    JsonObjInit(obj);
    return obj;
}

static inline void DeInitJsonObj(JsonObj *obj)
{
    switch (obj->type) {
        case CJSON_STRING: OsalConstFree(obj->value.stringValue); break;
        case CJSON_OBJ: DeInitCSortVector(&obj->value.objectValue); break;
        case CJSON_ARRAY: DeInitCVector(&obj->value.arrayValue); break;
        default: break;
    }
    obj->type = CJSON_NULL;
}

void JsonObjUnInit(JsonObj *obj)
{
    DeInitJsonObj(obj);
}

void JsonFree(JsonObj *obj)
{
    if (obj == NULL) {
        return;
    }
    DeInitJsonObj(obj);
    OsalFree((void *)obj);
}

typedef bool (*PFN_ParseValue)(JsonParser *parser, JsonObj *value);
typedef struct {
    char key;
    PFN_ParseValue pfnParse;
} KeyCharParsePair;

static inline bool ParseKey(JsonParser *parser, const char **key)
{
    JsonString jsonString;
    if (!ParseJsonString(parser, &jsonString)) {
        return false;
    }

    if (key == NULL) {
        return true;
    }

    *key = NewCStringByJsonString(&jsonString);
    return (*key != NULL);
}

static bool ParseSimpleValue(JsonParser *parser, JsonObj *value)
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

extern bool ParseJsonObj(JsonParser *parser, JsonObj *value);
static size_t ParseKeyValuePair(JsonParser *parser, const char **key, JsonObj *obj)
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
        validJson = ParseJsonObj(parser, obj);
    }

    if (!validJson && (key != NULL) && (*key != NULL)) {
        OsalConstFree(*key);
    }
    return validJson ? valueIndex : 0;
}

static void DeInitJsonKeyObj(void *item)
{
    JsonKeyObj *obj = (JsonKeyObj *)item;
    if (obj->key != NULL) {
        OsalConstFree(obj->key);
        DeInitJsonObj(&obj->value);
    }
}

static bool ParseObj(JsonParser *parser, JsonObj *value)
{
    // skip {
    parser->parserIndex++;

    if (value != NULL) {
        value->type = CJSON_OBJ;
        InitCSortVector(&value->value.objectValue, sizeof(JsonKeyObj), JsonKeyCmp, NULL);
        SetCSortVectorDestroyItem(&value->value.objectValue, DeInitJsonKeyObj);
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
            JsonKeyObj obj;
            validJson = (ParseKeyValuePair(parser, &obj.key, &obj.value) != 0);
            if (!validJson) {
                break;
            }
            if (EmplaceCSortVector(&value->value.objectValue, &obj) == NULL) {
                DeInitJsonKeyObj(&obj);
                validJson = false;
                break;
            }
        } else {
            validJson = (ParseKeyValuePair(parser, NULL, NULL) != 0);
        }

        itemSize++;
        SkipWhiteSpace(parser);
    }

    if ((!validJson) || (!CheckJsonKeyChar(parser, '}'))) {
        if (value != NULL) {
            DeInitCSortVector(&value->value.objectValue);
        }
        return false;
    }

    parser->parserIndex++;
    return true;
}

static void DestroyJsonArrayItem(void *item)
{
    DeInitJsonObj((JsonObj *)item);
}

static bool ParseArray(JsonParser *parser, JsonObj *value)
{
    parser->parserIndex++;

    Vector *array = NULL;
    if (value != NULL) {
        value->type = CJSON_ARRAY;
        array = &value->value.arrayValue;
        InitCVector(array, sizeof(JsonObj));
        SetCVectorDestroyItem(array, DestroyJsonArrayItem);
    }

    size_t itemSize = 0;
    bool validJson = true;
    SkipWhiteSpace(parser);
    while (validJson && CheckValidSpace(parser, 1) && (ParseContent(parser)[0] != ']')) {
        if (itemSize > 0) {
            if (!CheckJsonKeyChar(parser, ',')) {
                validJson = false;
                break;
            }
            parser->parserIndex++;
            SkipWhiteSpace(parser);
        }
        if (array != NULL) {
            JsonObj obj;
            validJson = ParseJsonObj(parser, &obj);
            if (!validJson) {
                break;
            }
            if (EmplaceBackCVector(array, &obj) == NULL) {
                validJson = false;
                DeInitJsonObj(&obj);
                break;
            }
        } else {
            validJson = ParseJsonObj(parser, NULL);
        }

        itemSize++;
        SkipWhiteSpace(parser);
    }

    if ((!validJson) || (!CheckJsonKeyChar(parser, ']'))) {
        if (array != NULL) {
            DeInitCVector(array);
        }
        return false;
    }

    parser->parserIndex++;
    return true;
}

static bool ParseStructValue(JsonParser *parser, JsonObj *value)
{
    static KeyCharParsePair keyCharParsePair[] = {{'\"', ParseString}, {'{', ParseObj}, {'[', ParseArray}};
    static const size_t count = sizeof(keyCharParsePair) / sizeof(keyCharParsePair[0]);
    for (size_t i = 0; i < count; i++) {
        if (CheckJsonKeyChar(parser, keyCharParsePair[i].key)) {
            return keyCharParsePair[i].pfnParse(parser, value);
        }
    }
    return false;
}

bool ParseJsonObj(JsonParser *parser, JsonObj *value)
{
    SkipWhiteSpace(parser);
    if (ParseSimpleValue(parser, value)) {
        return true;
    }

    return ParseStructValue(parser, value);
}

static JsonObj *JsonParseByParser(JsonParser *parser)
{
    JsonObj *obj = NewJsonObj();
    if (obj == NULL) {
        return NULL;
    }

    SkipUtf8Bom(parser);
    bool parseSuccess = ParseJsonObj(parser, obj);
    SkipWhiteSpace(parser);
    if (!parseSuccess || (parser->parserIndex != parser->contentLen)) {
        JsonFree(obj);
        return NULL;
    }
    return obj;
}

JsonObj *JsonParse(const CHAR *jsonContent)
{
    if (jsonContent == NULL) {
        return NULL;
    }
    JsonParser parser;
    size_t jsonLen = strlen(jsonContent);
    InitJsonParser(&parser, jsonContent, jsonLen);
    return JsonParseByParser(&parser);
}

JsonObj *GetJsonSubObj(JsonObj *obj, const char *key)
{
    if (obj->type != CJSON_OBJ) {
        return NULL;
    }

    JsonKeyObj cmpKey = {key, {}};
    JsonKeyObj *keyObj = (JsonKeyObj *)CSortVectorAtKey(&obj->value.objectValue, &cmpKey);
    if (keyObj == NULL) {
        return NULL;
    }
    return &keyObj->value;
}

static char *ToHeapStr(const char *stackStr)
{
    if (stackStr == NULL) {
        return NULL;
    }
    char *heapStr = (char *)OsalMalloc((strlen(stackStr) + 1) * sizeof(char));
    if (heapStr != NULL) {
        int32_t ret = memcpy_s(heapStr, (strlen(stackStr) + 1), stackStr, strlen(stackStr) + 1);
        if (ret != 0) {
            OsalFree(heapStr);
            MSPROF_LOGE("memcpy_s failed, ret = %d\n", ret);
            return NULL;
        }
        return heapStr;
    }
    return NULL;
}

static void JsonCopyArray(JsonObj *dstObj, const JsonObj *srcObj)
{
    dstObj->type = CJSON_ARRAY;
    InitCVector(&dstObj->value.arrayValue, sizeof(JsonObj));
    SetCVectorDestroyItem(&dstObj->value.arrayValue, DestroyJsonArrayItem);
    for (size_t i = 0; i < srcObj->GetSize(srcObj); i++) {
        JsonObj *arrItem = (JsonObj*)ConstCVectorAt(&srcObj->value.arrayValue, i);
        JsonObj cpArrItem;
        JsonObjInit(&cpArrItem);
        JsonCopy(&cpArrItem, arrItem);
        if (EmplaceBackCVector(&dstObj->value.arrayValue, &cpArrItem) == NULL) {
            MSPROF_LOGE("JsonCopy CJSON_ARRAY EmplaceCSortVector failed.");
            JsonObjUnInit(&cpArrItem);
            return;
        }
    }
}

static void JsonCopyObj(JsonObj *dstObj, const JsonObj *srcObj)
{
    dstObj->type = CJSON_OBJ;
    InitCSortVector(&dstObj->value.objectValue, sizeof(JsonKeyObj), JsonKeyCmp, NULL);
    SetCSortVectorDestroyItem(&dstObj->value.objectValue, DeInitJsonKeyObj);
    for (size_t i = 0; i < srcObj->GetSize(srcObj); i++) {
        JsonKeyObj *kvObj = srcObj->KeyValuePairAt(srcObj, i);
        char *keyStr = ToHeapStr(kvObj->key);
        if (keyStr == NULL) {
            MSPROF_LOGE("JsonCopy CJSON_OBJ key: %s key malloc failed.", kvObj->key);
            return;
        }
        JsonObj valueObj;
        JsonObjInit(&valueObj);
        JsonCopy(&valueObj, &kvObj->value);
        JsonKeyObj cJsonKeyObj = {.key = keyStr, .value = valueObj};
        if (EmplaceCSortVector(&dstObj->value.objectValue, &cJsonKeyObj) == NULL) {
            MSPROF_LOGE("JsonCopy CJSON_OBJ key: %s EmplaceCSortVector failed.", kvObj->key);
            JsonObjUnInit(&valueObj);
            if (keyStr != NULL) {
                OsalFree(keyStr);
            }
            return;
        }
    }
}

void JsonCopy(JsonObj *dstObj, const JsonObj *srcObj)
{
    if (srcObj == NULL || dstObj == NULL) {
        return;
    }
    switch (srcObj->type) {
        case CJSON_STRING:
            dstObj->type = CJSON_STRING;
            char *valueStr = ToHeapStr(srcObj->value.stringValue);
            if (valueStr == NULL) {
                MSPROF_LOGE("JsonCopy CJSON_STRING %s malloc failed.", srcObj->value.stringValue);
            }
            dstObj->value.stringValue = valueStr;
            break;
        case CJSON_ARRAY:
            JsonCopyArray(dstObj, srcObj);
            break;
        case CJSON_OBJ:
            JsonCopyObj(dstObj, srcObj);
            break;
        default:
            {
                errno_t ret = memcpy_s(dstObj, sizeof(JsonObj), srcObj, sizeof(JsonObj));
                if (ret != EOK) {
                    MSPROF_LOGE("JsonCopy memcpy_s failed, ret = %d.", ret);
                    return;
                }
            }
            break;
    }
}

JsonObj *SetValueByKey(JsonObj *obj, const char *key, JsonObj valueObj)
{
    if (obj->type != CJSON_NULL && obj->type != CJSON_OBJ) {
        return obj;
    }
    if (obj->type == CJSON_NULL) {
        obj->type = CJSON_OBJ;
        InitCSortVector(&obj->value.objectValue, sizeof(JsonKeyObj), JsonKeyCmp, NULL);
        SetCSortVectorDestroyItem(&obj->value.objectValue, DeInitJsonKeyObj);
    }
    JsonKeyObj cmpKey = {key, {}};
    JsonKeyObj *kvObj = (JsonKeyObj *)CSortVectorAtKey(&obj->value.objectValue, &cmpKey);
    if (kvObj != NULL) {
        DeInitJsonObj(&kvObj->value);
        JsonObj cpValueObj;
        JsonObjInit(&cpValueObj);
        JsonCopy(&cpValueObj, &valueObj);
        kvObj->value = cpValueObj;
    } else {
        char *keyStr = ToHeapStr(key);
        if (keyStr == NULL) {
            MSPROF_LOGE("key: %s malloc failed.", key);
            return obj;
        }
        JsonObj cpValueObj;
        JsonObjInit(&cpValueObj);
        JsonCopy(&cpValueObj, &valueObj);
        JsonKeyObj cJsonKeyObj = {.key = keyStr, .value = cpValueObj};
        if (EmplaceCSortVector(&obj->value.objectValue, &cJsonKeyObj) == NULL) {
            MSPROF_LOGE("JsonObj SetValueByKey: %s EmplaceCSortVector failed.", keyStr);
            JsonObjUnInit(&cpValueObj);
            if (keyStr != NULL) {
                OsalFree(keyStr);
            }
        }
    }
    return obj;
}

JsonValue *GetValueByKey(JsonObj *obj, char *key)
{
    if (obj == NULL || obj->type != CJSON_OBJ) {
        return NULL;
    }
    JsonKeyObj cmpKey = {(char *)key, {}};
    JsonKeyObj *kvObj = (JsonKeyObj *)CSortVectorAtKey(&obj->value.objectValue, &cmpKey);
    if (kvObj == NULL) {
        return NULL;
    }
    return &kvObj->value.value;
}

JsonObj *TravelByKey(JsonObj **obj, char *key)
{
    if (*obj == NULL) {
        return *obj;
    }
    *obj = GetJsonSubObj(*obj, key);
    return *obj;
}

JsonObj *AddArrayItem(JsonObj *obj, JsonObj value)
{
    if (obj->type != CJSON_NULL && obj->type != CJSON_ARRAY) {
        return obj;
    }
    if (obj->type == CJSON_NULL) {
        obj->type = CJSON_ARRAY;
        InitCVector(&obj->value.arrayValue, sizeof(JsonObj));
        SetCVectorDestroyItem(&obj->value.arrayValue, DestroyJsonArrayItem);
    }
    JsonObj cpArrItem;
    JsonObjInit(&cpArrItem);
    JsonCopy(&cpArrItem, &value);
    if (EmplaceBackCVector(&obj->value.arrayValue, &cpArrItem) == NULL) {
        MSPROF_LOGE("JsonObj AddArrayItem EmplaceCSortVector failed.");
        JsonObjUnInit(&cpArrItem);
    }
    return obj;
}

size_t GetSize(const JsonObj *obj)
{
    size_t size = 0;
    if (obj == NULL || obj->type == CJSON_NULL) {
        return size;
    }
    switch (obj->type) {
        case CJSON_ARRAY:
            size = obj->value.arrayValue.size;
            break;
        case CJSON_OBJ:
            size = obj->value.objectValue.vector.size;
            break;
        default:
            size = 1;
            break;
    }
    return size;
}

JsonKeyObj *KeyValuePairAt(const JsonObj *obj, size_t index)
{
    if (obj == NULL || obj->type != CJSON_OBJ) {
        return NULL;
    }
    return (JsonKeyObj *)ConstCVectorAt(&obj->value.objectValue.vector, index);
}

bool Contains(JsonObj *obj, char *key)
{
    if (obj == NULL || obj->type != CJSON_OBJ) {
        return false;
    }
    JsonKeyObj cmpKey = {(char *)key, {}};
    JsonKeyObj *kvObj = (JsonKeyObj *)CSortVectorAtKey(&obj->value.objectValue, &cmpKey);
    return kvObj != NULL;
}

JsonObj *JsonInit(void)
{
    return NewJsonObj();
}

#ifdef __cplusplus
}
#endif