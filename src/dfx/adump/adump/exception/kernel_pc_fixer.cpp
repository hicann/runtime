/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <algorithm>
#include <initializer_list>
#include <mutex>
#include "securec.h"
#include "runtime/base.h"
#include "kernel_pc_fixer.h"
#include "acc_error_info.h"
#include "common/adump_dsmi.h"
#include "common/adump_platform_manager.h"
#include "log/adx_log.h"

namespace Adx {
namespace {
constexpr uint32_t UINT32_BIT_NUM = 32U;
constexpr uint32_t V100_AIC_ERR_NUM = 6U;
std::mutex g_pcFixerMutex;

// start/end 为闭区间，当前调用点均使用合法常量范围。
constexpr uint64_t GenPcMask64(uint64_t start, uint64_t end)
{
    return static_cast<uint64_t>(((1ULL << (end - start + 1ULL)) - 1ULL) << start);
}

constexpr uint32_t GenPcMask32(uint32_t start, uint32_t end)
{
    return static_cast<uint32_t>(((1ULL << (end - start + 1ULL)) - 1ULL) << start);
}

PcFixEntry MakePcFixEntry(uint32_t errInfoRegNum, uint64_t srcMask, uint64_t dstMask)
{
    return {errInfoRegNum, srcMask, dstMask};
}

void AddPcFixGroup(
    std::vector<PcFixGroup>& groups, uint32_t moduleId, uint32_t aicErrMask,
    std::initializer_list<PcFixEntry> entries)
{
    if (aicErrMask == 0) {
        return;
    }
    PcFixGroup group;
    group.moduleId = moduleId;
    group.aicErrMask = aicErrMask;
    group.entries.insert(group.entries.end(), entries.begin(), entries.end());
    groups.push_back(group);
}

} // namespace

void PcFixerInterface::ReplacePcBits(uint64_t& pc, uint32_t regValue, uint64_t srcMask, uint64_t dstMask)
{
    if (srcMask == 0 || dstMask == 0 || __builtin_popcountll(srcMask) != __builtin_popcountll(dstMask)) {
        IDE_LOGW("[Dump][Exception] Invalid PC fix mask, srcMask=%lu, dstMask=%lu.", srcMask, dstMask);
        return;
    }
    int srcShift = __builtin_ctzll(srcMask);
    int dstShift = __builtin_ctzll(dstMask);
    uint64_t extracted = (static_cast<uint64_t>(regValue) & srcMask) >> srcShift;
    pc = (pc & ~dstMask) | ((extracted << dstShift) & dstMask);
}

uint64_t PcFixerInterface::FixPc(uint64_t pc, const uint32_t errReg[], size_t errRegLen)
{
    if (errReg == nullptr || errRegLen == 0) {
        IDE_LOGW("[Dump][Exception] Invalid error register info, skip fix PC.");
        return pc;
    }

    std::vector<const PcFixGroup*> matchedGroups = GetMatchedGroups(errReg, errRegLen);
    if (matchedGroups.empty()) {
        IDE_LOGI("[Dump][Exception] No matched PC fix module, skip fix PC.");
        return pc;
    }

    std::vector<uint64_t> fixedPcs;
    fixedPcs.reserve(matchedGroups.size());
    for (const auto* matchedGroup : matchedGroups) {
        uint64_t moduleFixedPc = pc;
        for (const auto& entry : matchedGroup->entries) {
            if (entry.errInfoRegNum >= errRegLen) {
                continue;
            }
            uint32_t regValue = errReg[entry.errInfoRegNum];
            ReplacePcBits(moduleFixedPc, regValue, entry.srcMask, entry.dstMask);
        }
        fixedPcs.push_back(moduleFixedPc);
        std::string moduleName = GetModuleName(matchedGroup->moduleId);
        IDE_LOGE("[Dump][Exception] Fix PC with module=%s, originalPC=0x%lx, fixedPC=0x%lx.",
            moduleName.c_str(), pc, fixedPcs.back());
    }
    return fixedPcs.front();
}

std::vector<const PcFixGroup*> PcFixerInterface::GetMatchedGroups(const uint32_t errReg[], size_t errRegLen) const
{
    std::vector<const PcFixGroup*> matchedGroups;
    for (uint32_t i = 0; i < errCount_; i++) {
        uint32_t errIdx = errStartIdx_ + i;
        if (errIdx >= errRegLen) {
            continue;
        }
        uint32_t errVal = errReg[errIdx];
        if (errVal == 0) {
            continue;
        }
        if (i >= table_.size() || table_[i].empty()) {
            continue;
        }
        for (const auto& group : table_[i]) {
            if ((errVal & group.aicErrMask) == 0) {
                continue;
            }
            bool moduleExists = std::any_of(matchedGroups.begin(), matchedGroups.end(),
                [&group](const auto* matchedGroup) {
                    return matchedGroup->moduleId == group.moduleId;
                });
            if (moduleExists) {
                continue;
            }
            matchedGroups.push_back(&group);
        }
    }
    return matchedGroups;
}

// ===== V100（CloudV2）错误位名称表 =====

namespace {
const char* const AIC_ERROR_0_BIT_NAMES[UINT32_BIT_NUM] = {
    "biu_l2_read_oob", "biu_l2_write_oob", "ccu_call_depth_ovrflw", "ccu_div0",
    "ccu_illegal_instr", "ccu_loop_cnt_err", "ccu_loop_err", "ccu_neg_sqrt",
    "ccu_ub_ecc", "cube_invld_input", "cube_l0a_ecc", "cube_l0a_rdwr_cflt",
    "cube_l0a_wrap_around", "cube_l0b_ecc", "cube_l0b_rdwr_cflt", "cube_l0b_wrap_around",
    "cube_l0c_ecc", "cube_l0c_rdwr_cflt", "cube_l0c_self_rdwr_cflt", "cube_l0c_wrap_around",
    "ifu_bus_err", "mte_aipp_illegal_param", "mte_bas_raddr_obound", "mte_biu_rdwr_resp",
    "mte_cidx_overflow", "mte_decomp", "mte_f1wpos_larger_fsize", "mte_fmap_less_kernel",
    "mte_fmapwh_larger_l1size", "mte_fpos_larger_fsize", "mte_gdma_illegal_burst_len", "mte_gdma_illegal_burst_num",
};

const char* const AIC_ERROR_1_BIT_NAMES[UINT32_BIT_NUM] = {
    "mte_gdma_read_overflow", "mte_gdma_write_overflow", "mte_comp", "mte_illegal_fm_size",
    "mte_illegal_l1_3d_size", "mte_illegal_stride", "mte_l0a_rdwr_cflt", "mte_l0b_rdwr_cflt",
    "mte_l1_ecc", "mte_padding_cfg", "mte_read_overflow", "mte_rob_ecc",
    "mte_tlu_ecc", "mte_ub_ecc", "mte_unzip", "mte_write_3d_overflow",
    "mte_write_overflow", "vec_data_excp_ccu", "vec_data_excp_mte", "vec_data_excp_vec",
    "vec_div0", "vec_illegal_mask", "vec_inf_nan", "vec_l0c_ecc",
    "vec_l0c_rdwr_cflt", "vec_neg_ln", "vec_neg_sqrt", "vec_same_blk_addr",
    "vec_ub_ecc", "vec_ub_self_rdwr_cflt", "vec_ub_wrap_around", "biu_dfx_err",
};

const char* const AIC_ERROR_2_BIT_NAMES[UINT32_BIT_NUM] = {
    "ccu_sbuf_ecc", "vec_col2img_rd_fm_addr_ovflow",
    "vec_col2img_rd_dfm_addr_ovfflow", "vec_col2img_illegal_fm_size",
    "vec_col2img_illegal_stride", "vec_col2img_illegal_1st_win_pos",
    "vec_col2img_illegal_fetch_pos", "vec_col2img_illegal_k_size",
    "ccu_inf_nan", "mte_illegal_schn_cfg", "mte_atm_addr_misalg",
    "vec_instr_addr_misalign", "vec_instr_illegal_cfg", "vec_instr_undef",
    "ccu_addr_err",
    "reserved_ccu_bus_err", "mte_err_addr_misalign", "mte_err_dw_pad_conf_err",
    "mte_err_dw_fmap_h_illegal", "mte_err_wino_l0b_write_overflow",
    "mte_err_wino_l0b_read_overflow", "mte_err_illegal_v_cov_pad_ctl",
    "mte_err_illegal_h_cov_pad_ctl", "mte_err_illegal_w_size",
    "mte_err_illegal_h_size", "mte_err_illegal_chn_size",
    "mte_err_illegal_k_m_ext_step", "mte_err_illegal_k_m_start_pos",
    "mte_err_illegal_smallk_cfg", "mte_err_read_3d_overflow", "ccu_veciq_ecc",
    "ccu_dc_data_ecc",
};

const char* const AIC_ERROR_3_BIT_NAMES[UINT32_BIT_NUM] = {
    "ccu_dc_tag_ecc", "ccu_div0_fp", "ccu_neg_sqrt_fp", "cnt_sw_bus_err",
    "fixp_err_instr_addr_misal", "fixp_err_illegal_cfg", "fixp_err_read_l0c_ovflw",
    "fixp_err_read_l1_ovflw", "fixp_err_read_ub_ovflw", "fixp_err_write_l1_ovflw",
    "fixp_err_write_ub_ovflw", "fixp_err_fbuf_write_ovflw", "fixp_err_fbuf_read_ovflw",
    "sc_reg_parity_err", "mte_err_fifo_parity", "mte_err_waitset",
    "ccu_err_parity_err", "mte_err_cache_ecc", "cube_err_hset_cnt_unf",
    "cube_err_hset_cnt_ovf", "mte_err_instr_illegal_cfg", "mte_err_hebcd",
    "mte_err_hebce", "mte_err_waipp", "ccu_seq_err", "ccu_mpu_err",
    "ccu_lsu_err", "ccu_pb_ecc_err", "mte_ub_wr_ovflw", "mte_ub_rd_ovflw",
    "cube_illegal_instr", "ccu_safety_crc_err",
};

const char* const AIC_ERROR_4_BIT_NAMES[UINT32_BIT_NUM] = {
    "mte_timeout", "mte_ub_rd_cflt", "mte_ub_wr_cflt", "mte_ktable_wr_addr_overflow",
    "mte_ktable_rd_addr_overflow", "ccu_ub_rd_cflt", "ccu_ub_wr_cflt", "ccu_ub_overflow_err",
    "biu_unsplit_err", "mte_stb_ecc_err", "mte_aipp_ecc_err", "ccu_lsu_atomic_err",
    "ccu_cross_core_set_ovfl_err", "fixp_err_out_write_overflow", "cube_err_pbuf_wrap_around", "fixp_l0c_ecc",
    "mte_err_l0c_rdwr_cflt", "reserved", "reserved", "reserved",
    "reserved", "reserved", "reserved", "reserved",
    "reserved", "reserved", "reserved", "reserved",
    "reserved", "reserved", "reserved", "reserved",
};

const char* const AIC_ERROR_5_BIT_NAMES[UINT32_BIT_NUM] = {
    "vec_data_excpt_mte", "vec_data_excpt_su", "vec_data_excpt_vec", "vec_instr_timeout",
    "vec_instrs_undef", "vec_instr_ill_cfg", "vec_instr_misalign", "vec_instr_ill_mask",
    "vec_instr_ill_sqzn", "vec_ub_addr_wrap_around", "vec_ub_ecc_mberr", "vec_idata_inf_nan",
    "vec_div_by_zero", "vec_valu_neg_ln", "vec_valu_neg_sqrt", "vec_vci_idata_out_range",
    "vec_ill_vloop_op", "vec_ill_vloop_sreg", "vec_ld_num_mismatch", "vec_st_num_mismatch",
    "vec_ex_num_mismatch", "vec_ld_num_exceed_limit", "vec_st_num_exceed_limit", "vec_ill_instr_padding",
    "vec_ill_vga_vpd_order", "vec_ic_ecc_err", "vec_biu_resp_err", "vec_pb_ecc_mberr",
    "vec_pb_read_no_resp", "vec_valu_ill_issue", "vec_err_parity_err", "reserved",
};

const char* const* const AIC_ERROR_BIT_NAMES[V100_AIC_ERR_NUM] = {
    AIC_ERROR_0_BIT_NAMES, AIC_ERROR_1_BIT_NAMES, AIC_ERROR_2_BIT_NAMES,
    AIC_ERROR_3_BIT_NAMES, AIC_ERROR_4_BIT_NAMES, AIC_ERROR_5_BIT_NAMES,
};

enum V100ModuleIdx {
    V100_CUBE_INFO_IDX,
    V100_CCU_INFO_IDX,
    V100_IFU_INFO_IDX,
    V100_MTE_INFO_IDX,
    V100_VEC_INFO_IDX,
    V100_FIXP_INFO_IDX,
    V100_MODULE_ID_NUM
};

enum V200ErrorIdx {
    V200_SC_ERROR_T0_IDX,
    V200_SU_ERROR_T0_IDX,
    V200_MTE_ERROR_T0_IDX,
    V200_MTE_ERROR_T1_IDX,
    V200_VEC_ERROR_T0_IDX,
    V200_VEC_ERROR_T2_IDX,
    V200_CUBE_ERROR_T0_IDX,
    V200_CUBE_ERROR_T1_IDX,
    V200_L1_ERROR_T0_IDX,
    V200_L1_ERROR_T1_IDX,
    V200_ERROR_IDX_NUM
};

// V100 errReg 下标对应的 RTS 寄存器枚举名称，与 rtErrRegInfoIdxV100_t 顺序一致。
const char* const V100_REG_NAMES[] = {
    "AIC_ERR_0", "AIC_ERR_1", "AIC_ERR_2", "AIC_ERR_3",
    "AIC_ERR_4", "AIC_ERR_5", "BIU_ERR_0", "BIU_ERR_1",
    "CCU_ERR_0", "CCU_ERR_1", "CUBE_ERR_0", "CUBE_ERR_1",
    "IFU_ERR_0", "IFU_ERR_1", "MTE_ERR_0", "MTE_ERR_1",
    "VEC_ERR_0", "VEC_ERR_1", "FIXP_ERR_0", "FIXP_ERR_1",
    "AIC_COND_0", "AIC_COND_1",
};

// V200 errReg 下标对应的 RTS 寄存器枚举名称，与 rtErrRegInfoIdxV200_t 顺序一致。
const char* const V200_REG_NAMES[] = {
    "SU_ERR_INFO_T0_0", "SU_ERR_INFO_T0_1", "SU_ERR_INFO_T0_2",
    "SU_ERR_INFO_T0_3", "MTE_ERR_INFO_T0_0", "MTE_ERR_INFO_T0_1",
    "MTE_ERR_INFO_T0_2", "MTE_ERR_INFO_T1_0", "MTE_ERR_INFO_T1_1",
    "MTE_ERR_INFO_T1_2", "VEC_ERR_INFO_T0_0", "VEC_ERR_INFO_T0_1",
    "VEC_ERR_INFO_T0_2", "VEC_ERR_INFO_T0_3", "VEC_ERR_INFO_T0_4",
    "VEC_ERR_INFO_T0_5", "CUBE_ERR_INFO_T0_0", "CUBE_ERR_INFO_T0_1",
    "L1_ERR_INFO_T0_0", "L1_ERR_INFO_T0_1", "SC_ERROR_T0_0",
    "SU_ERROR_T0_0", "MTE_ERROR_T0_0", "MTE_ERROR_T1_0",
    "VEC_ERROR_T0_0", "VEC_ERROR_T0_2", "CUBE_ERROR_T0_0",
    "CUBE_ERROR_T0_1", "L1_ERROR_T0_0", "L1_ERROR_T0_1",
    "SC_ERR_INFO_T0_0", "SC_ERR_INFO_T0_1", "SU_SPR_CONDITION_0",
    "SU_SPR_CONDITION_1",
};

std::string GetV100BitName(uint32_t aicErrorIdx, uint32_t bit)
{
    if (aicErrorIdx >= V100_AIC_ERR_NUM || bit >= UINT32_BIT_NUM) {
        return "";
    }
    return std::string(AIC_ERROR_BIT_NAMES[aicErrorIdx][bit]);
}

bool IsCubeErrorBitName(const std::string& bitName)
{
    return bitName.find("cube_") == 0 || bitName.find("cube_err_") == 0 || bitName.find("cube_invld_") == 0;
}

bool IsCcuErrorBitName(const std::string& bitName)
{
    return bitName.find("ccu_") == 0 || bitName.find("ccu_err_") == 0 || bitName.find("ccu_inf_") == 0 ||
           bitName.find("ccu_addr_") == 0 || bitName.find("ccu_div0_fp") == 0 ||
           bitName.find("ccu_neg_sqrt_fp") == 0 || bitName.find("ccu_dc_") == 0 ||
           bitName.find("ccu_sbuf_") == 0 || bitName.find("ccu_veciq_") == 0 ||
           bitName.find("ccu_pb_ecc_err") == 0 || bitName.find("ccu_seq_") == 0 ||
           bitName.find("ccu_mpu_") == 0 || bitName.find("ccu_lsu_") == 0 ||
           bitName.find("ccu_safety_") == 0;
}

bool IsVecErrorBitName(const std::string& bitName)
{
    return bitName.find("vec_") == 0 || bitName.find("vec_data_excp_") == 0 ||
           bitName.find("vec_col2img_") == 0 || bitName.find("vec_instr_") == 0 ||
           bitName.find("vec_err_parity_") == 0;
}

void BuildV100ModuleMasks(uint32_t aicErrorIdx, uint32_t moduleMasks[])
{
    for (uint32_t bit = 0; bit < UINT32_BIT_NUM; bit++) {
        std::string bitName = GetV100BitName(aicErrorIdx, bit);
        if (IsCubeErrorBitName(bitName)) {
            moduleMasks[V100_CUBE_INFO_IDX] |= (1U << bit);
        } else if (IsCcuErrorBitName(bitName)) {
            moduleMasks[V100_CCU_INFO_IDX] |= (1U << bit);
        } else if (bitName.find("mte_") == 0 || bitName.find("mte_err_") == 0) {
            moduleMasks[V100_MTE_INFO_IDX] |= (1U << bit);
        } else if (IsVecErrorBitName(bitName)) {
            moduleMasks[V100_VEC_INFO_IDX] |= (1U << bit);
        } else if (bitName.find("fixp_") == 0 || bitName.find("fixp_err_") == 0) {
            moduleMasks[V100_FIXP_INFO_IDX] |= (1U << bit);
        }
    }
}

void AppendV100PcFixGroups(const uint32_t moduleMasks[], std::vector<PcFixGroup>& groups)
{
    AddPcFixGroup(groups, V100_CUBE_INFO_IDX, moduleMasks[V100_CUBE_INFO_IDX],
        {MakePcFixEntry(RT_V100_CUBE_ERR_0, GenPcMask64(0, 7), GenPcMask64(2, 9)),
            MakePcFixEntry(RT_V100_CUBE_ERR_0, GenPcMask64(24, 31), GenPcMask64(10, 17))});
    AddPcFixGroup(groups, V100_CCU_INFO_IDX, moduleMasks[V100_CCU_INFO_IDX],
        {MakePcFixEntry(RT_V100_CCU_ERR_0, GenPcMask64(0, 7), GenPcMask64(2, 9)),
            MakePcFixEntry(RT_V100_CCU_ERR_0, GenPcMask64(23, 30), GenPcMask64(10, 17))});
    AddPcFixGroup(groups, V100_MTE_INFO_IDX, moduleMasks[V100_MTE_INFO_IDX],
        {MakePcFixEntry(RT_V100_MTE_ERR_0, GenPcMask64(0, 7), GenPcMask64(2, 9)),
            MakePcFixEntry(RT_V100_MTE_ERR_1, GenPcMask64(0, 7), GenPcMask64(10, 17))});
    AddPcFixGroup(groups, V100_VEC_INFO_IDX, moduleMasks[V100_VEC_INFO_IDX],
        {MakePcFixEntry(RT_V100_VEC_ERR_0, GenPcMask64(0, 7), GenPcMask64(2, 9)),
            MakePcFixEntry(RT_V100_VEC_ERR_1, GenPcMask64(0, 7), GenPcMask64(10, 17))});
    AddPcFixGroup(groups, V100_FIXP_INFO_IDX, moduleMasks[V100_FIXP_INFO_IDX],
        {MakePcFixEntry(RT_V100_FIXP_ERR_0, GenPcMask64(0, 7), GenPcMask64(2, 9)),
            MakePcFixEntry(RT_V100_FIXP_ERR_1, GenPcMask64(0, 7), GenPcMask64(10, 17))});
}

void InitV200CommonPcFixGroups(std::vector<std::vector<PcFixGroup>>& table)
{
    AddPcFixGroup(table[V200_SU_ERROR_T0_IDX], V200_SU_ERROR_T0_IDX, GenPcMask32(0, 31),
        {MakePcFixEntry(RT_V200_SU_ERR_INFO_T0_0, GenPcMask64(0, 15), GenPcMask64(2, 17))});
    AddPcFixGroup(table[V200_MTE_ERROR_T0_IDX], V200_MTE_ERROR_T0_IDX, GenPcMask32(0, 31),
        {MakePcFixEntry(RT_V200_MTE_ERR_INFO_T0_0, GenPcMask64(0, 15), GenPcMask64(2, 17))});
    // MTE_ERR_INFO_T1_0值废弃，使用MTE_ERR_INFO_T0_0
    AddPcFixGroup(table[V200_MTE_ERROR_T1_IDX], V200_MTE_ERROR_T0_IDX, GenPcMask32(0, 31),
        {MakePcFixEntry(RT_V200_MTE_ERR_INFO_T0_0, GenPcMask64(0, 15), GenPcMask64(2, 17))});
}

void InitV200VecPcFixGroups(std::vector<std::vector<PcFixGroup>>& table)
{
    AddPcFixGroup(table[V200_VEC_ERROR_T0_IDX], V200_VEC_ERROR_T0_IDX, GenPcMask32(0, 25),
        {MakePcFixEntry(RT_V200_VEC_ERR_INFO_T0_1, GenPcMask64(0, 31), GenPcMask64(0, 31)),
            MakePcFixEntry(RT_V200_VEC_ERR_INFO_T0_2, GenPcMask64(0, 16), GenPcMask64(32, 48))});
    AddPcFixGroup(table[V200_VEC_ERROR_T2_IDX], V200_VEC_ERROR_T0_IDX, GenPcMask32(0, 1),
        {MakePcFixEntry(RT_V200_VEC_ERR_INFO_T0_1, GenPcMask64(0, 31), GenPcMask64(0, 31)),
            MakePcFixEntry(RT_V200_VEC_ERR_INFO_T0_2, GenPcMask64(0, 16), GenPcMask64(32, 48))});
}

void InitV200CubeAndL1PcFixGroups(std::vector<std::vector<PcFixGroup>>& table)
{
    AddPcFixGroup(table[V200_CUBE_ERROR_T0_IDX], V200_CUBE_ERROR_T0_IDX, GenPcMask32(0, 15),
        {MakePcFixEntry(RT_V200_CUBE_ERR_INFO_T0_1, GenPcMask64(0, 15), GenPcMask64(2, 17))});
    AddPcFixGroup(table[V200_CUBE_ERROR_T1_IDX], V200_CUBE_ERROR_T0_IDX, GenPcMask32(0, 9),
        {MakePcFixEntry(RT_V200_CUBE_ERR_INFO_T0_1, GenPcMask64(0, 15), GenPcMask64(2, 17))});
    AddPcFixGroup(table[V200_L1_ERROR_T0_IDX], V200_L1_ERROR_T0_IDX, GenPcMask32(0, 30),
        {MakePcFixEntry(RT_V200_L1_ERR_INFO_T0_1, GenPcMask64(0, 15), GenPcMask64(2, 17))});
    AddPcFixGroup(table[V200_L1_ERROR_T1_IDX], V200_L1_ERROR_T0_IDX, GenPcMask32(0, 21),
        {MakePcFixEntry(RT_V200_L1_ERR_INFO_T0_1, GenPcMask64(0, 15), GenPcMask64(2, 17))});
}

std::string BuildErrorRegistersStr(
    const char* const regNames[], size_t regNameNum, const uint32_t errReg[], size_t errRegLen)
{
    constexpr size_t REG_ITEM_BUF_LEN = 128U;
    std::string result;
    for (size_t i = 0; i < regNameNum && i < errRegLen; i++) {
        char item[REG_ITEM_BUF_LEN] = {0};
        int len = snprintf_s(item, sizeof(item), sizeof(item) - 1, "%s=0x%x ", regNames[i], errReg[i]);
        if (len < 0) {
            continue;
        }
        result += item;
    }
    return result;
}
} // namespace

// ===== CloudV2 PC 修正 =====

CloudV2PcFixer::CloudV2PcFixer()
{
    errStartIdx_ = static_cast<uint32_t>(RT_V100_AIC_ERR_0);
    errCount_ = V100_AIC_ERR_NUM;
    table_.resize(V100_AIC_ERR_NUM);

    for (uint32_t i = 0; i < V100_AIC_ERR_NUM; i++) {
        uint32_t moduleMasks[V100_MODULE_ID_NUM] = {0};
        BuildV100ModuleMasks(i, moduleMasks);
        AppendV100PcFixGroups(moduleMasks, table_[i]);
    }
}

std::string CloudV2PcFixer::GetErrorRegisters(const uint32_t errReg[], size_t errRegLen) const
{
    if (errReg == nullptr || errRegLen == 0) {
        return "";
    }
    constexpr size_t regNameNum = sizeof(V100_REG_NAMES) / sizeof(V100_REG_NAMES[0]);
    return BuildErrorRegistersStr(V100_REG_NAMES, regNameNum, errReg, errRegLen);
}

std::string CloudV2PcFixer::GetModuleName(uint32_t moduleId) const
{
    const char* const moduleNames[V100_MODULE_ID_NUM] = {"CUBE", "CCU", "IFU", "MTE", "VEC", "FIXP"};
    if (moduleId >= V100_MODULE_ID_NUM) {
        return "UNKNOWN";
    }
    return moduleNames[moduleId];
}

// ===== CloudV4 PC 修正 =====

CloudV4PcFixer::CloudV4PcFixer()
{
    errStartIdx_ = static_cast<uint32_t>(RT_V200_SC_ERROR_T0_0);
    errCount_ = V200_ERROR_IDX_NUM;
    table_.resize(errCount_);

    // SC_ERROR_T0_0 没有 PC 映射规则。
    table_[V200_SC_ERROR_T0_IDX] = {};
    InitV200CommonPcFixGroups(table_);
    InitV200VecPcFixGroups(table_);
    InitV200CubeAndL1PcFixGroups(table_);
}

std::string CloudV4PcFixer::GetErrorRegisters(const uint32_t errReg[], size_t errRegLen) const
{
    if (errReg == nullptr || errRegLen == 0) {
        return "";
    }
    constexpr size_t regNameNum = sizeof(V200_REG_NAMES) / sizeof(V200_REG_NAMES[0]);
    return BuildErrorRegistersStr(V200_REG_NAMES, regNameNum, errReg, errRegLen);
}

std::string CloudV4PcFixer::GetModuleName(uint32_t moduleId) const
{
    switch (moduleId) {
        case V200_SU_ERROR_T0_IDX:
            return "SU";
        case V200_MTE_ERROR_T0_IDX:
            return "MTE";
        case V200_VEC_ERROR_T0_IDX:
            return "VEC";
        case V200_CUBE_ERROR_T0_IDX:
            return "CUBE";
        case V200_L1_ERROR_T0_IDX:
            return "L1";
        default:
            return "UNKNOWN";
    }
}

std::unique_ptr<PcFixerInterface> PcFixerFactory::instance_;

PcFixerInterface* PcFixerFactory::GetInstance()
{
    std::lock_guard<std::mutex> lock(g_pcFixerMutex);
    if (!instance_) {
        auto *plat = CoredumpManager::Get();
        if (plat == nullptr) {
            IDE_LOGW("[Dump][Exception] Platform unavailable, PC fix skipped.");
            return nullptr;
        }
        instance_ = plat->CreatePcFixer();
        if (!instance_) {
            IDE_LOGW("[Dump][Exception] Unsupported platform for PC fix, PC fix skipped.");
            return nullptr;
        }
    }
    return instance_.get();
}

} // namespace Adx
