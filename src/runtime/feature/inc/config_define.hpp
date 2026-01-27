/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_CONFIG_DEFINE_HPP__
#define __CCE_RUNTIME_CONFIG_DEFINE_HPP__

#if defined(__cplusplus)
extern "C" {
#endif

constexpr uint32_t BANDWITH_KBS = 1024U;
constexpr uint32_t BANDWITH_MBS = 1024U * 1024U;

/* ----------------------------------------CLOUD_V1---------------------------------------- */
/* --------platform-------- */
#define PLATFORMCONFIG_CLOUD_V1           PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                       (static_cast<uint32_t>(CHIP_CLOUD)), \
                                                       (static_cast<uint32_t>(VER_NA)))

/* --------aiCoreInfo-------- */
constexpr uint32_t CUBEFREQ_CLOUD_V1 = 1000U;
constexpr uint32_t CUBEMSIZE_CLOUD_V1 = 16U;
constexpr uint32_t CUBEKSIZE_CLOUD_V1 = 16U;
constexpr uint32_t CUBENSIZE_CLOUD_V1 = 16U;
#define FRAC_MKN_FP16_CLOUD_V1            (RT_CUBE_MKN_FP16_16_16_16)
#define FRAC_MKN_INT8_CLOUD_V1            (RT_CUBE_MKN_INT8_16_32_16)
#define FRAC_VMUL_MKN_FP16_CLOUD_V1         (RT_VEC_VMUL_MKN_FP16_1_16_16)
#define FRAC_VMUL_MKN_INT8_CLOUD_V1        (RT_VEC_VMUL_MKN_INT8_1_32_16)
/* --------MemoryPara(/Bytes)-------- */
constexpr uint32_t L0ASIZE_CLOUD_V1 = (64U * BANDWITH_KBS);
constexpr uint32_t L0BSIZE_CLOUD_V1 = (64U * BANDWITH_KBS);
constexpr uint32_t L0CSIZE_CLOUD_V1 = (256U * BANDWITH_KBS);
constexpr uint32_t L1SIZE_CLOUD_V1 = (1024U * BANDWITH_KBS);
constexpr uint32_t L2SIZE_CLOUD_V1 = (64U * BANDWITH_MBS);
constexpr uint32_t L2PAGENUMBER_CLOUD_V1 = 64U;
constexpr uint32_t UBSIZE_CLOUD_V1 = (256U * BANDWITH_KBS);
constexpr uint32_t BLOCKSIZE_CLOUD_V1 = 32U;
constexpr uint32_t BANKSIZE_CLOUD_V1 = (4U * BANDWITH_KBS);
constexpr uint32_t BANKNUM_CLOUD_V1 = 64U;
constexpr uint32_t BANKGROUPNUM_CLOUD_V1 = 16U;
/* --------bandwith-------- */
constexpr uint32_t DDRBW_CLOUD_V1 = 40U;
constexpr uint32_t L2BW_CLOUD_V1 = 160U;
constexpr uint32_t L2READBW_CLOUD_V1 = 80U;
constexpr uint32_t L2WRITEBW_CLOUD_V1 = 80U;
constexpr uint32_t L1TOL0ABW_CLOUD_V1 = 512U;
constexpr uint32_t L1TOL0BBW_CLOUD_V1 = 256U;
constexpr uint32_t L0CTOUBBW_CLOUD_V1 = 256U;
constexpr uint32_t UBTOL2_CLOUD_V1 = 80U;
constexpr uint32_t UBTODDR_CLOUD_V1 = 40U;
constexpr uint32_t UBTOL1_CLOUD_V1 = 128U;
/* --------flowtable && compiler-------- */
constexpr uint32_t FLOWTABLESIZE_CLOUD_V1 = (8U * BANDWITH_KBS);
constexpr uint32_t COMPILERSIZE_CLOUD_V1 = (16U * BANDWITH_KBS);

/* ---------------------------------------DC---------------------------------------- */
/* --------platform-------- */
#define PLATFORMCONFIG_DC               PLAT_COMBINE((static_cast<uint32_t>(ARCH_M200)), \
                                                    (static_cast<uint32_t>(CHIP_DC)), \
                                                    (static_cast<uint32_t>(VER_NA)))
/* --------old platform-------- */
#define PLATFORMCONFIG_DC_OLD           PLAT_COMBINE((static_cast<uint32_t>(ARCH_V200)), \
                                                    (static_cast<uint32_t>(CHIP_DC)), \
                                                    (static_cast<uint32_t>(VER_NA)))

