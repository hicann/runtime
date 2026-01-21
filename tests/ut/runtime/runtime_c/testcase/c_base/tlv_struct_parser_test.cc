/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <gtest/gtest.h>
#include <memory>
#include <securec.h>
#include "c_base.h"
#include "vector.h"
#include "tlv_struct_parser.h"

using namespace testing;

class UtestTlvStructParseTest : public testing::Test {
    protected:
        void SetUp() {
        }

        void TearDown() {
        }
};

typedef struct SampleTypeTag {
    uint8_t u8;
    uint16_t u16;
    uint32_t u32;
    uint64_t u64;
    int8_t i8;
    int16_t i16;
    int32_t i32;
    int64_t i64;
} SampleType;

#pragma pack(1)
typedef struct {
    uint8_t u8;
    uint16_t u16;
    uint32_t u32;
    uint64_t u64;
    int8_t i8;
    int16_t i16;
    int32_t i32;
    int64_t i64;
} SampleStructTypeTlvValue;
#pragma pack()

TlvFieldDef g_test_tlv_sample_struct_field_def[] = {
    {"u8", TLV_UINT8, MEMBER_OFFSET(SampleType, u8), NULL},
    {"u16", TLV_UINT16, MEMBER_OFFSET(SampleType, u16), NULL},
    {"u32", TLV_UINT32, MEMBER_OFFSET(SampleType, u32), NULL},
    {"u64", TLV_UINT64, MEMBER_OFFSET(SampleType, u64), NULL},
    {"i8", TLV_INT8, MEMBER_OFFSET(SampleType, i8), NULL},
    {"i16", TLV_INT16, MEMBER_OFFSET(SampleType, i16), NULL},
    {"i32", TLV_INT32, MEMBER_OFFSET(SampleType, i32), NULL},
    {"i64", TLV_INT64, MEMBER_OFFSET(SampleType, i64), NULL},
};
TlvStructDef g_test_tlv_struct = {sizeof(g_test_tlv_sample_struct_field_def)/sizeof(g_test_tlv_sample_struct_field_def[0]), g_test_tlv_sample_struct_field_def, sizeof(SampleType)};

#pragma pack(1)
template<typename t_type, typename l_type>
struct TlvHead {
    t_type t;
    l_type l;
};

template<typename t_type, typename l_type>
struct SampleStructTypeTlv {
    TlvHead<t_type, l_type> head;
    SampleStructTypeTlvValue value;
};
#pragma pack()
void TEST_SUBTLVS_TEMPLATE_FUNC(TlvStructDef *test_tlv_struct, uint8_t *test_tlv, size_t tlv_size) {
    SampleType test_data = {0};
    int64_t parserSize = ParseTlvStruct(test_tlv_struct, test_tlv, tlv_size, (uint8_t*)&test_data);
    EXPECT_EQ(parserSize, tlv_size);
    EXPECT_EQ(test_data.u8, 1);
    EXPECT_EQ(test_data.u16, 2);
    EXPECT_EQ(test_data.u32, 3);
    EXPECT_EQ(test_data.u64, 4);
    EXPECT_EQ(test_data.i8, -5);
    EXPECT_EQ(test_data.i16, -6);
    EXPECT_EQ(test_data.i32, -7);
    EXPECT_EQ(test_data.i64, -8);

    parserSize = ParseTlvStruct(test_tlv_struct, test_tlv, tlv_size - 1, (uint8_t*)&test_data);
    EXPECT_EQ(parserSize, -1);
}

void TEST_SUBTLVS_INVALID_TEMPLATE_FUNC(TlvStructDef *test_tlv_struct, uint8_t *test_tlv, size_t tlv_size) {
    SampleType test_data = {0};
    int64_t parserSize = ParseTlvStruct(test_tlv_struct, test_tlv, tlv_size, (uint8_t*)&test_data);
    EXPECT_EQ(parserSize, -1);
}

