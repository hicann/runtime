# aclrtGetErrorVerbose<a name="ZH-CN_TOPIC_0000002483528349"></a>

**须知：本接口为预留接口，暂不支持。**

## 功能说明<a name="section93499471063"></a>

用于在发生设备故障后获取详细错误信息。此接口必须在获取故障事件之后，提交任务中止之前调用。

## 函数原型<a name="section14885205814615"></a>

```
aclError aclrtGetErrorVerbose(int32_t deviceId, aclrtErrorInfo *errorInfo);
```

## 参数说明<a name="section31916522610"></a>

<a name="zh-cn_topic_0122830089_table438764393513"></a>
<table><thead align="left"><tr id="zh-cn_topic_0122830089_row53871743113510"><th class="cellrowborder" valign="top" width="18%" id="mcps1.1.4.1.1"><p id="zh-cn_topic_0122830089_p1438834363520"><a name="zh-cn_topic_0122830089_p1438834363520"></a><a name="zh-cn_topic_0122830089_p1438834363520"></a>参数名</p>
</th>
<th class="cellrowborder" valign="top" width="14.000000000000002%" id="mcps1.1.4.1.2"><p id="p1769255516412"><a name="p1769255516412"></a><a name="p1769255516412"></a>输入/输出</p>
</th>
<th class="cellrowborder" valign="top" width="68%" id="mcps1.1.4.1.3"><p id="zh-cn_topic_0122830089_p173881843143514"><a name="zh-cn_topic_0122830089_p173881843143514"></a><a name="zh-cn_topic_0122830089_p173881843143514"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="zh-cn_topic_0122830089_row2038874343514"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p1311921153314"><a name="p1311921153314"></a><a name="p1311921153314"></a>deviceId</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p103172113317"><a name="p103172113317"></a><a name="p103172113317"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="zh-cn_topic_0122830089_p19388143103518"><a name="zh-cn_topic_0122830089_p19388143103518"></a><a name="zh-cn_topic_0122830089_p19388143103518"></a>Device ID。</p>
<p id="p5103103751315"><a name="p5103103751315"></a><a name="p5103103751315"></a>与<a href="aclrtSetDevice.md">aclrtSetDevice</a>接口中Device ID保持一致。</p>
</td>
</tr>
<tr id="row071703213618"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p1571713324360"><a name="p1571713324360"></a><a name="p1571713324360"></a>errorInfo</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p197176329369"><a name="p197176329369"></a><a name="p197176329369"></a>输出</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p06778211106"><a name="p06778211106"></a><a name="p06778211106"></a>错误信息。</p>
<pre class="screen" id="screen17241111191211"><a name="screen17241111191211"></a><a name="screen17241111191211"></a>typedef enum { 
    ACL_RT_NO_ERROR = 0,       // 无错误
    ACL_RT_ERROR_MEMORY = 1,   // 内存错误，暂不支持
    ACL_RT_ERROR_L2 = 2,       // L2 Cache二级缓存错误
    ACL_RT_ERROR_AICORE = 3,   // AI Core错误
    ACL_RT_ERROR_LINK = 4,     // 暂不支持
    ACL_RT_ERROR_OTHERS = 5,   // 其它错误
} aclrtErrorType;</pre>
<p id="p11660144471112"><a name="p11660144471112"></a><a name="p11660144471112"></a></p>
<pre class="screen" id="screen1579161771219"><a name="screen1579161771219"></a><a name="screen1579161771219"></a>typedef enum aclrtAicoreErrorType { 
    ACL_RT_AICORE_ERROR_UNKOWN,   // 未知错误
    ACL_RT_AICORE_ERROR_SW,       // 建议排查软件错误
    ACL_RT_AICORE_ERROR_HW_LOCAL, // 建议排查当前Device的硬件错误
} aclrtAicoreErrorType;</pre>
<p id="p17660114412114"><a name="p17660114412114"></a><a name="p17660114412114"></a></p>
<pre class="screen" id="screen873710232128"><a name="screen873710232128"></a><a name="screen873710232128"></a>#define ACL_RT_MEM_UCE_INFO_MAX_NUM 20
typedef struct {
    size_t arraySize;  // memUceInfoArray数组大小
    <a href="aclrtMemUceInfo.md">aclrtMemUceInfo</a> memUceInfoArray[ACL_RT_MEM_UCE_INFO_MAX_NUM];  // 内存UCE的错误虚拟地址数组
} aclrtMemUceInfoArray;</pre>
<p id="p136601744171115"><a name="p136601744171115"></a><a name="p136601744171115"></a></p>
<pre class="screen" id="screen78185314120"><a name="screen78185314120"></a><a name="screen78185314120"></a>typedef union aclrtErrorInfoDetail { 
    aclrtMemUceInfoArray uceInfo;        //<span> 内存UCE（uncorrect error）</span>
    aclrtAicoreErrorType aicoreErrType;  // AI Core错误
} aclrtErrorInfoDetail; </pre>
<p id="p46611744111111"><a name="p46611744111111"></a><a name="p46611744111111"></a></p>
<pre class="screen" id="screen38283379124"><a name="screen38283379124"></a><a name="screen38283379124"></a>typedef struct aclrtErrorInfo { 
    uint8_t tryRepair;           // 是否需要修复 ，0表示无需修复，1表示需修复   
    uint8_t hasDetail;           // 是否有详细报错信息，0表示没有，1表示有
    uint8_t reserved[2];         // 预留参数
    aclrtErrorType errorType;    // 错误类型
    aclrtErrorInfoDetail detail; // 错误详细信息
} aclrtErrorInfo;</pre>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section17970231879"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

