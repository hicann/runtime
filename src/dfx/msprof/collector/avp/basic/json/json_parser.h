/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef BASE_JSON_JSON_PARSER_H
#define BASE_JSON_JSON_PARSER_H
#include <stdio.h>
#include <stdint.h>
#include "vector.h"
#include "sort_vector.h"
#include "osal/osal.h"

#define DECIMAL_NOTATION 10ULL

#ifdef __cplusplus
extern "C" {
#endif

typedef enum {
    CJSON_NULL,
    CJSON_INT,
    CJSON_UINT,
    CJSON_DOUBLE,
    CJSON_BOOL,
    CJSON_STRING,
    CJSON_OBJ,
    CJSON_ARRAY,
} CJSON_TYPE;

typedef struct JsonObj JsonObj;
typedef struct JsonKeyObj JsonKeyObj;

typedef union JsonValue {
    const CHAR *stringValue;
    bool boolValue;
    double doubleValue;
    int64_t intValue;
    uint64_t uintValue;
    Vector arrayValue;
    SortVector objectValue;
} JsonValue;

struct JsonObj {
    JsonValue value;
    CJSON_TYPE type;

    // objectValue api
    JsonKeyObj *(*KeyValuePairAt)(const JsonObj *, size_t);
    JsonObj *(*SetValueByKey)(JsonObj *, const CHAR *, JsonObj);
    JsonValue *(*GetValueByKey)(JsonObj *, CHAR *);
    JsonObj *(*TravelByKey)(JsonObj **, CHAR *);
    bool (*Contains)(JsonObj *, CHAR *);
    // arrayValue api
    JsonObj *(*AddArrayItem)(JsonObj *, JsonObj);
    // common
    size_t (*GetSize)(const JsonObj *);
};

struct JsonKeyObj {
    const CHAR *key;
    JsonObj value;
};

JsonObj *JsonInit(void);
void JsonObjUnInit(JsonObj *obj);
void JsonFree(JsonObj *obj);
JsonObj *JsonParse(const CHAR *jsonContent);

JsonObj *JsonArrayAt(JsonObj *obj, size_t i);
JsonObj *GetJsonSubObj(JsonObj *obj, const char *key);
void JsonCopy(JsonObj *dstObj, const JsonObj *srcObj);

static inline bool JsonIsNull(JsonObj *obj)
{
    return (obj->type == CJSON_NULL);
};
static inline bool JsonIsInt(JsonObj *obj)
{
    return (obj->type == CJSON_INT);
};
static inline bool JsonIsUint(JsonObj *obj)
{
    return (obj->type == CJSON_UINT);
};
static inline bool JsonIsBool(JsonObj *obj)
{
    return (obj->type == CJSON_BOOL);
};
static inline bool JsonIsDouble(JsonObj *obj)
{
    return (obj->type == CJSON_DOUBLE);
};
static inline bool JsonIsString(JsonObj *obj)
{
    return (obj->type == CJSON_STRING);
};
static inline bool JsonIsObj(JsonObj *obj)
{
    return (obj->type == CJSON_OBJ);
};
static inline bool JsonIsArray(JsonObj *obj)
{
    return (obj->type == CJSON_ARRAY);
};
static inline bool GetJsonBool(JsonObj *obj)
{
    return ((obj->type != CJSON_BOOL)) ? false : obj->value.boolValue;
};
static inline int64_t GetJsonInt(JsonObj *obj)
{
    return (obj->type != CJSON_INT) ? 0 : obj->value.intValue;
};
static inline int64_t GetJsonUint(JsonObj *obj)
{
    return (obj->type != CJSON_UINT) ? 0 : obj->value.uintValue;
};
static inline double GetJsonDouble(JsonObj *obj)
{
    return (obj->type != CJSON_DOUBLE) ? 0 : obj->value.doubleValue;
};
static inline const CHAR *GetJsonString(JsonObj *obj)
{
    return (obj->type != CJSON_STRING) ? NULL : obj->value.stringValue;
};
static inline size_t GetJsonArraySize(JsonObj *obj)
{
    return (obj->type != CJSON_ARRAY) ? 0 : CVectorSize(&obj->value.arrayValue);
};

#ifdef __cplusplus
}
#endif
#endif