template<typename t_type, typename l_type, TlvDataType t_data_type, TlvDataType l_data_type, size_t tlv_tvalue>
void TEST_SUBTLVS_TEMPLATE() {
    TlvDef g_test_tlv_def[] = {{"", tlv_tvalue,
        sizeof(g_test_tlv_sample_struct_field_def)/sizeof(g_test_tlv_sample_struct_field_def[0]),
        g_test_tlv_sample_struct_field_def}};
    TlvSubTlvsDef g_test_sub_tlvs = {t_data_type, l_data_type, false, false, TLV_DATATYPE_BUT,
        sizeof(g_test_tlv_def)/sizeof(g_test_tlv_def[0]), g_test_tlv_def};
    TlvFieldDef g_test_tlv_sample_struct_field_def[] = {
        {"tlv", TLV_SUB_TLVS, 0, &g_test_sub_tlvs}
    };
    TlvStructDef g_test_tlv_struct = {
        sizeof(g_test_tlv_sample_struct_field_def)/sizeof(g_test_tlv_sample_struct_field_def[0]),
        g_test_tlv_sample_struct_field_def, sizeof(SampleType)
    };

    SampleStructTypeTlv<t_type, l_type> test_tlv = {{tlv_tvalue, sizeof(SampleStructTypeTlvValue)},
        {1, 2, 3, 4, -5, -6, -7, -8}};
    if ((t_data_type == TLV_UINT64) || (t_data_type == TLV_INT64) ||
        (l_data_type == TLV_UINT64) || (l_data_type == TLV_INT64)) {
        TEST_SUBTLVS_INVALID_TEMPLATE_FUNC(&g_test_tlv_struct, (uint8_t*)&test_tlv, sizeof(test_tlv));
    } else {
        TEST_SUBTLVS_TEMPLATE_FUNC(&g_test_tlv_struct, (uint8_t*)&test_tlv, sizeof(test_tlv));
    }
}

#pragma pack(1)
template<typename t_type, typename l_type, typename tlv_num_type>
struct SampleStructTypeWithNum {
    tlv_num_type tlv_num;
    SampleStructTypeTlv<t_type, l_type> tlv;
};
#pragma pack()
template<typename t_type, typename l_type, typename tlv_num_type, TlvDataType t_data_type, TlvDataType l_data_type, TlvDataType num_data_type, size_t tlv_tvalue>
void TEST_SUBTLVS_WITH_TLV_NUM_TEMPLATE() {
    TlvDef g_test_tlv_def[] = {{"", tlv_tvalue,
        sizeof(g_test_tlv_sample_struct_field_def)/sizeof(g_test_tlv_sample_struct_field_def[0]),
        g_test_tlv_sample_struct_field_def}};
    TlvSubTlvsDef g_test_sub_tlvs = {t_data_type, l_data_type, true, false, num_data_type,
        sizeof(g_test_tlv_def)/sizeof(g_test_tlv_def[0]), g_test_tlv_def};
    TlvFieldDef g_test_tlv_sample_struct_field_def[] = {
        {"tlv", TLV_SUB_TLVS, 0, &g_test_sub_tlvs}
    };
    TlvStructDef g_test_tlv_struct = {
        sizeof(g_test_tlv_sample_struct_field_def)/sizeof(g_test_tlv_sample_struct_field_def[0]),
        g_test_tlv_sample_struct_field_def, sizeof(SampleType)
    };

    SampleStructTypeWithNum<t_type, l_type, tlv_num_type> test_tlv = {1,
        {{tlv_tvalue, sizeof(SampleStructTypeTlvValue)}, {1, 2, 3, 4, -5, -6, -7, -8}}};
    if ((t_data_type == TLV_UINT64) || (t_data_type == TLV_INT64) ||
        (l_data_type == TLV_UINT64) || (l_data_type == TLV_INT64)) {
        TEST_SUBTLVS_INVALID_TEMPLATE_FUNC(&g_test_tlv_struct, (uint8_t*)&test_tlv, sizeof(test_tlv));
    } else {
        TEST_SUBTLVS_TEMPLATE_FUNC(&g_test_tlv_struct, (uint8_t*)&test_tlv, sizeof(test_tlv));
    }
}

#pragma pack(1)
template<typename t_type, typename l_type, typename tlv_len_type>
struct SampleStructTypeWithLen {
    tlv_len_type tlv_len;
    SampleStructTypeTlv<t_type, l_type> tlv;
};
#pragma pack()
template<typename t_type, typename l_type, typename tlv_len_type,
    TlvDataType t_data_type, TlvDataType l_data_type, TlvDataType len_data_type,
    size_t tlv_tvalue>
