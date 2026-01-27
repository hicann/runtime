/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "json_generator.h"
#include <securec.h>
#include "utils/utils.h"
#include "osal/osal_mem.h"
#include "logger/logger.h"

#define CJSON_STACK_INIT_SIZE 256

static void* JsonContextPush(JsonContext* ctx, size_t size)
{
    if (size <= 0) {
        return NULL;
    }
    void* ret;
    if (ctx->top + size >= ctx->size) {
        if (ctx->size == 0) {
            ctx->size = CJSON_STACK_INIT_SIZE;
        }
        size_t oldSize = ctx->size;
        while (ctx->top + size >= ctx->size) {
            ctx->size += ctx->size >> 1;  /* c->size * 1.5 */
        }
        char *reallocStack = (char*)MsprofRealloc(ctx->stack, oldSize, ctx->size);
        if (reallocStack == NULL) {
            return NULL;
        }
        ctx->stack = reallocStack;
    }
    ret = ctx->stack + ctx->top;
    ctx->top += size;
    return ret;
}

static inline void PutChar(JsonContext* ctx, char ch)
{
    if (ctx == NULL) {
        return;
    }
    void *p = JsonContextPush(ctx, sizeof(char));
    PROF_CHK_EXPR_ACTION_NODO(p == NULL, return, "JsonContextPush Failed.");
    *(char*)p = ch;
}

static inline void PutStr(JsonContext* ctx, const char* str, size_t len)
{
    errno_t err = memcpy_s(JsonContextPush(ctx, len), ctx->size, str, len);
    if (err != EOK) {
        MSPROF_LOGE("memcpy_s failed, result=%d.", err);
        return;
    }
}

static void JsonMakeString(JsonContext* ctx, const char* s)
{
    if (s == NULL) {
        return;
    }
    size_t i, size;
    size_t len = strlen(s);
    char *head, *p;
    size_t maxCharLen = 6; // "\u00xx..."
    size_t twoQuotationLen = 2;

    head = JsonContextPush(ctx, size = len * maxCharLen + twoQuotationLen);
    p = head;
    PROF_CHK_EXPR_ACTION_NODO(p == NULL, return, "JsonMakeString Failed.");
    *p = '"';
    p++;
    for (i = 0; i < len; i++) {
        unsigned char ch = (unsigned char)s[i];
        switch (ch) {
            case '\"': *p++ = '\\'; *p++ = '\"'; break;
            case '\\': *p++ = '\\'; *p++ = '\\'; break;
            case '\b': *p++ = '\\'; *p++ = 'b';  break;
            case '\f': *p++ = '\\'; *p++ = 'f';  break;
            case '\n': *p++ = '\\'; *p++ = 'n';  break;
            case '\r': *p++ = '\\'; *p++ = 'r';  break;
            case '\t': *p++ = '\\'; *p++ = 't';  break;
            default:
                *p = s[i];
                p++;
        }
    }
    *p = '"';
    p++;
    ctx->top -= size - (p - head);
}

static void IntNumberToString(JsonContext* ctx, const JsonObj* obj)
{
    char buffer[32];
    int32_t length = sprintf_s(buffer, sizeof(buffer), "%lld", obj->value.intValue);
    PROF_CHK_EXPR_ACTION(length < 0, return, "sprintf_s fail for int value");
    PutStr(ctx, buffer, (size_t)length);
}

static void UintNumberToString(JsonContext* ctx, const JsonObj* obj)
{
    char buffer[32];
    int32_t length = sprintf_s(buffer, sizeof(buffer), "%llu", obj->value.uintValue);
    PROF_CHK_EXPR_ACTION(length < 0, return, "sprintf_s fail for uint value");
    PutStr(ctx, buffer, (size_t)length);
}

static void JsonObjToString(JsonContext* ctx, const JsonObj* obj)
{
    if (obj == NULL) {
        return;
    }
    size_t i;
    switch (obj->type) {
        case CJSON_NULL: PutStr(ctx, "null",  strlen("null")); break;
        case CJSON_BOOL:
            (obj->value.boolValue) ? PutStr(ctx, "true", strlen("true")) : PutStr(ctx, "false", strlen("false")); break;
        case CJSON_INT: IntNumberToString(ctx, obj); break;
        case CJSON_UINT: UintNumberToString(ctx, obj); break;
        case CJSON_DOUBLE:
            {
                char buffer[32];
                int32_t length = sprintf_s(buffer, sizeof(buffer), "%.16g", obj->value.doubleValue);
                PROF_CHK_EXPR_ACTION(length < 0, return, "sprintf_s fail for double value");
                PutStr(ctx, buffer, (size_t)length);
            }
            break;
        case CJSON_STRING: JsonMakeString(ctx, obj->value.stringValue); break;
        case CJSON_ARRAY:
            PutChar(ctx, '[');
            for (i = 0; i < obj->value.arrayValue.size; i++) {
                if (i > 0) {
                    PutChar(ctx, ',');
                }
                const JsonObj* arrItem = (const JsonObj*)ConstCVectorAt(&obj->value.arrayValue, i);
                JsonObjToString(ctx, arrItem);
            }
            PutChar(ctx, ']');
            break;
        case CJSON_OBJ:
            PutChar(ctx, '{');
            for (i = 0; i < obj->value.objectValue.vector.size; i++) {
                if (i > 0) {
                    PutChar(ctx, ',');
                }
                const JsonKeyObj* kvItem = (const JsonKeyObj*)ConstCVectorAt(&obj->value.objectValue.vector, i);
                JsonMakeString(ctx, kvItem->key);
                PutChar(ctx, ':');
                JsonObjToString(ctx, &kvItem->value);
            }
            PutChar(ctx, '}');
            break;
        default: break;
    }
}

char* JsonToString(const JsonObj* obj)
{
    if (obj == NULL) {
        return NULL;
    }
    JsonContext ctx;
    ctx.stack = (char*)OsalMalloc(ctx.size = CJSON_STACK_INIT_SIZE);
    if (ctx.stack == NULL) {
        MSPROF_LOGE("JsonContext malloc failed.");
        return NULL;
    }
    ctx.top = 0;
    JsonObjToString(&ctx, obj);
    PutChar(&ctx, '\0');
    return ctx.stack;
}