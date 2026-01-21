/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <stdbool.h>
#include "tlv_struct_parser.h"
#ifdef __cplusplus
extern "C" {
#endif
#define ParseSampleData(d_type, field_def, tlv_area, tlv_len, data, size)                               \
    ((((size) - (field_def)->offset_by_father_node < sizeof(d_type)) || ((tlv_len) < sizeof(d_type))) ? \
    -1 : (*(d_type*)((data) + (field_def)->offset_by_father_node) = *(d_type*)(tlv_area), sizeof(d_type)))


static int64_t ParseUint8(TlvFieldDef *field_def, ParseDataDef *data)
{
    return ParseSampleData(uint8_t, field_def, data->tlv_area, data->tlv_len, data->data, data->size);
}

static int64_t ParseUint16(TlvFieldDef *field_def, ParseDataDef *data)
{
    return ParseSampleData(uint16_t, field_def, data->tlv_area, data->tlv_len, data->data, data->size);
}

static int64_t ParseUint32(TlvFieldDef *field_def, ParseDataDef *data)
{
    return ParseSampleData(uint32_t, field_def, data->tlv_area, data->tlv_len, data->data, data->size);
}

static int64_t ParseUint64(TlvFieldDef *field_def, ParseDataDef *data)
{
    return ParseSampleData(uint64_t, field_def, data->tlv_area, data->tlv_len, data->data, data->size);
}

static int64_t ParseInt8(TlvFieldDef *field_def, ParseDataDef *data)
{
    return ParseSampleData(int8_t, field_def, data->tlv_area, data->tlv_len, data->data, data->size);
}

static int64_t ParseInt16(TlvFieldDef *field_def, ParseDataDef *data)
{
    return ParseSampleData(int16_t, field_def, data->tlv_area, data->tlv_len, data->data, data->size);
}

static int64_t ParseInt32(TlvFieldDef *field_def, ParseDataDef *data)
{
    return ParseSampleData(int32_t, field_def, data->tlv_area, data->tlv_len, data->data, data->size);
}

static int64_t ParseInt64(TlvFieldDef *field_def, ParseDataDef *data)
{
    return ParseSampleData(int64_t, field_def, data->tlv_area, data->tlv_len, data->data, data->size);
}

static int64_t ParseFloat(TlvFieldDef *field_def, ParseDataDef *data)
{
    return ParseSampleData(float, field_def, data->tlv_area, data->tlv_len, data->data, data->size);
}

static int64_t ParseDouble(TlvFieldDef *field_def, ParseDataDef *data)
{
    return ParseSampleData(double, field_def, data->tlv_area, data->tlv_len, data->data, data->size);
}

static int64_t ParseSize(TlvDataType type, uint8_t *tlv_area, size_t tlv_len, size_t *size)
{
    static const size_t g_sample_data_size_map[] = {
        sizeof(uint8_t), sizeof(uint16_t), sizeof(uint32_t), sizeof(uint64_t),
        sizeof(int8_t), sizeof(int16_t), sizeof(int32_t), sizeof(int64_t),
        sizeof(float), sizeof(double), 0, 0, 0, 0
    };
    if (tlv_len < g_sample_data_size_map[type]) {
        return -1;
    }
    switch (type) {
        case TLV_UINT8:
            *size = *tlv_area;
            return sizeof(uint8_t);
        case TLV_UINT16:
            *size = *(uint16_t*)tlv_area;
            return sizeof(uint16_t);
        case TLV_UINT32:
            *size = *(uint32_t*)tlv_area;
            return sizeof(uint32_t);
        case TLV_UINT64:
            *size = *(uint64_t*)tlv_area;
            return sizeof(uint64_t);
        case TLV_INT8:
            *size = *(int8_t*)tlv_area;
            return sizeof(int8_t);
        case TLV_INT16:
            *size = *(int16_t*)tlv_area;
            return sizeof(int16_t);
        case TLV_INT32:
            *size = *(int32_t*)tlv_area;
            return sizeof(int32_t);
        case TLV_INT64:
            *size = *(int64_t*)tlv_area;
            return sizeof(int64_t);
        default:
            return -1;
    }
}

static int64_t ParseCString(TlvFieldDef *field_def, ParseDataDef *data)
{
    TlvCStringDef *def = field_def->sub_field_def;
    if ((def == NULL) || (def->pfnRecord == NULL)) {
        return -1;
    }

    int64_t parse_len = 0;
    size_t string_valid_len = data->tlv_len;
    if (def->tlv_string_len) {
        int64_t size_len = ParseSize(def->string_len_type, data->tlv_area, data->tlv_len, &string_valid_len);
        if ((size_len < 0) || (string_valid_len > data->tlv_len - size_len)) {
            return -1;
        }
        parse_len += size_len;
    }

    if (def->pfnRecord(data->data + field_def->offset_by_father_node, data->tlv_area + parse_len, string_valid_len) <
        0) {
        return -1;
    }
    return parse_len + string_valid_len;
}

static int64_t ParseFields(
    TlvFieldDef *field_defs, size_t field_num, uint8_t *tlv_area, size_t tlv_len, uint8_t *data, size_t size);
static int64_t ParseStruct(TlvFieldDef *field_def, ParseDataDef *data)
{
    TlvStructDef *def = (TlvStructDef*)field_def->sub_field_def;
    if ((def == NULL) || (def->dest_struct_size < data->size - field_def->offset_by_father_node)) {
        return -1;
    }

    return ParseFields(def->field_defs, def->field_num, data->tlv_area, data->tlv_len,
        data->data + field_def->offset_by_father_node, def->dest_struct_size);
}

static int64_t ParseArray(TlvFieldDef *field_def, ParseDataDef *data)
{
    TlvArrayDef *array_def = (TlvArrayDef*)field_def->sub_field_def;
    if ((array_def == NULL) || (array_def->item_def == NULL) || (array_def->pfnGetItem == NULL)) {
        return -1;
    }
    uint8_t *tlv_area = data->tlv_area;
    size_t tlv_len = data->tlv_len;
#define ParseArrayTemplate(continue_condition)                                                                    \
    while (continue_condition) {                                                                                  \
        item = array_def->pfnGetItem(dest_array_area, index);                                                     \
        int64_t item_tlv_len =                                                                                    \
            ParseTlvStruct((TlvStructDef *)array_def->item_def, tlv_area + parse_len, tlv_len - parse_len, item); \
        if (item_tlv_len < 0) {                                                                                   \
            parse_len = -1;                                                                                       \
            break;                                                                                                \
        }                                                                                                         \
        parse_len += item_tlv_len;                                                                                \
        index++;                                                                                                  \
    }

    size_t valid_item_num = 0;
    size_t parse_len = 0;
    int64_t index = 0;
    uint8_t *item;
    uint8_t *dest_array_area = data->data + field_def->offset_by_father_node;
    if (array_def->tlv_item_num_flag) {
        int64_t size_len = ParseSize(array_def->item_num_type, tlv_area, tlv_len, &valid_item_num);
        if (size_len < 0) {
            return -1;
        }
        parse_len += size_len;
        ParseArrayTemplate(index < valid_item_num);
    } else {
        ParseArrayTemplate(parse_len < tlv_len);
    }
    return parse_len;
}

#define TlvHeadParseTemplate(t_type, l_type, tlv_area, len, t, l, value_offset) \
    do {                                                                        \
        value_offset = sizeof(t_type) + sizeof(l_type);                         \
        if ((len) >= (value_offset)) {                                          \
            t = (size_t)(*(t_type *)(tlv_area));                                \
            l = (size_t)(*(l_type *)(((t_type *)(tlv_area)) + 1));              \
        }                                                                       \
    } while (false)

#define SwitchLType(t_type, l_type, tlv_area, tlv_len, t, l, value_offset)                 \
    switch (l_type) {                                                                      \
        case TLV_UINT8:                                                                    \
            TlvHeadParseTemplate(t_type, uint8_t, tlv_area, tlv_len, t, l, value_offset);  \
            break;                                                                         \
        case TLV_UINT16:                                                                   \
            TlvHeadParseTemplate(t_type, uint16_t, tlv_area, tlv_len, t, l, value_offset); \
            break;                                                                         \
        case TLV_UINT32:                                                                   \
            TlvHeadParseTemplate(t_type, uint32_t, tlv_area, tlv_len, t, l, value_offset); \
            break;                                                                         \
        case TLV_INT8:                                                                     \
            TlvHeadParseTemplate(t_type, int8_t, tlv_area, tlv_len, t, l, value_offset);   \
            break;                                                                         \
        case TLV_INT16:                                                                    \
            TlvHeadParseTemplate(t_type, int16_t, tlv_area, tlv_len, t, l, value_offset);  \
            break;                                                                         \
        case TLV_INT32:                                                                    \
            TlvHeadParseTemplate(t_type, int32_t, tlv_area, tlv_len, t, l, value_offset);  \
            break;                                                                         \
        default:                                                                           \
            (value_offset) = -1;                                                           \
            break;                                                                         \
    }

int64_t ParseTlvHead(TlvSubTlvsDef *def, uint8_t *tlv_area, size_t tlv_len, size_t *t, size_t *l)
{
    int64_t offset = 0;
    switch (def->t_type) {
        case TLV_UINT8:
            SwitchLType(uint8_t, def->l_type, tlv_area, tlv_len, *t, *l, offset)
            break;
        case TLV_UINT16:
            SwitchLType(uint16_t, def->l_type, tlv_area, tlv_len, *t, *l, offset)
            break;
        case TLV_UINT32:
            SwitchLType(uint32_t, def->l_type, tlv_area, tlv_len, *t, *l, offset)
            break;
        case TLV_INT8:
            SwitchLType(int8_t, def->l_type, tlv_area, tlv_len, *t, *l, offset)
            break;
        case TLV_INT16:
            SwitchLType(int16_t, def->l_type, tlv_area, tlv_len, *t, *l, offset)
            break;
        case TLV_INT32:
            SwitchLType(int32_t, def->l_type, tlv_area, tlv_len, *t, *l, offset)
            break;
        default:
            return -1;
    }
    return (offset > tlv_len) ? -1 : offset;
}

static int64_t ParseTlv(TlvSubTlvsDef *def, uint8_t *tlv_area, size_t tlv_len, uint8_t *data, size_t size)
{
    size_t t;
    size_t l;
    int64_t head_len = ParseTlvHead(def, tlv_area, tlv_len, &t, &l);
    if ((head_len <= 0) || (l > tlv_len - head_len)) {
        return -1;
    }
    for (int i = 0; i < def->tlv_list_num; i++) {
        if (t == def->tlvs[i].tlv_t) {
            int64_t value_len = ParseFields(def->tlvs[i].field_defs, def->tlvs[i].field_num,
                                            tlv_area + head_len, l, data, size);
            if (value_len < 0) {
                return -1;
            }
        }
    }
    return l + head_len;
}

static int64_t ParseTlvList(TlvFieldDef *field_def, ParseDataDef *data)
{
    TlvSubTlvsDef *tlvs_def = (TlvSubTlvsDef*)field_def->sub_field_def;
    if ((tlvs_def == NULL) || (tlvs_def->tlvs == NULL)) {
        return -1;
    }
    uint8_t *tlv_area = data->tlv_area;
    size_t tlv_len = data->tlv_len;
    uint8_t *dstData = data->data;
    size_t size = data->size;
#define SubTlvListParseTemplate(continue_condition)                                                   \
    while (continue_condition) {                                                                      \
        int64_t cur_tlv_len = ParseTlv(tlvs_def, tlv_area + offset, tlv_len - offset, dstData, size); \
        if (cur_tlv_len < 0) {                                                                        \
            offset = -1;                                                                              \
            break;                                                                                    \
        }                                                                                             \
        offset += cur_tlv_len;                                                                        \
    }

    int64_t offset = 0;
    if (tlvs_def->tlv_num_flag) {
        size_t tlv_num = 0;
        offset = ParseSize(tlvs_def->tlv_num_or_len_type, tlv_area, tlv_len, &tlv_num);
        if (offset < 0) {
            return -1;
        }
        size_t parse_tlv_num = 0;
        SubTlvListParseTemplate(parse_tlv_num++ < tlv_num);
        return offset;
    }

    size_t sub_tlvs_len = tlv_len;
    int64_t total_len = tlv_len;
    if (tlvs_def->tlv_len_flag) {
        offset = ParseSize(tlvs_def->tlv_num_or_len_type, tlv_area, tlv_len, &sub_tlvs_len);
        if (offset < 0) {
            return -1;
        }
        total_len = offset + sub_tlvs_len;
    }
    SubTlvListParseTemplate(offset < total_len);
    return offset;
}

static int64_t ParseTlvField(TlvFieldDef *field_def, uint8_t *tlv_area, size_t tlv_len, uint8_t *data, size_t size)
{
    typedef int64_t (*PfnParseField)(TlvFieldDef *, ParseDataDef*);
    static const PfnParseField parser[] = {
        ParseUint8, ParseUint16, ParseUint32, ParseUint64,
        ParseInt8, ParseInt16, ParseInt32, ParseInt64,
        ParseFloat, ParseDouble, ParseCString,
        ParseStruct, ParseArray, ParseTlvList
    };

    if ((field_def->type >= TLV_DATATYPE_BUT) || (sizeof(parser)/sizeof(parser[0]) != TLV_DATATYPE_BUT) ||
        (field_def->offset_by_father_node >= size)) {
        return -1;
    }
    ParseDataDef dataDef = {tlv_area, tlv_len, data, size};
    return parser[field_def->type](field_def, &dataDef);
}

static int64_t ParseFields(TlvFieldDef *field_defs, size_t field_num,
                           uint8_t *tlv_area, size_t tlv_len, uint8_t *data, size_t size)
{
    uint8_t *remain_tlv = tlv_area;
    size_t remain_len = tlv_len;
    for (int i = 0; i < field_num; i++) {
        int64_t field_size = ParseTlvField(&field_defs[i], remain_tlv, remain_len, data, size);
        if (field_size < 0) {
            return -1;
        }
        remain_len -= field_size;
        remain_tlv += field_size;
    }
    return tlv_len - remain_len;
}

int64_t ParseTlvStruct(TlvStructDef *def, uint8_t *tlv_area, size_t tlv_len, uint8_t *data)
{
    if ((def == NULL) || (tlv_area == NULL) || (data == NULL)) {
        return -1;
    }
    return ParseFields(def->field_defs, def->field_num, tlv_area, tlv_len, data, def->dest_struct_size);
}
#ifdef __cplusplus
}
#endif