void TEST_SUBTLVS_WITH_TLV_LEN_TEMPLATE() {
    TlvDef g_test_tlv_def[] = {{"", tlv_tvalue,
        sizeof(g_test_tlv_sample_struct_field_def)/sizeof(g_test_tlv_sample_struct_field_def[0]),
        g_test_tlv_sample_struct_field_def}};
    TlvSubTlvsDef g_test_sub_tlvs = {t_data_type, l_data_type, false, true, len_data_type,
        sizeof(g_test_tlv_def)/sizeof(g_test_tlv_def[0]), g_test_tlv_def};
    TlvFieldDef g_test_tlv_sample_struct_field_def[] = {
        {"tlv", TLV_SUB_TLVS, 0, &g_test_sub_tlvs}
    };
    TlvStructDef g_test_tlv_struct = {
        sizeof(g_test_tlv_sample_struct_field_def)/sizeof(g_test_tlv_sample_struct_field_def[0]),
        g_test_tlv_sample_struct_field_def, sizeof(SampleType)
    };

    SampleStructTypeWithLen<t_type, l_type, tlv_len_type> test_tlv = {
        sizeof(SampleStructTypeTlvValue) + sizeof(TlvHead<t_type, l_type>),
        {{tlv_tvalue, sizeof(SampleStructTypeTlvValue)}, {1, 2, 3, 4, -5, -6, -7, -8}}
    };
    if ((t_data_type == TLV_UINT64) || (t_data_type == TLV_INT64) ||
        (l_data_type == TLV_UINT64) || (l_data_type == TLV_INT64)) {
        TEST_SUBTLVS_INVALID_TEMPLATE_FUNC(&g_test_tlv_struct, (uint8_t*)&test_tlv, sizeof(test_tlv));
    } else {
        TEST_SUBTLVS_TEMPLATE_FUNC(&g_test_tlv_struct, (uint8_t*)&test_tlv, sizeof(test_tlv));
    }
}

#pragma pack(1)
template<typename t_type, typename l_type>
struct SampleTypeTlv {
    TlvHead<t_type, l_type> head_u8;
    uint8_t u8;
    TlvHead<t_type, l_type> head_u16;
    uint16_t u16;
    TlvHead<t_type, l_type> head_u32;
    uint32_t u32;
    TlvHead<t_type, l_type> head_u64;
    uint64_t u64;
    TlvHead<t_type, l_type> head_i8;
    int8_t i8;
    TlvHead<t_type, l_type> head_i16;
    int16_t i16;
    TlvHead<t_type, l_type> head_i32;
    int32_t i32;
    TlvHead<t_type, l_type> head_i64;
    int64_t i64;
};

template<typename t_type, typename l_type, typename num_type>
struct SampleTypeTlvWithNum {
    num_type num;
    SampleTypeTlv<t_type, l_type> tlv;
};

template<typename t_type, typename l_type, typename len_type>
struct SampleTypeTlvWithLen {
    len_type len;
    SampleTypeTlv<t_type, l_type> tlv;
};
#pragma pack()
TlvDef g_test_sample_tlv_def[] = {{"", 0, 1, &g_test_tlv_sample_struct_field_def[0]},
                               {"", 1, 1, &g_test_tlv_sample_struct_field_def[1]},
                               {"", 2, 1, &g_test_tlv_sample_struct_field_def[2]},
                               {"", 3, 1, &g_test_tlv_sample_struct_field_def[3]},
                               {"", 4, 1, &g_test_tlv_sample_struct_field_def[4]},
                               {"", 5, 1, &g_test_tlv_sample_struct_field_def[5]},
                               {"", 6, 1, &g_test_tlv_sample_struct_field_def[6]},
                               {"", 7, 1, &g_test_tlv_sample_struct_field_def[7]}};
