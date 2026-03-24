/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef C_BASE_JSON_PARSER_H
#define C_BASE_JSON_PARSER_H
#include <stdio.h>
#include <stdint.h>
#include "vector.h"
#include "sort_vector.h"
#ifdef __cplusplus
extern "C" {
#endif

typedef enum {
    CJSON_NULL,
    CJSON_INT,
    CJSON_DOUBLE,
    CJSON_BOOL,
    CJSON_STRING,
    CJSON_OBJ,
    CJSON_ARRAY,
} CJSON_TYPE;

typedef struct {
    CJSON_TYPE type;
    union {
        char *string;
        bool value;
        double fNumber;
        int64_t iNumber;
        Vector array;
        SortVector objs;
    } value;
} CJsonObj;

CJsonObj *CJsonParse(const char *jsonContent, size_t jsonLen);
CJsonObj *CJsonFileParse(const char *filePath);
char *CJsonFileParseKey(const char *filePath, const char *key);
size_t CJsonParseKeyPosition(const char *jsonContent, size_t jsonLen, const char *key, size_t *offset);
void FreeCJsonObj(CJsonObj *obj);
CJsonObj *CJsonArrayAt(CJsonObj *obj, size_t i);
CJsonObj *GetCJsonSubObj(CJsonObj *obj, const char *key);

static inline bool CJsonIsNull(CJsonObj *obj)
{
    return (obj->type == CJSON_NULL);
};
static inline bool CJsonIsInt(CJsonObj *obj)
{
    return (obj->type == CJSON_INT);
};
static inline bool CJsonIsBool(CJsonObj *obj)
{
    return (obj->type == CJSON_BOOL);
};
static inline bool CJsonIsDouble(CJsonObj *obj)
{
    return (obj->type == CJSON_DOUBLE);
};
static inline bool CJsonIsString(CJsonObj *obj)
{
    return (obj->type == CJSON_STRING);
};
static inline bool CJsonIsObj(CJsonObj *obj)
{
    return (obj->type == CJSON_OBJ);
};
static inline bool CJsonIsArray(CJsonObj *obj)
{
    return (obj->type == CJSON_ARRAY);
};
static inline bool GetCJsonBool(CJsonObj *obj)
{
    return ((obj->type != CJSON_BOOL)) ? false : obj->value.value;
};
static inline int64_t GetCJsonInt(CJsonObj *obj)
{
    return (obj->type != CJSON_INT) ? 0 : obj->value.iNumber;
};
static inline double GetCJsonDouble(CJsonObj *obj)
{
    return (obj->type != CJSON_DOUBLE) ? 0 : obj->value.fNumber;
};
static inline char *GetCJsonString(CJsonObj *obj)
{
    return (obj->type != CJSON_STRING) ? NULL : obj->value.string;
};
static inline size_t GetCJsonArraySize(CJsonObj *obj)
{
    return (obj->type != CJSON_ARRAY) ? 0 : VectorSize(&obj->value.array);
};

#ifdef __cplusplus
}
#endif
#endif // C_BASE_JSON_PARSER_H