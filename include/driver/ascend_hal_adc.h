/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ASCEND_HAL_ADC_H
#define ASCEND_HAL_ADC_H

#include "ascend_hal_base.h"
#include "ascend_hal_define.h"
#include "ascend_hal_external.h"

#ifdef __cplusplus
extern "C" {
#endif

/**
* @ingroup driver
* @brief Get series of information from the specified Mbuf
* @attention null
* @param [in] Mbuf *mbuf: Mbuf addr
* @param [out] MbufInfoConverge *mbufInfo: mbuf information
* @return   0 for success, others for fail
*/
DLLEXPORT int halMbufGetMbufInfo(Mbuf *mbuf, MbufInfoConverge *mbufInfo);

#define HDC_ADC_RC_DEVID (1)
#define HDC_ADC_EP_DEVID (0)

/**
* @ingroup driver
* @brief Wake up client connect wait
* @attention null
* @param [in]  client : HDC Client handle
* @return   DRV_ERROR_NONE, DRV_ERROR_INVALID_VALUE
*/
DLLEXPORT hdcError_t halHdcClientWakeUp(HDC_CLIENT client);
/**
* @ingroup driver
* @brief Wake up accept wait
* @attention null
* @param [in]  server : HDC server handle
* @return   DRV_ERROR_NONE, DRV_ERROR_INVALID_VALUE
*/
DLLEXPORT hdcError_t halHdcServerWakeUp(HDC_SERVER server);
/**
* @ingroup driver
* @brief register va
* @attention null
* @param [in]  signed int devid               dev id
* @param [in]  enum drvHdcMemType mem_type    内存type
* @param [in]  void *va                       内存虚拟地址 (来源为mbuf, 需要支持sp_walk_page_range可翻译)
* @param [in]  unsigned int len               内存的长度 len size 需要满足 4k/2M 对齐
* @param [in]  unsigned int flag              原有flag标志, 保留字段, 传0
* @return   DRV_ERROR_NONE, DRV_ERROR_INVALID_VALUE
*/
DLLEXPORT hdcError_t halHdcRegisterMem(signed int devid, enum drvHdcMemType mem_type,
                                       void *va, unsigned int len, unsigned int flag);
/**
* @ingroup driver
* @brief unregister va
* @attention null
* @param [in]  mem_type memory type
* @param [in]  va pointer of memory
* @return   DRV_ERROR_NONE, DRV_ERROR_INVALID_VALUE
*/
DLLEXPORT hdcError_t halHdcUnregisterMem(enum drvHdcMemType mem_type, void *va);
/**
* @ingroup driver
* @brief get hdc config
* @attention null
* @param [out]  transType socket or pcie
* @return   DRV_ERROR_NONE, DRV_ERROR_INVALID_VALUE
*/
hdcError_t halHdcGetTransType(enum halHdcTransType *transType);
/**
* @ingroup driver
* @brief set hdc trans type
* @attention null
* @param [in]  transType  [HDC_TRANS_USE_SOCKET=0, HDC_TRANS_USE_PCIE=1]
* @return   DRV_ERROR_NONE, DRV_ERROR_INVALID_VALUE
*/
hdcError_t halHdcSetTransType(enum halHdcTransType transType);
/**
* @ingroup driver
* @brief wait mem finish release va
* @attention null
* @param [in]  session
* @param [in]  time_out
* @param [out] msg
* @return   DRV_ERROR_NONE, DRV_ERROR_INVALID_VALUE
*/
hdcError_t halHdcWaitMemRelease(HDC_SESSION session, int time_out, struct drvHdcFastRecvMsg *msg);
/**
* @ingroup driver
* @brief wait mem finish release va
* @attention null
* @param [in]  session
* @param [in]  input
* @param [out] msg
* @return   DRV_ERROR_NONE, DRV_ERROR_INVALID_VALUE
*/
hdcError_t halHdcWaitMemReleaseEx(HDC_SESSION session,
    struct drvHdcWaitMsgInput *input, struct drvHdcFastSendFinishMsg *msg);

/*=========================== Hac Manage ===========================*/
struct lidar_encoder_matrix {
    unsigned int pred_mode;   /* 14种预测模式mask, bit0~13每个bit表示一种预测模式是否使能, 0表示不使能, 1表示使能 */
    unsigned int cross_pred;    /* 跨模态预测时的掩模值 */
    unsigned int frame_num;   /* 帧数 */
    unsigned int head_height;             /* 首帧高度，减一配置，配置范围为0~1023 */
    unsigned int head_width;              /* 首帧宽度，减一配置，配置范围为0~1023 */
    unsigned int mid_height;              /* 中间帧高度，减一配置，配置范围为0~1023 */
    unsigned int mid_width;               /* 中间帧宽度，减一配置，配置范围为0~1023 */
    unsigned int tail_height;             /* 尾帧高度，减一配置，配置范围为0~1023 */
    unsigned int tail_width;              /* 尾帧宽度，减一配置，配置范围为0~1023 */
    void *head_src_addr;    /* 源数据第一个矩阵的起始地址，要求128B对齐 */
    unsigned long long head_src_stride;   /* 源数据首帧数据步长，要求128B对齐 */
    unsigned long long mid_src_stride;    /* 源数据中间帧数据步长，要求128B对齐 */
    unsigned long long src_len;    /* 源数据长度，单位byte */
    void *head_dst_addr;    /* 输出数据回写起始地址，要求128B对齐 */
    unsigned long long head_dst_stride;   /* 输出数据首帧数据步长，要求128B对齐 */
    unsigned long long mid_dst_stride;    /* 输出数据中间帧数据步长，要求128B对齐 */
    unsigned long long dst_len;
    void *head_mode_addr;   /* 输出最佳预测模式回写起始地址，要求128B对齐 */
    unsigned long long head_mode_stride;  /* 输出最佳预测模式首帧数据步长，要求128B对齐 */
    unsigned long long mid_mode_stride;   /* 输出最佳预测模式中间帧数据步长，要求128B对齐 */
    unsigned long long mod_len;
};
 
struct lidar_encoder_config {
    unsigned int spatial_pred_bias;   /* 计算curDiff时的偏移值信号 */
    unsigned int exp_value;           /* 空间预测代价函数中衰减权重 */
    unsigned int significant_symbols; /* 空间预测代价函数中参与计算的直方图高/低统计项 */
    int cost_weight;                  /* 计算代价函数时空间代价的权重。配置范围[-256,256] */
    unsigned int exp_decay_factor;    /* 空间预测代价函数中衰减因子 */
    unsigned int range_y;             /* 联合香农熵函数中Hist_acc直方图参与计算的统计项 */
    unsigned int acc_refresh_num;     /* 控制累加直方图清空频率的信号 */
    unsigned int timeout;   /* 加速器单次计算任务超时时间 */
};
 
/**
 * @ingroup driver
 * @brief init for lidar dp
 * @return   0   success
 * @return   other  fail
 */
DLLEXPORT drvError_t halLidarDpInit(void);
 
/**
 * @ingroup driver
 * @brief uninit for lidar dp
 * @return   0   success
 * @return   other  fail
 */
DLLEXPORT drvError_t halLidarDpUninit(void);
 
/**
 * @ingroup driver
 * @brief set encode cfg for lidar dp
 * @param [in] encoder_config_info   config for lidar dp
 * @return   0   success
 * @return   other  fail
 */
DLLEXPORT drvError_t halLidarDpSetEncoderCfg(struct lidar_encoder_config *encoder_config_info);
 
/**
 * @ingroup driver
 * @brief get encode cfg for lidar dp
 * @param [out] encoder_config_info    config for lidar dp
 * @return   0   success
 * @return   other  fail
 */
DLLEXPORT drvError_t halLidarDpGetEncoderCfg(struct lidar_encoder_config *encoder_config_info);
 
/**
 * @ingroup driver
 * @brief task delivery and execution
 * @param [in] timeout   timeout
 * @param [inout] encoder_matrix_info   matrix info
 * @param [out] encoder_result   0 success  other fail
 * @return   0   success
 * @return   other  fail
 */
DLLEXPORT drvError_t halLidarDpEncode(struct lidar_encoder_matrix *encoder_matrix_info, unsigned int timeout, unsigned int *encoder_result);
  
struct adspc_solve_info {
    unsigned char solve_type;          /* 0:SolveArrowHead, 1:AX=B */
    unsigned char send_to_peer;        /* 发送到对端标志.0:不发送; 1:跨片使用求解器时，最后一帧求解结果通过stars串接发送到对片 */
    unsigned char irq_mode;            /* 结果查询方式：0：产品周期轮询（不使能中断）；1：阻塞式查询（使能中断） */
    unsigned char resv1;            /* reserve */
    unsigned char task_id;             /* 任务ID，配置范围0~255 */
    unsigned char matrix_order;        /* 矩阵阶数，配置范围16、24、32、48、64、96、128、160 */
    unsigned char problem_number;      /* 求解的问题数，配置范围1~6 */
    unsigned char car_number;          /* 每个求解问题中他车数量，SolveArrowHead命令配置范围1~5；AX=B命令不使用该域段，配置为0 */
    unsigned int  problem_stride;       /* 问题间的地址步长，要求128B对齐 */
    void         *src_data;       /* 源数据第一个矩阵的起始地址，要求128B对齐 */
    unsigned int  src_stride;           /* 每个矩阵之间的地址步长，要求128B对齐 */
    void         *result_buff;    /* 结果数据第一个矩阵的起始地址，要求128B对齐。 */
    unsigned int  result_stride;        /* 计算结果的地址步长，要求128B对齐 */
    unsigned int  result_len;           /* 存放结果数据的内存空间长度 */
    unsigned int  resv2[4];
};
 
struct adspc_solve_result {
    unsigned char  solve_status;        /* 求解任务完成状态:0 正常完成；其他 表示出现异常(包括ECC硬件异常、数据异常、强行终止) */
    unsigned char  task_id;             /* 任务ID，配置范围0~255 */
    unsigned char  resv1[2];            /* reserve */
    void          *result_data;    /* 结果数据第一个矩阵的起始地址 */
    unsigned int   problem_stride;       /* 问题间的地址步长，要求128B对齐 */
    unsigned int   result_stride;        /* 计算结果的地址步长，要求128B对齐 */
    unsigned int   resv2[4];
};
 
struct adspc_cq_param{
    unsigned char cqe_size;             /*QP cqe大小*/
    unsigned char cq_depth;             /*QP cq队列深度*/
    char resv[2];
    void *cqe_base_addr;   /*cq buff基地址*/
    void *cq_head_addr;   /*将CQE拷贝目的地址，位于mbuf,由调用者根据mbuf data基地址和block_id计算得到*/
    void *cq_tail_addr; /*QP cq tail寄存器地址*/
    int resv2[4]; /*QP CQ tail寄存器地址*/
};
  
/**
 * @ingroup driver
 * @brief init for adspc
 * @param [in] mode   mode
 * @return   0   success
 * @return   other  fail
 */
DLLEXPORT drvError_t halAdspcInit(unsigned int mode);
 
/**
 * @ingroup driver
 * @brief uninit for adspc
 * @return   0   success
 * @return   other  fail
 */
DLLEXPORT drvError_t halAdspcUninit(void);
 
/**
 * @ingroup driver
 * @brief set notify id for adspc
 * @param [in] notify_id  notify_id for stars
 * @return   0   success
 * @return   other  fail
 */
DLLEXPORT drvError_t halAdspcSetNotifyid(unsigned int notify_id);
 
/**
 * @ingroup driver
 * @brief Solve Adspc problem
 * @param [in] solve_data   problem info
 * @return   0   success
 * @return   other  fail
 */
DLLEXPORT drvError_t halAdspcDeliverSolve(const struct adspc_solve_info *solve_data);
 
/**
 * @ingroup driver
 * @brief Get Adspc problem result
 * @param [in] timeout   timeout, 0 for non-blocking, -1 for blocking, other for specific timeout
 * @param [out] result   problem result
 * @return   0   success
 * @return   other  fail
 */
DLLEXPORT drvError_t halAdspcGetSolveResult(struct adspc_solve_result *result, int timeout);
 
/**
 * @ingroup driver
 * @brief Start Stl test
 * @return   0   success
 * @return   other  fail
 */
DLLEXPORT drvError_t halAdspcStartStl(void);
 
/**
 * @ingroup driver
 * @brief reset adspc
 * @return   0   success
 * @return   other  fail
 */
DLLEXPORT drvError_t halAdspcReset(void);
 
/**
 * @ingroup driver
 * @brief Get stl test result
 * @param [out] result   last stl test result
 * @return   0   success
 * @return   other  fail
 */
DLLEXPORT drvError_t halAdspcGetStlResult(unsigned int *result);
 
/**
 * @ingroup driver
 * @brief Get Cq Param for adspc
 * @param [out] cq_param   
 * @return   0   success
 * @return   other  fail
 */
DLLEXPORT drvError_t halAdspcGetCqParam(struct adspc_cq_param *cq_param);

/**
 * @ingroup driver
 * @brief uadk crypto param
 */
typedef enum {
    CRYPTO_CIPHER_SM4_CBC = 0,     /* SM4_CBC */
    CRYPTO_CIPHER_AES_128_CBC,     /* AES_128_CBC */
    CRYPTO_CIPHER_AES_256_CBC,     /* AES_256_CBC */
    CRYPTO_AEAD_AES_128_GCM = 10,  /* AES_128_GCM */
    CRYPTO_AEAD_AES_256_GCM,       /* AES_256_GCM */
    CIPHER_ALG_BUTT,
} uadk_crypto_algorithm;

typedef struct {
    uadk_crypto_algorithm alg;
    int rsv[4];  /**< rsv[0]: task mode, 0:block mode, 1:stream mode;
                      rsv[1]: wait result mode, 0:loop query, 1:intrrupt nofity; */
} uadk_crypto_param;

/**
 * @ingroup driver
 * @brief uadk key handle
 */
typedef struct {
    int len;
    unsigned char *buff;
} uadk_key_handle;

typedef struct uadk_mem_info {
    unsigned char *src;
    unsigned int src_len;
    unsigned char *dst;
    unsigned int dst_len;
    unsigned char *auth;
    unsigned int auth_len;
    unsigned char *key;
    unsigned int key_len;
    unsigned char *aiv;
    unsigned int aiv_len;
} uadk_mem_info;

/**
* @ingroup driver
* @brief send IPC msg to safetyIsland
* @attention null
* @param [in]   devId  Device ID
*               msg : message contents
                msgSize : message size
* @return   0 for success, others for fail
*/
DLLEXPORT drvError_t halSafeIslandTimeSyncMsgSend(uint32_t devId, void *msg, size_t msgSize);

/**
 * @ingroup driver
 * @brief uadk crypto init
 * @attention only support ciphertext key, don't support plaintext key
 * @param [out] ctx   crypto context
 * @param [in] param    crypto parameter, including crypto algorithm
 * @param [in] enc  0:encrypt,1:decrypt
 * @return   0   success
 * @return   other  fail
 */
DLLEXPORT int uadk_crypto_init(void **ctx, uadk_crypto_param *param, int enc);

/**
 * @ingroup driver
 * @brief alloc mem for ctx.
 * @param [in] ctx   crypto context
 * @param [inout] mem_info    alloc parameter
 * @return   0   success
 * @return   other  fail
 */
DLLEXPORT int uadk_crypto_alloc (void *ctx_, uadk_mem_info *mem_info);

/**
 * @ingroup driver
 * @brief update ctx information
 * @param [in] ctx   crypto context
 * @param [in] src_len    srouce length
 * @param [out] dst_len    destination length
 * @return   0   success
 * @return   other  fail
 */
DLLEXPORT int uadk_crypto_update(void *ctx_, size_t src_len, size_t *dst_len);

/**
 * @ingroup driver
 * @brief free ctx.
 * @param [in] ctx   crypto context
 * @return   0   success
 * @return   other  fail
 */
DLLEXPORT void uadk_crypto_free (void *ctx_);

/**
 * @ingroup driver
 * @brief uadk crypto uninit
 * @param [in] ctx   crypto context
 * @return   0   success
 * @return   other  fail
 */
DLLEXPORT void uadk_crypto_ctx_deinit(void *ctx);

#ifdef __cplusplus
}
#endif
#endif