template<typename t_type, typename l_type, TlvDataType t_data_type, TlvDataType l_data_type>
void TEST_SUBTLVS_SAMPLE_T_TEMPLATE() {
    TlvSubTlvsDef g_test_sub_tlvs = {t_data_type, l_data_type, false, false, TLV_DATATYPE_BUT,
        sizeof(g_test_sample_tlv_def)/sizeof(g_test_sample_tlv_def[0]), g_test_sample_tlv_def};
    TlvFieldDef g_test_tlv_struct_field_def[] = {
        {"tlv", TLV_SUB_TLVS, 0, &g_test_sub_tlvs}
    };
    TlvStructDef g_test_tlv_struct = {
        sizeof(g_test_tlv_struct_field_def)/sizeof(g_test_tlv_struct_field_def[0]),
        g_test_tlv_struct_field_def, sizeof(SampleType)
    };

    SampleTypeTlv<t_type, l_type> test_tlv = {{0, sizeof(uint8_t)}, 1, {1, sizeof(uint16_t)}, 2,
        {2, sizeof(uint32_t)}, 3, {3, sizeof(uint64_t)}, 4, {4, sizeof(uint8_t)}, -5,
        {5, sizeof(uint16_t)}, -6, {6, sizeof(uint32_t)}, -7, {7, sizeof(uint64_t)}, -8};
    if ((t_data_type == TLV_UINT64) || (t_data_type == TLV_INT64) ||
        (l_data_type == TLV_UINT64) || (l_data_type == TLV_INT64)) {
        TEST_SUBTLVS_INVALID_TEMPLATE_FUNC(&g_test_tlv_struct, (uint8_t*)&test_tlv, sizeof(test_tlv));
    } else {
        TEST_SUBTLVS_TEMPLATE_FUNC(&g_test_tlv_struct, (uint8_t*)&test_tlv, sizeof(test_tlv));
    }
}

template<typename t_type, typename l_type, typename num_type, TlvDataType t_data_type, TlvDataType l_data_type, TlvDataType num_data_type>
void TEST_SUBTLVS_SAMPLE_T_WITH_NUM_TEMPLATE() {
    TlvSubTlvsDef g_test_sub_tlvs = {t_data_type, l_data_type, true, false, num_data_type,
        sizeof(g_test_sample_tlv_def)/sizeof(g_test_sample_tlv_def[0]), g_test_sample_tlv_def};
    TlvFieldDef g_test_tlv_struct_field_def[] = {
        {"tlv", TLV_SUB_TLVS, 0, &g_test_sub_tlvs}
    };
    TlvStructDef g_test_tlv_struct = {
        sizeof(g_test_tlv_struct_field_def)/sizeof(g_test_tlv_struct_field_def[0]),
        g_test_tlv_struct_field_def, sizeof(SampleType)
    };

    SampleTypeTlvWithNum<t_type, l_type, num_type> test_tlv = {8, {{0, sizeof(uint8_t)}, 1, {1, sizeof(uint16_t)}, 2,
        {2, sizeof(uint32_t)}, 3, {3, sizeof(uint64_t)}, 4, {4, sizeof(uint8_t)}, -5,
        {5, sizeof(uint16_t)}, -6, {6, sizeof(uint32_t)}, -7, {7, sizeof(uint64_t)}, -8}};
    if ((t_data_type == TLV_UINT64) || (t_data_type == TLV_INT64) ||
        (l_data_type == TLV_UINT64) || (l_data_type == TLV_INT64)) {
        TEST_SUBTLVS_INVALID_TEMPLATE_FUNC(&g_test_tlv_struct, (uint8_t*)&test_tlv, sizeof(test_tlv));
    } else {
        TEST_SUBTLVS_TEMPLATE_FUNC(&g_test_tlv_struct, (uint8_t*)&test_tlv, sizeof(test_tlv));
    }
}