/* --------aiCoreInfo-------- */
constexpr uint32_t CUBEFREQ_DC = 900U;
constexpr uint32_t CUBEMSIZE_DC = 16U;
constexpr uint32_t CUBEKSIZE_DC = 16U;
constexpr uint32_t CUBENSIZE_DC = 16U;
#define FRAC_MKN_FP16_DC            (RT_CUBE_MKN_FP16_16_16_16)
#define FRAC_MKN_INT8_DC            (RT_CUBE_MKN_INT8_16_32_16)
#define FRAC_VMUL_MKN_FP16_DC         (RT_VEC_VMUL_MKN_FP16_1_16_16)
#define FRAC_VMUL_MKN_INT8_DC        (RT_VEC_VMUL_MKN_INT8_1_32_16)
/* --------MemoryPara(/Bytes)-------- */
constexpr uint32_t L0ASIZE_DC = (64U * BANDWITH_KBS);
constexpr uint32_t L0BSIZE_DC = (64U * BANDWITH_KBS);
constexpr uint32_t L0CSIZE_DC = (256U * BANDWITH_KBS);
constexpr uint32_t L1SIZE_DC = (1024U * BANDWITH_KBS);
constexpr uint32_t L2SIZE_DC = (8U * BANDWITH_MBS);
constexpr uint32_t L2PAGENUMBER_DC = 64U;
constexpr uint32_t UBSIZE_DC = (256U * BANDWITH_KBS);
constexpr uint32_t BLOCKSIZE_DC = 32U;
constexpr uint32_t BANKSIZE_DC = (4U * BANDWITH_KBS);
constexpr uint32_t BANKNUM_DC = 64U;
constexpr uint32_t BANKGROUPNUM_DC = 16U;
/* --------bandwith-------- */
constexpr uint32_t DDRBW_DC = 20U;
constexpr uint32_t L2BW_DC = 144U;
constexpr uint32_t L2READBW_DC = 96U;
constexpr uint32_t L2WRITEBW_DC = 48U;
constexpr uint32_t L1TOL0ABW_DC = 512U;
constexpr uint32_t L1TOL0BBW_DC = 256U;
constexpr uint32_t L0CTOUBBW_DC = 128U;
constexpr uint32_t UBTOL2_DC = 128U;
constexpr uint32_t UBTODDR_DC = 20U;
constexpr uint32_t UBTOL1_DC = 512U;
/* --------flowtable && compiler-------- */
constexpr uint32_t FLOWTABLESIZE_DC = (8U * BANDWITH_KBS);
constexpr uint32_t COMPILERSIZE_DC = (16U * BANDWITH_KBS);

/* ----------------------------------------CLOUD_V2---------------------------------------- */
/* --------platform---Asend910B4----- */
#define PLATFORMCONFIG_CLOUD_V2             PLAT_COMBINE((static_cast<uint32_t>(ARCH_C220)), \
                                                       (static_cast<uint32_t>(CHIP_910_B_93)), \
                                                       (static_cast<uint32_t>(RT_VER_NA)))
/* --------old platform---Asend910B4----- */
#define PLATFORMCONFIG_CLOUD_V2_OLD         PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                       (static_cast<uint32_t>(CHIP_910_B_93)), \
                                                       (static_cast<uint32_t>(RT_VER_NA)))

