# aclSysParamOpt<a name="ZH-CN_TOPIC_0000001626544745"></a>

```
typedef enum { 
    ACL_OPT_DETERMINISTIC = 0,
    ACL_OPT_ENABLE_DEBUG_KERNEL = 1
} aclSysParamOpt;
```

**表 1**  枚举项说明

<a name="table154428882117"></a>
<table><thead align="left"><tr id="row15442178172115"><th class="cellrowborder" valign="top" width="25.7%" id="mcps1.2.3.1.1"><p id="p10442188112114"><a name="p10442188112114"></a><a name="p10442188112114"></a>枚举项</p>
</th>
<th class="cellrowborder" valign="top" width="74.3%" id="mcps1.2.3.1.2"><p id="p84426814219"><a name="p84426814219"></a><a name="p84426814219"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="row134425813216"><td class="cellrowborder" valign="top" width="25.7%" headers="mcps1.2.3.1.1 "><p id="p88941317579"><a name="p88941317579"></a><a name="p88941317579"></a>ACL_OPT_DETERMINISTIC</p>
</td>
<td class="cellrowborder" valign="top" width="74.3%" headers="mcps1.2.3.1.2 "><p id="zh-cn_topic_0000001471930925_p134721729142618"><a name="zh-cn_topic_0000001471930925_p134721729142618"></a><a name="zh-cn_topic_0000001471930925_p134721729142618"></a>是否开启确定性计算。</p>
<a name="zh-cn_topic_0000001471930925_ul0927165164515"></a><a name="zh-cn_topic_0000001471930925_ul0927165164515"></a><ul id="zh-cn_topic_0000001471930925_ul0927165164515"><li>0：不开启确定性计算。默认不开启。</li><li>1：开启确定性计算。</li></ul>
<p id="zh-cn_topic_0000001471930925_p1328118232266"><a name="zh-cn_topic_0000001471930925_p1328118232266"></a><a name="zh-cn_topic_0000001471930925_p1328118232266"></a>当开启确定性计算功能时，算子在相同的硬件和输入下，多次执行将产生相同的输出。但启用确定性计算往往导致算子执行变慢。</p>
<p id="zh-cn_topic_0000001471930925_p16281323102617"><a name="zh-cn_topic_0000001471930925_p16281323102617"></a><a name="zh-cn_topic_0000001471930925_p16281323102617"></a>默认情况下，不开启确定性计算，算子在相同的硬件和输入下，多次执行的结果可能不同。这个差异的来源，一般是因为在算子实现中，存在异步的多线程执行，会导致浮点数累加的顺序变化。</p>
<p id="zh-cn_topic_0000001471930925_p14966914113113"><a name="zh-cn_topic_0000001471930925_p14966914113113"></a><a name="zh-cn_topic_0000001471930925_p14966914113113"></a>通常建议不开启确定性计算，因为确定性计算往往会导致算子执行变慢，进而影响性能。当发现模型多次执行结果不同，或者是进行精度调优时，可开启确定性计算，辅助模型调试、调优。</p>
</td>
</tr>
<tr id="row1866634613418"><td class="cellrowborder" valign="top" width="25.7%" headers="mcps1.2.3.1.1 "><p id="p206668463345"><a name="p206668463345"></a><a name="p206668463345"></a>ACL_OPT_ENABLE_DEBUG_KERNEL</p>
</td>
<td class="cellrowborder" valign="top" width="74.3%" headers="mcps1.2.3.1.2 "><p id="p118331848466"><a name="p118331848466"></a><a name="p118331848466"></a>是否开启算子执行阶段的Global Memory访问越界检测。</p>
<a name="ul13847905110"></a><a name="ul13847905110"></a><ul id="ul13847905110"><li>0：不开启内存访问越界检测。默认不开启。</li><li>1：开启内存访问越界检测。</li></ul>
<p id="p48109112319"><a name="p48109112319"></a><a name="p48109112319"></a>编译算子前调用<span id="zh-cn_topic_0000001312481497_ph817012320377"><a name="zh-cn_topic_0000001312481497_ph817012320377"></a><a name="zh-cn_topic_0000001312481497_ph817012320377"></a>aclSetCompileopt</span>接口将ACL_OP_DEBUG_OPTION配置为oom，同时配合调用<a href="aclrtCtxSetSysParamOpt.md">aclrtCtxSetSysParamOpt</a>接口（作用域是Context）或<a href="aclrtSetSysParamOpt.md">aclrtSetSysParamOpt</a>接口（作用域是进程）将ACL_OPT_ENABLE_DEBUG_KERNEL配置为1，开启Global Memory访问越界检测，这时执行算子过程中，若从Global Memory中读写数据（例如读算子输入数据、写算子输出数据等）出现内存越界，则会返回“EZ9999”错误码，表示存在算子AI Core Error问题。</p>
</td>
</tr>
</tbody>
</table>