template<typename t_type, typename l_type, typename len_type, TlvDataType t_data_type, TlvDataType l_data_type, TlvDataType len_data_type>
void TEST_SUBTLVS_SAMPLE_T_WITH_LEN_TEMPLATE() {
    TlvSubTlvsDef g_test_sub_tlvs = {t_data_type, l_data_type, false, true, len_data_type,
        sizeof(g_test_sample_tlv_def)/sizeof(g_test_sample_tlv_def[0]), g_test_sample_tlv_def};
    TlvFieldDef g_test_tlv_struct_field_def[] = {
        {"tlv", TLV_SUB_TLVS, 0, &g_test_sub_tlvs}
    };
    TlvStructDef g_test_tlv_struct = {
        sizeof(g_test_tlv_struct_field_def)/sizeof(g_test_tlv_struct_field_def[0]),
        g_test_tlv_struct_field_def, sizeof(SampleType)
    };

    SampleTypeTlvWithLen<t_type, l_type, len_type> test_tlv = {sizeof(SampleTypeTlv<t_type, l_type>) - sizeof(len_type),
        {{0, sizeof(uint8_t)}, 1, {1, sizeof(uint16_t)}, 2, {2, sizeof(uint32_t)}, 3,
        {3, sizeof(uint64_t)}, 4, {4, sizeof(uint8_t)}, -5, {5, sizeof(uint16_t)}, -6,
        {6, sizeof(uint32_t)}, -7, {7, sizeof(uint64_t)}, -8}};
    if ((t_data_type == TLV_UINT64) || (t_data_type == TLV_INT64) ||
        (l_data_type == TLV_UINT64) || (l_data_type == TLV_INT64)) {
        TEST_SUBTLVS_INVALID_TEMPLATE_FUNC(&g_test_tlv_struct, (uint8_t*)&test_tlv, sizeof(test_tlv));
    } else {
        TEST_SUBTLVS_TEMPLATE_FUNC(&g_test_tlv_struct, (uint8_t*)&test_tlv, sizeof(test_tlv));
    }
}

struct DataString {
    size_t len;
    uint8_t data[128];
};
#pragma pack(1)
template<typename LenType>
struct StringTlvValue {
    LenType len;
    uint8_t data[128];
};
template<typename t_type, typename l_type>
struct StringTlv {
    TlvHead<t_type, l_type> head;
    uint8_t data[128];
};
#pragma pack()

void TEST_STRING_TEMPLATE_EXPECT_DATASTRING(DataString *test_string) {
    EXPECT_EQ(test_string->len, 4);
    EXPECT_EQ(test_string->data[0], 1);
    EXPECT_EQ(test_string->data[1], 2);
    EXPECT_EQ(test_string->data[2], 4);
    EXPECT_EQ(test_string->data[3], 8);
}
void TEST_STRING_TEMPLATE_INIT_DATASTRING(DataString *test_string) {
    test_string->len = 0;
    test_string->data[0] = 0;
    test_string->data[1] = 0;
    test_string->data[2] = 0;
    test_string->data[3] = 0;
}

void TEST_STRING_TEMPLATE_FUNC(TlvStructDef *test_tlv_struct, uint8_t *tlv, size_t tlv_size) {
    DataString test_string = {0};
    int64_t parserSize = ParseTlvStruct(test_tlv_struct, tlv, tlv_size, (uint8_t*)&test_string);
    EXPECT_EQ(parserSize, tlv_size);
    TEST_STRING_TEMPLATE_EXPECT_DATASTRING(&test_string);
    TEST_STRING_TEMPLATE_INIT_DATASTRING(&test_string);

    parserSize = ParseTlvStruct(test_tlv_struct, tlv, tlv_size - 1, (uint8_t*)&test_string);
    EXPECT_EQ(parserSize, -1);
    EXPECT_EQ(test_string.len, 0);
    EXPECT_EQ(test_string.data[0], 0);
}

