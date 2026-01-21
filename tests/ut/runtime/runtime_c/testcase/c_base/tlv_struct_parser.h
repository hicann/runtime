/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef TLV_STRUCT_PARSER_H
#define TLV_STRUCT_PARSER_H
#include <stddef.h>
#include <stdint.h>
#ifdef __cplusplus
extern "C" {
#endif
typedef enum {
    TLV_UINT8,
    TLV_UINT16,
    TLV_UINT32,
    TLV_UINT64,
    TLV_INT8,
    TLV_INT16,
    TLV_INT32,
    TLV_INT64,
    TLV_FLOAT,
    TLV_DOUBLE,
    TLV_STRING,
    TLV_STRUCT,
    TLV_ARRAY,
    TLV_SUB_TLVS,
    TLV_DATATYPE_BUT
} TlvDataType;

typedef struct {
    char *name;
    TlvDataType type;
    size_t offset_by_father_node;
    void *sub_field_def;
} TlvFieldDef;

typedef int64_t(*PfnRecordString)(void *dest_addr, char *data, size_t len);
typedef struct {
    uint64_t tlv_string_len : 1;
    TlvDataType string_len_type;
    PfnRecordString pfnRecord;
} TlvCStringDef;

typedef struct {
    size_t field_num;
    TlvFieldDef *field_defs;
    size_t dest_struct_size;
} TlvStructDef;

typedef void*(*PfnGetItem)(void *array_addr, int64_t index);
typedef struct {
    TlvStructDef *item_def;
    uint64_t   tlv_item_num_flag : 1;
    TlvDataType item_num_type;
    PfnGetItem pfnGetItem;
} TlvArrayDef;

typedef struct  {
    char *name;
    size_t tlv_t;
    size_t field_num;
    TlvFieldDef *field_defs;
} TlvDef;

typedef struct {
    TlvDataType t_type;
    TlvDataType l_type;
    uint64_t tlv_num_flag : 1;
    uint64_t tlv_len_flag : 1;
    TlvDataType tlv_num_or_len_type;
    size_t tlv_list_num;
    TlvDef *tlvs;
} TlvSubTlvsDef;

typedef struct  {
    uint8_t *tlv_area;
    size_t tlv_len;
    uint8_t *data;
    size_t size;
} ParseDataDef;

int64_t ParseTlvStruct(TlvStructDef *def, uint8_t *tlv_area, size_t tlv_len, uint8_t *data);
#ifdef __cplusplus
}
#endif
#endif