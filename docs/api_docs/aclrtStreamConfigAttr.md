# aclrtStreamConfigAttr<a name="ZH-CN_TOPIC_0000001572603794"></a>

```
typedef enum {
    ACL_RT_STREAM_WORK_ADDR_PTR = 0, 
    ACL_RT_STREAM_WORK_SIZE, 
    ACL_RT_STREAM_FLAG,
    ACL_RT_STREAM_PRIORITY,
} aclrtStreamConfigAttr;
```

**表 1**  枚举项说明

<a name="table154428882117"></a>
<table><thead align="left"><tr id="row15442178172115"><th class="cellrowborder" valign="top" width="32.879999999999995%" id="mcps1.2.3.1.1"><p id="p10442188112114"><a name="p10442188112114"></a><a name="p10442188112114"></a>枚举项</p>
</th>
<th class="cellrowborder" valign="top" width="67.12%" id="mcps1.2.3.1.2"><p id="p84426814219"><a name="p84426814219"></a><a name="p84426814219"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="row134425813216"><td class="cellrowborder" valign="top" width="32.879999999999995%" headers="mcps1.2.3.1.1 "><p id="p88941317579"><a name="p88941317579"></a><a name="p88941317579"></a>ACL_RT_STREAM_WORK_ADDR_PTR</p>
</td>
<td class="cellrowborder" valign="top" width="67.12%" headers="mcps1.2.3.1.2 "><p id="p3832144135111"><a name="p3832144135111"></a><a name="p3832144135111"></a>某一个Stream上的模型所需工作内存（Device上存放模型执行过程中的临时数据）的指针，由用户管理工作内存。该配置主要用于多模型在同一个Stream上串行执行时想共享工作内存的场景，此时需按多个模型中最大的工作内存来申请内存，可提前使用<span id="ph75816213409"><a name="ph75816213409"></a><a name="ph75816213409"></a>aclmdlQuerySize</span>查询各模型所需的工作内存大小。</p>
<p id="p16188154741118"><a name="p16188154741118"></a><a name="p16188154741118"></a>如果同时配置ACL_RT_STREAM_WORK_ADDR_PTR以及<span id="ph193219517408"><a name="ph193219517408"></a><a name="ph193219517408"></a>aclmdlExecConfigAttr</span>中的ACL_MDL_WORK_ADDR_PTR（表示某个模型的工作内存），则以aclmdlExecConfigAttr中的ACL_MDL_WORK_ADDR_PTR优先。</p>
</td>
</tr>
<tr id="row444313892114"><td class="cellrowborder" valign="top" width="32.879999999999995%" headers="mcps1.2.3.1.1 "><p id="p8871613205715"><a name="p8871613205715"></a><a name="p8871613205715"></a>ACL_RT_STREAM_WORK_SIZE</p>
</td>
<td class="cellrowborder" valign="top" width="67.12%" headers="mcps1.2.3.1.2 "><p id="p53742540355"><a name="p53742540355"></a><a name="p53742540355"></a>模型所需工作内存的大小，单位为Byte。</p>
</td>
</tr>
<tr id="row1144315862113"><td class="cellrowborder" valign="top" width="32.879999999999995%" headers="mcps1.2.3.1.1 "><p id="p138581355716"><a name="p138581355716"></a><a name="p138581355716"></a>ACL_RT_STREAM_FLAG</p>
</td>
<td class="cellrowborder" valign="top" width="67.12%" headers="mcps1.2.3.1.2 "><p id="p1684013175719"><a name="p1684013175719"></a><a name="p1684013175719"></a>预留配置，默认值为0。</p>
</td>
</tr>
<tr id="row6443168192118"><td class="cellrowborder" valign="top" width="32.879999999999995%" headers="mcps1.2.3.1.1 "><p id="p1783713145717"><a name="p1783713145717"></a><a name="p1783713145717"></a>ACL_RT_STREAM_PRIORITY</p>
</td>
<td class="cellrowborder" valign="top" width="67.12%" headers="mcps1.2.3.1.2 "><p id="p158251345715"><a name="p158251345715"></a><a name="p158251345715"></a>Stream的优先级，数字越小优先级越高，取值[0,7]。默认值为0。</p>
</td>
</tr>
</tbody>
</table>