/* --------aiCoreInfo-------- */
constexpr uint32_t CUBEFREQ_CLOUD_V2 = 1000U;
constexpr uint32_t CUBEMSIZE_CLOUD_V2 = 16U;
constexpr uint32_t CUBEKSIZE_CLOUD_V2 = 16U;
constexpr uint32_t CUBENSIZE_CLOUD_V2 = 16U;
#define FRAC_MKN_FP16_CLOUD_V2            (RT_CUBE_MKN_FP16_16_16_16)
#define FRAC_MKN_INT8_CLOUD_V2            (RT_CUBE_MKN_INT8_16_32_16)
#define FRAC_VMUL_MKN_FP16_CLOUD_V2         (RT_VEC_VMUL_MKN_FP16_1_16_16)
#define FRAC_VMUL_MKN_INT8_CLOUD_V2        (RT_VEC_VMUL_MKN_INT8_1_32_16)
/* --------MemoryPara(/Bytes)-------- */
constexpr uint32_t L0ASIZE_CLOUD_V2 = (64U * BANDWITH_KBS);
constexpr uint32_t L0BSIZE_CLOUD_V2 = (64U * BANDWITH_KBS);
constexpr uint32_t L0CSIZE_CLOUD_V2 = (256U * BANDWITH_KBS);
constexpr uint32_t L1SIZE_CLOUD_V2 = (1024U * BANDWITH_KBS);
constexpr uint32_t L2SIZE_CLOUD_V2 = (96U * BANDWITH_MBS);
constexpr uint32_t L2PAGENUMBER_CLOUD_V2 = 64U;
constexpr uint32_t UBSIZE_CLOUD_V2 = (256U * BANDWITH_KBS);
constexpr uint32_t BLOCKSIZE_CLOUD_V2 = 32U;
constexpr uint32_t BANKSIZE_CLOUD_V2 = (4U * BANDWITH_KBS);
constexpr uint32_t BANKNUM_CLOUD_V2 = 64U;
constexpr uint32_t BANKGROUPNUM_CLOUD_V2 = 16U;
/* --------bandwith-------- */
constexpr uint32_t DDRBW_CLOUD_V2 = 40U;
constexpr uint32_t L2BW_CLOUD_V2 = 160U;
constexpr uint32_t L2READBW_CLOUD_V2 = 80U;
constexpr uint32_t L2WRITEBW_CLOUD_V2 = 80U;
constexpr uint32_t L1TOL0ABW_CLOUD_V2 = 512U;
constexpr uint32_t L1TOL0BBW_CLOUD_V2 = 256U;
constexpr uint32_t L0CTOUBBW_CLOUD_V2 = 256U;
constexpr uint32_t UBTOL2_CLOUD_V2 = 80U;
constexpr uint32_t UBTODDR_CLOUD_V2 = 40U;
constexpr uint32_t UBTOL1_CLOUD_V2 = 128U;
/* --------flowtable && compiler-------- */
constexpr uint32_t FLOWTABLESIZE_CLOUD_V2 = (8U * BANDWITH_KBS);
constexpr uint32_t COMPILERSIZE_CLOUD_V2 = (16U * BANDWITH_KBS);

/* ----------------------------------------CLOUD_V2_910B---------------------------------------- */
/* --------platform-------- */
#define PLATFORMCONFIG_CLOUD_V2_910B1           PLAT_COMBINE((static_cast<uint32_t>(ARCH_C220)), \
                                                       (static_cast<uint32_t>(CHIP_910_B_93)), \
                                                       (static_cast<uint32_t>(RT_VER_BIN1)))

#define PLATFORMCONFIG_CLOUD_V2_910B2           PLAT_COMBINE((static_cast<uint32_t>(ARCH_C220)), \
                                                       (static_cast<uint32_t>(CHIP_910_B_93)), \
                                                       (static_cast<uint32_t>(RT_VER_BIN2)))

#define PLATFORMCONFIG_CLOUD_V2_910B3           PLAT_COMBINE((static_cast<uint32_t>(ARCH_C220)), \
                                                       (static_cast<uint32_t>(CHIP_910_B_93)), \
                                                       (static_cast<uint32_t>(RT_VER_BIN3)))

#define PLATFORMCONFIG_CLOUD_V2_910B4_1           PLAT_COMBINE((static_cast<uint32_t>(ARCH_C220)), \
                                                       (static_cast<uint32_t>(CHIP_910_B_93)), \
                                                       (static_cast<uint32_t>(RT_VER_BIN10)))

/* --------old platform-------- */
#define PLATFORMCONFIG_CLOUD_V2_910B1_OLD       PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                       (static_cast<uint32_t>(CHIP_910_B_93)), \
                                                       (static_cast<uint32_t>(RT_VER_BIN1)))

#define PLATFORMCONFIG_CLOUD_V2_910B2_OLD       PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                       (static_cast<uint32_t>(CHIP_910_B_93)), \
                                                       (static_cast<uint32_t>(RT_VER_BIN2)))

#define PLATFORMCONFIG_CLOUD_V2_910B3_OLD       PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                       (static_cast<uint32_t>(CHIP_910_B_93)), \
                                                       (static_cast<uint32_t>(RT_VER_BIN3)))

#define PLATFORMCONFIG_CLOUD_V2_910B4_1_OLD       PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_910_B_93)), \
                                                    (static_cast<uint32_t>(RT_VER_BIN10)))

/* ----------------------------------------CLOUD_V2_910B2C---------------------------------------- */
/* --------platform-------- */
#define PLATFORMCONFIG_CLOUD_V2_910B2C           PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                       (static_cast<uint32_t>(CHIP_910_B_93)), \
                                                       (static_cast<uint32_t>(RT_VER_BIN8)))

