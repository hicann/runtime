# aclrtBinaryLoadOptionValue<a name="ZH-CN_TOPIC_0000002253031449"></a>

```
typedef union aclrtBinaryLoadOptionValue {
    uint32_t isLazyLoad;
    uint32_t magic;
    int32_t cpuKernelMode;
    uint32_t rsv[4];
} aclrtBinaryLoadOptionValue;
```

<a name="zh-cn_topic_0249624707_table6284194414136"></a>
<table><thead align="left"><tr id="zh-cn_topic_0249624707_row341484411134"><th class="cellrowborder" valign="top" width="20.9%" id="mcps1.1.3.1.1"><p id="zh-cn_topic_0249624707_p154141244121314"><a name="zh-cn_topic_0249624707_p154141244121314"></a><a name="zh-cn_topic_0249624707_p154141244121314"></a>成员名称</p>
</th>
<th class="cellrowborder" valign="top" width="79.10000000000001%" id="mcps1.1.3.1.2"><p id="zh-cn_topic_0249624707_p10414344151315"><a name="zh-cn_topic_0249624707_p10414344151315"></a><a name="zh-cn_topic_0249624707_p10414344151315"></a>描述</p>
</th>
</tr>
</thead>
<tbody><tr id="zh-cn_topic_0249624707_row754710296481"><td class="cellrowborder" valign="top" width="20.9%" headers="mcps1.1.3.1.1 "><p id="p106121425182514"><a name="p106121425182514"></a><a name="p106121425182514"></a>isLazyLoad</p>
</td>
<td class="cellrowborder" valign="top" width="79.10000000000001%" headers="mcps1.1.3.1.2 "><p id="p74631794"><a name="p74631794"></a><a name="p74631794"></a>指定解析算子二进制、注册算子后，是否加载算子到Device侧。</p>
<p id="p165383394129"><a name="p165383394129"></a><a name="p165383394129"></a>取值如下：</p>
<a name="ul596513401217"></a><a name="ul596513401217"></a><ul id="ul596513401217"><li>1：调用本接口时不加载算子到Device侧。</li><li>0：调用本接口时加载算子到Device侧。如果不指定ACL_RT_BINARY_LOAD_OPT_LAZY_LOAD选项，系统默认按此值处理。</li></ul>
</td>
</tr>
<tr id="zh-cn_topic_0249624707_row936773214820"><td class="cellrowborder" valign="top" width="20.9%" headers="mcps1.1.3.1.1 "><p id="p0611152513258"><a name="p0611152513258"></a><a name="p0611152513258"></a>magic</p>
</td>
<td class="cellrowborder" valign="top" width="79.10000000000001%" headers="mcps1.1.3.1.2 "><p id="p7334112112140"><a name="p7334112112140"></a><a name="p7334112112140"></a>标识算子计算单元的魔术数字。</p>
<p id="p38741342174317"><a name="p38741342174317"></a><a name="p38741342174317"></a>取值为如下宏：</p>
<a name="ul73351748184315"></a><a name="ul73351748184315"></a><ul id="ul73351748184315"><li>ACL_RT_BINARY_MAGIC_ELF_AICORE</li><li>ACL_RT_BINARY_MAGIC_ELF_VECTOR_CORE</li><li>ACL_RT_BINARY_MAGIC_ELF_CUBE_CORE</li></ul>
<p id="p6181221104718"><a name="p6181221104718"></a><a name="p6181221104718"></a>宏的定义如下：</p>
<pre class="screen" id="screen225615264411"><a name="screen225615264411"></a><a name="screen225615264411"></a>#define ACL_RT_BINARY_MAGIC_ELF_AICORE      0x43554245U
#define ACL_RT_BINARY_MAGIC_ELF_VECTOR_CORE 0x41415246U
#define ACL_RT_BINARY_MAGIC_ELF_CUBE_CORE   0x41494343U</pre>
<p id="p11373818155113"><a name="p11373818155113"></a><a name="p11373818155113"></a>关于Core的定义及详细说明，请参见<a href="aclrtDevAttr.md">aclrtDevAttr</a>。</p>
</td>
</tr>
<tr id="row63896147920"><td class="cellrowborder" valign="top" width="20.9%" headers="mcps1.1.3.1.1 "><p id="p1538920141292"><a name="p1538920141292"></a><a name="p1538920141292"></a>cpuKernelMode</p>
</td>
<td class="cellrowborder" valign="top" width="79.10000000000001%" headers="mcps1.1.3.1.2 "><p id="p838919142099"><a name="p838919142099"></a><a name="p838919142099"></a>AI CPU算子注册模式。</p>
<p id="p869919321594"><a name="p869919321594"></a><a name="p869919321594"></a>取值如下：</p>
<a name="ul1592424123213"></a><a name="ul1592424123213"></a><ul id="ul1592424123213"><li>0：调用<a href="aclrtBinaryLoadFromFile.md">aclrtBinaryLoadFromFile</a>接口加载算子时，使用算子信息库文件（.json）注册算子。该场景下，AI CPU算子库文件（.so）已经在调用<a href="aclrtSetDevice.md">aclrtSetDevice</a>接口时被加载到Device。适用于加载CANN内置算子。</li><li>1：调用<a href="aclrtBinaryLoadFromFile.md">aclrtBinaryLoadFromFile</a>接口加载算子时，使用算子信息库文件（.json）注册算子。该场景下，<a href="aclrtBinaryLoadFromFile.md">aclrtBinaryLoadFromFile</a>接口会查找算子信息库文件同名的AI CPU算子库文件（.so）。适用于加载用户自定义算子。</li><li>2：调用<a href="aclrtBinaryLoadFromData.md">aclrtBinaryLoadFromData</a>接口加载算子，并配合使用<a href="aclrtRegisterCpuFunc.md">aclrtRegisterCpuFunc</a>接口注册AI CPU算子信息。适用于没有算子信息库文件，也没有算子库文件的场景。</li></ul>
</td>
</tr>
<tr id="zh-cn_topic_0249624707_row194149449133"><td class="cellrowborder" valign="top" width="20.9%" headers="mcps1.1.3.1.1 "><p id="p861112515256"><a name="p861112515256"></a><a name="p861112515256"></a>rsv</p>
</td>
<td class="cellrowborder" valign="top" width="79.10000000000001%" headers="mcps1.1.3.1.2 "><p id="p18672145895315"><a name="p18672145895315"></a><a name="p18672145895315"></a>预留值。</p>
</td>
</tr>
</tbody>
</table>