template<typename LenType, TlvDataType l_type>
void TEST_STRING_WITH_LEN_TEMPLATE() {
    TlvCStringDef g_string_def = {true, l_type, [](void *dest_addr, char *data, size_t len) -> int64_t {
        if (len > 128) {
            return -1;
        }
        memcpy_s(dest_addr, 128, data, len);
        DataString *test_string = GET_MAIN_BY_MEMBER(dest_addr, DataString, data);
        test_string->len = len;
        return len;
    }};
    TlvFieldDef g_test_field_def[] = {
        {"string", TLV_STRING, MEMBER_OFFSET(DataString, data), &g_string_def},
    };
    TlvStructDef g_test_tlv_struct = {sizeof(g_test_field_def)/sizeof(g_test_field_def[0]),
        g_test_field_def, sizeof(DataString)};

    StringTlvValue<LenType> test_string_tlv = {4, {1,2,4,8}};
    TEST_STRING_TEMPLATE_FUNC(&g_test_tlv_struct,
        (uint8_t*)&test_string_tlv, sizeof(LenType) + 4);

    DataString test_string = {0};
    int64_t parserSize = ParseTlvStruct(&g_test_tlv_struct,
        (uint8_t*)&test_string_tlv, sizeof(LenType) + 4 + 1, (uint8_t*)&test_string);
    EXPECT_EQ(parserSize, sizeof(LenType) + 4);
    TEST_STRING_TEMPLATE_EXPECT_DATASTRING(&test_string);

    test_string_tlv.len = -1;
    parserSize = ParseTlvStruct(&g_test_tlv_struct,
        (uint8_t*)&test_string_tlv, sizeof(LenType) + 4, (uint8_t*)&test_string);
    EXPECT_EQ(parserSize, -1);
}

template<typename t_type, typename l_type, TlvDataType t_data_type, TlvDataType l_data_type>
void TEST_STRING_TLV_TEMPLATE() {
    TlvCStringDef g_string_def = {false, TLV_DATATYPE_BUT, [](void *dest_addr, char *data, size_t len) -> int64_t {
        if (len > 128) {
            return -1;
        }
        memcpy_s(dest_addr, 128, data, len);
        DataString *test_string = GET_MAIN_BY_MEMBER(dest_addr, DataString, data);
        test_string->len = len;
        return len;
    }};
    TlvFieldDef g_test_string_tlv_field_def[] = {
        {"string", TLV_STRING, MEMBER_OFFSET(DataString, data), &g_string_def}
    };
    TlvDef g_test_string_tlv_def[] = {
        {"", 100, sizeof(g_test_string_tlv_field_def)/sizeof(g_test_string_tlv_field_def[0]), g_test_string_tlv_field_def}
    };
    TlvSubTlvsDef g_test_sub_tlvs = {t_data_type, l_data_type, false, false, TLV_DATATYPE_BUT,
        sizeof(g_test_string_tlv_def)/sizeof(g_test_string_tlv_def[0]), g_test_string_tlv_def};
    TlvFieldDef g_test_tlv_struct_field_def[] = {
        {"tlv", TLV_SUB_TLVS, 0, &g_test_sub_tlvs}
    };
    TlvStructDef g_test_tlv_struct = {sizeof(g_test_tlv_struct_field_def)/sizeof(g_test_tlv_struct_field_def[0]),
        g_test_tlv_struct_field_def, sizeof(DataString)};

    StringTlv<t_type, l_type> test_string_tlv = {{100, 4}, {1,2,4,8}};
    TEST_STRING_TEMPLATE_FUNC(&g_test_tlv_struct,
        (uint8_t*)&test_string_tlv, sizeof(TlvHead<t_type, l_type>) + 4);

    DataString test_string = {0};
    int64_t parserSize = ParseTlvStruct(&g_test_tlv_struct,
        (uint8_t*)&test_string_tlv, sizeof(TlvHead<t_type, l_type>) + 4 + 1, (uint8_t*)&test_string);
    EXPECT_EQ(parserSize, -1);
}

typedef struct {
    int16_t a;
    int64_t b;
} ArrayItemStruct;

#pragma pack(1)
typedef struct {
    int16_t a;
    int64_t b;
} ArrayItemStructTlv;

#define ARRAY_ITEM_NUM_MAX 4
template <typename NumType>
struct ArrayWithNumStructTlv {
    NumType num;
    ArrayItemStructTlv array[ARRAY_ITEM_NUM_MAX];
};

template<typename t_type, typename l_type>
struct ArrayStructTlv {
    TlvHead<t_type, l_type> head;
    ArrayItemStructTlv array[ARRAY_ITEM_NUM_MAX];
};
#pragma pack()