/* --------aiCoreInfo-------- */
constexpr uint32_t CUBEFREQ_910B = 1000U;
constexpr uint32_t CUBEMSIZE_910B = 16U;
constexpr uint32_t CUBEKSIZE_910B = 16U;
constexpr uint32_t CUBENSIZE_910B = 16U;
#define FRAC_MKN_FP16_910B            (RT_CUBE_MKN_FP16_16_16_16)
#define FRAC_MKN_INT8_910B            (RT_CUBE_MKN_INT8_16_32_16)
#define FRAC_VMUL_MKN_FP16_910B         (RT_VEC_VMUL_MKN_FP16_1_16_16)
#define FRAC_VMUL_MKN_INT8_910B        (RT_VEC_VMUL_MKN_INT8_1_32_16)
/* --------MemoryPara(/Bytes)-------- */
constexpr uint32_t L0ASIZE_910B = (64U * BANDWITH_KBS);
constexpr uint32_t L0BSIZE_910B = (64U * BANDWITH_KBS);
constexpr uint32_t L0CSIZE_910B = (256U * BANDWITH_KBS);
constexpr uint32_t L1SIZE_910B = (1024U * BANDWITH_KBS);
constexpr uint32_t L2SIZE_910B = (192U * BANDWITH_MBS);
constexpr uint32_t L2SIZE_910B4_1 = (168U * BANDWITH_MBS);
constexpr uint32_t L2PAGENUMBER_910B = 64U;
constexpr uint32_t UBSIZE_910B = (256U * BANDWITH_KBS);
constexpr uint32_t BLOCKSIZE_910B = 32U;
constexpr uint32_t BANKSIZE_910B = (4U * BANDWITH_KBS);
constexpr uint32_t BANKNUM_910B = 64U;
constexpr uint32_t BANKGROUPNUM_910B = 16U;
/* --------bandwith-------- */
constexpr uint32_t DDRBW_910B = 40U;
constexpr uint32_t L2BW_910B = 160U;
constexpr uint32_t L2READBW_910B = 80U;
constexpr uint32_t L2WRITEBW_910B = 80U;
constexpr uint32_t L1TOL0ABW_910B = 512U;
constexpr uint32_t L1TOL0BBW_910B = 256U;
constexpr uint32_t L0CTOUBBW_910B = 256U;
constexpr uint32_t UBTOL2_910B = 80U;
constexpr uint32_t UBTODDR_910B = 40U;
constexpr uint32_t UBTOL1_910B = 128U;
/* --------flowtable && compiler-------- */
constexpr uint32_t FLOWTABLESIZE_910B = (8U * BANDWITH_KBS);
constexpr uint32_t COMPILERSIZE_910B = (16U * BANDWITH_KBS);

/* ----------------------------------------DAVID_910_95---------------------------------------- */
/* --------platform-------- */
#define PLATFORMCONFIG_DAVID_910_9599        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN0)))

#define PLATFORMCONFIG_DAVID_910_9589        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN1)))

#define PLATFORMCONFIG_DAVID_910_958A        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN2)))

#define PLATFORMCONFIG_DAVID_910_958B        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN3)))

#define PLATFORMCONFIG_DAVID_910_957B        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN4)))

#define PLATFORMCONFIG_DAVID_910_957D        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN5)))

#define PLATFORMCONFIG_DAVID_910_950Z        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN6)))

#define PLATFORMCONFIG_DAVID_910_9579        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN7)))

#define PLATFORMCONFIG_ASCEND_910_5591           PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                       (static_cast<uint32_t>(CHIP_CLOUD_V5)), \
                                                       (static_cast<uint32_t>(VER_NA)))

#define PLATFORMCONFIG_DAVID_910_9591        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN11)))

#define PLATFORMCONFIG_DAVID_910_9592        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN12)))

#define PLATFORMCONFIG_DAVID_910_9581        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN13)))

#define PLATFORMCONFIG_DAVID_910_9582        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN14)))

#define PLATFORMCONFIG_DAVID_910_9584        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN15)))

#define PLATFORMCONFIG_DAVID_910_9587        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN16)))

#define PLATFORMCONFIG_DAVID_910_9588        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN17)))

#define PLATFORMCONFIG_DAVID_910_9572        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN18)))

#define PLATFORMCONFIG_DAVID_910_9575        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN19)))

#define PLATFORMCONFIG_DAVID_910_9576        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN20)))

#define PLATFORMCONFIG_DAVID_910_9574        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN21)))

#define PLATFORMCONFIG_DAVID_910_9577        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN22)))

#define PLATFORMCONFIG_DAVID_910_9578        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN23)))

#define PLATFORMCONFIG_DAVID_910_957C        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN24)))

#define PLATFORMCONFIG_DAVID_910_95A1        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN25)))
 
#define PLATFORMCONFIG_DAVID_910_95A2        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN26)))
 
#define PLATFORMCONFIG_DAVID_910_9595        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN27)))
 
#define PLATFORMCONFIG_DAVID_910_9596        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN28)))
 
#define PLATFORMCONFIG_DAVID_910_9585        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN29)))
 
#define PLATFORMCONFIG_DAVID_910_9586        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN30)))
 
#define PLATFORMCONFIG_DAVID_910_9583        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN31)))
 
#define PLATFORMCONFIG_DAVID_910_9571        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN32)))
 
#define PLATFORMCONFIG_DAVID_910_9573        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN33)))

#define PLATFORMCONFIG_DAVID_910_950X        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
 	                                                     (static_cast<uint32_t>(CHIP_DAVID)), \
 	                                                     (static_cast<uint32_t>(PG_VER_BIN34)))
 	 
#define PLATFORMCONFIG_DAVID_910_950Y        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
 	                                                     (static_cast<uint32_t>(CHIP_DAVID)), \
 	                                                     (static_cast<uint32_t>(PG_VER_BIN35)))
/* --------aiCoreInfo-------- */
constexpr uint32_t CUBEFREQ_DAVID_910_95 = 1650U;
constexpr uint32_t CUBEMSIZE_DAVID_910_95 = 16U;
constexpr uint32_t CUBEKSIZE_DAVID_910_95 = 16U;
constexpr uint32_t CUBENSIZE_DAVID_910_95 = 16U;
 
#define FRAC_MKN_FP16_DAVID_910_95            (RT_CUBE_MKN_FP16_16_16_16)
#define FRAC_MKN_INT8_DAVID_910_95            (RT_CUBE_MKN_INT8_16_32_16)
#define FRAC_VMUL_MKN_FP16_DAVID_910_95       (RT_VEC_VMUL_MKN_FP16_1_16_16)
#define FRAC_VMUL_MKN_INT8_DAVID_910_95       (RT_VEC_VMUL_MKN_INT8_1_32_16)
/* --------MemoryPara(/Bytes)-------- */
constexpr uint32_t L0ASIZE_DAVID_910_95 = (64U * BANDWITH_KBS);
constexpr uint32_t L0BSIZE_DAVID_910_95 = (64U * BANDWITH_KBS);
constexpr uint32_t L0CSIZE_DAVID_910_95 = (256U * BANDWITH_KBS);
constexpr uint32_t L1SIZE_DAVID_910_95 = (512U * BANDWITH_KBS);
constexpr uint32_t L2SIZE_DAVID_910_95 = (128U * BANDWITH_MBS);
constexpr uint32_t L1SIZE_DAVID_910_950Z = (16U * BANDWITH_MBS);
constexpr uint32_t L1SIZE_DAVID_910_957D = (96U * BANDWITH_MBS);
constexpr uint32_t L1SIZE_DAVID_910_958B = (112U * BANDWITH_MBS);
constexpr uint32_t L2SIZE_DAVID_910_950X = (32U * BANDWITH_MBS);
constexpr uint32_t L2PAGENUMBER_DAVID_910_95 = 64U;
constexpr uint32_t UBSIZE_DAVID_910_95 = (248U * BANDWITH_KBS);
constexpr uint32_t BLOCKSIZE_DAVID_910_95 = 32U;
constexpr uint32_t BANKSIZE_DAVID_910_95 = (4U * BANDWITH_KBS);
constexpr uint32_t BANKNUM_DAVID_910_95 = 16U;
constexpr uint32_t BANKGROUPNUM_DAVID_910_95 = 8U;
/* --------bandwith-------- */
constexpr uint32_t DDRBW_DAVID_910_95 = 31U;
constexpr uint32_t L2BW_DAVID_910_95 = 100U;
constexpr uint32_t L2READBW_DAVID_910_95 = 100U;
constexpr uint32_t L2WRITEBW_DAVID_910_95 = 100U;
constexpr uint32_t L1TOL0ABW_DAVID_910_95 = 256U;
constexpr uint32_t L1TOL0BBW_DAVID_910_95 = 256U;
constexpr uint32_t L0CTOUBBW_DAVID_910_95 = 128U;
constexpr uint32_t UBTOL2_DAVID_910_95 = 128U;
constexpr uint32_t UBTODDR_DAVID_910_95 = 128U;
constexpr uint32_t UBTOL1_DAVID_910_95 = 128U;
/* --------flowtable && compiler-------- */
constexpr uint32_t FLOWTABLESIZE_DAVID_910_95 = (8U * BANDWITH_KBS);
constexpr uint32_t COMPILERSIZE_DAVID_910_95 = (16U * BANDWITH_KBS);

#if defined(__cplusplus)
}
#endif
#endif  // __CCE_RUNTIME_CONFIG_DEFINE_HPP__