void TEST_ARRAY_TEMPLATE_FUNC(TlvStructDef *test_tlv_struct, uint8_t *tlv, size_t tlv_size) {
    Vector test_array;
    InitVector(&test_array, sizeof(ArrayItemStruct));

    int64_t parserSize = ParseTlvStruct(test_tlv_struct, tlv, tlv_size, (uint8_t*)&test_array);
    EXPECT_EQ(parserSize, tlv_size);
    EXPECT_EQ(VectorSize(&test_array), 4);
    for (int i = 0; i < VectorSize(&test_array); i++) {
        ArrayItemStruct *item = (ArrayItemStruct*)VectorAt(&test_array, i);
        EXPECT_EQ(item->a, i + 1);
        EXPECT_EQ(item->b, i + 2);
    }

    parserSize = ParseTlvStruct(test_tlv_struct, tlv, tlv_size - 1, (uint8_t*)&test_array);
    EXPECT_EQ(parserSize, -1);

    DeInitVector(&test_array);
}

TlvFieldDef g_test_array_struct_field_def[] = {
    {"array_a", TLV_INT16, MEMBER_OFFSET(ArrayItemStruct, a), NULL},
    {"array_b", TLV_INT64, MEMBER_OFFSET(ArrayItemStruct, b), NULL},
};
TlvStructDef g_test_array_struct = {sizeof(g_test_array_struct_field_def)/sizeof(g_test_array_struct_field_def[0]),
    g_test_array_struct_field_def, sizeof(ArrayItemStruct)};

template<typename NumType, TlvDataType num_type>
void TEST_ARRAY_TEMPLATE() {
    TlvArrayDef g_array_def = {&g_test_array_struct, true, num_type, [](void *array_addr, int64_t index) -> void* {
        if (index >= ARRAY_ITEM_NUM_MAX) {
            return NULL;
        }

        Vector *array = (Vector*)array_addr;
        ReSizeVector(array, index + 1);
        return VectorAt(array, index);
    }};
    TlvFieldDef g_test_field_def[] = {
        {"array", TLV_ARRAY, 0, &g_array_def},
    };
    TlvStructDef g_test_tlv_struct = {sizeof(g_test_field_def)/sizeof(g_test_field_def[0]), g_test_field_def, sizeof(Vector)};

    ArrayWithNumStructTlv<NumType> test_array_tlv = {ARRAY_ITEM_NUM_MAX, {{1,2}, {2,3}, {3,4}, {4,5}}};
    TEST_ARRAY_TEMPLATE_FUNC(&g_test_tlv_struct, (uint8_t*)&test_array_tlv, sizeof(test_array_tlv));
}

template<typename t_type, typename l_type, TlvDataType t_data_type, TlvDataType l_data_type>
void TEST_ARRAY_TLV_TEMPLATE() {
    TlvArrayDef g_array_def = {&g_test_array_struct, false, TLV_DATATYPE_BUT, [](void *array_addr, int64_t index) -> void* {
        if (index >= ARRAY_ITEM_NUM_MAX) {
            return NULL;
        }

        Vector *array = (Vector*)array_addr;
        ReSizeVector(array, index + 1);
        return VectorAt(array, index);
    }};
    TlvFieldDef g_test_array_tlv_field_def[] = {
        {"array", TLV_ARRAY, 0, &g_array_def},
    };
    TlvDef g_tlv_list_def[] = {
        {"", 100, sizeof(g_test_array_tlv_field_def)/sizeof(g_test_array_tlv_field_def[0]), g_test_array_tlv_field_def}
    };
    TlvSubTlvsDef g_sub_tlvs_def = {t_data_type, l_data_type, false, false, TLV_DATATYPE_BUT,
        sizeof(g_tlv_list_def)/sizeof(g_tlv_list_def[0]), g_tlv_list_def};
    TlvFieldDef g_test_field_def[] = {
        {"tlv", TLV_SUB_TLVS, 0, &g_sub_tlvs_def},
    };
    TlvStructDef g_test_tlv_struct = {sizeof(g_test_field_def)/sizeof(g_test_field_def[0]), g_test_field_def, sizeof(Vector)};

    ArrayStructTlv<t_type, l_type> test_array_tlv = {{100, sizeof(ArrayItemStructTlv) * ARRAY_ITEM_NUM_MAX},
        {{1,2}, {2,3}, {3,4}, {4,5}}};
    TEST_ARRAY_TEMPLATE_FUNC(&g_test_tlv_struct, (uint8_t*)&test_array_tlv, sizeof(test_array_tlv));
}