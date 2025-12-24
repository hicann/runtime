# aclrtMemcpyBatchAsync<a name="ZH-CN_TOPIC_0000002425602144"></a>

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于商用产品中。**

## AI处理器支持情况<a name="section8178181118225"></a>

<a name="table38301303189"></a>
<table><thead align="left"><tr id="row20831180131817"><th class="cellrowborder" valign="top" width="57.99999999999999%" id="mcps1.1.3.1.1"><p id="p1883113061818"><a name="p1883113061818"></a><a name="p1883113061818"></a><span id="ph20833205312295"><a name="ph20833205312295"></a><a name="ph20833205312295"></a>AI处理器类型</span></p>
</th>
<th class="cellrowborder" align="center" valign="top" width="42%" id="mcps1.1.3.1.2"><p id="p783113012187"><a name="p783113012187"></a><a name="p783113012187"></a>是否支持</p>
</th>
</tr>
</thead>
<tbody><tr id="row220181016240"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="p48327011813"><a name="p48327011813"></a><a name="p48327011813"></a><span id="ph583230201815"><a name="ph583230201815"></a><a name="ph583230201815"></a><term id="zh-cn_topic_0000001312391781_term1253731311225"><a name="zh-cn_topic_0000001312391781_term1253731311225"></a><a name="zh-cn_topic_0000001312391781_term1253731311225"></a>Ascend 910C</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p7948163910184"><a name="p7948163910184"></a><a name="p7948163910184"></a>√</p>
</td>
</tr>
<tr id="row173226882415"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="p14832120181815"><a name="p14832120181815"></a><a name="p14832120181815"></a><span id="ph1483216010188"><a name="ph1483216010188"></a><a name="ph1483216010188"></a><term id="zh-cn_topic_0000001312391781_term11962195213215"><a name="zh-cn_topic_0000001312391781_term11962195213215"></a><a name="zh-cn_topic_0000001312391781_term11962195213215"></a>Ascend 910B</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p19948143911820"><a name="p19948143911820"></a><a name="p19948143911820"></a>√</p>
</td>
</tr>
</tbody>
</table>

## 功能说明<a name="section36583473819"></a>

实现批量内存复制。

本接口中的Host内存支持锁页内存（例如通过aclrtMallocHost接口申请的内存）、非锁页内存（通过malloc接口申请的内存）。当Host内存是非锁页内存时，本接口在内存复制任务完成后才返回；当Host内存是锁页内存时，本接口是异步接口，调用接口成功仅表示任务下发成功，不表示任务执行成功，调用本接口后，需调用同步等待接口（例如，[aclrtSynchronizeStream](aclrtSynchronizeStream.md)）确保内存复制的任务已执行完成。

## 函数原型<a name="section13230182415108"></a>

```
aclError aclrtMemcpyBatchAsync(void **dsts, size_t *destMaxs, void **srcs, size_t *sizes, size_t numBatches, aclrtMemcpyBatchAttr *attrs, size_t *attrsIndexes, size_t numAttrs, size_t *failIndex, aclrtStream stream)
```

## 参数说明<a name="section75395119104"></a>

<a name="zh-cn_topic_0122830089_table438764393513"></a>
<table><thead align="left"><tr id="zh-cn_topic_0122830089_row53871743113510"><th class="cellrowborder" valign="top" width="14.000000000000002%" id="mcps1.1.4.1.1"><p id="zh-cn_topic_0122830089_p1438834363520"><a name="zh-cn_topic_0122830089_p1438834363520"></a><a name="zh-cn_topic_0122830089_p1438834363520"></a>参数名</p>
</th>
<th class="cellrowborder" valign="top" width="14.000000000000002%" id="mcps1.1.4.1.2"><p id="p1769255516412"><a name="p1769255516412"></a><a name="p1769255516412"></a>输入/输出</p>
</th>
<th class="cellrowborder" valign="top" width="72%" id="mcps1.1.4.1.3"><p id="zh-cn_topic_0122830089_p173881843143514"><a name="zh-cn_topic_0122830089_p173881843143514"></a><a name="zh-cn_topic_0122830089_p173881843143514"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="zh-cn_topic_0122830089_row2038874343514"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p039116593511"><a name="p039116593511"></a><a name="p039116593511"></a>dsts</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p16390135183518"><a name="p16390135183518"></a><a name="p16390135183518"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p58034180299"><a name="p58034180299"></a><a name="p58034180299"></a>目的内存地址数组。</p>
</td>
</tr>
<tr id="row250930135313"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p2050183045315"><a name="p2050183045315"></a><a name="p2050183045315"></a>destMax</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p115043010535"><a name="p115043010535"></a><a name="p115043010535"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p43511656544"><a name="p43511656544"></a><a name="p43511656544"></a>内存复制最大长度数组，用于存放每一段要复制的内存的最大长度，单位Byte。</p>
</td>
</tr>
<tr id="row1141161375"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p515101615378"><a name="p515101615378"></a><a name="p515101615378"></a>srcs</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p315216143713"><a name="p315216143713"></a><a name="p315216143713"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p2802171819295"><a name="p2802171819295"></a><a name="p2802171819295"></a>源内存地址数组。</p>
</td>
</tr>
<tr id="row17312161210424"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p131316128428"><a name="p131316128428"></a><a name="p131316128428"></a>sizes</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p4313191215425"><a name="p4313191215425"></a><a name="p4313191215425"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p38021318192919"><a name="p38021318192919"></a><a name="p38021318192919"></a>内存复制长度数组，用于存放每一段要复制的内存大小，单位Byte。</p>
</td>
</tr>
<tr id="row1562491417421"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p1462441464216"><a name="p1462441464216"></a><a name="p1462441464216"></a>numBatches</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p18624814144218"><a name="p18624814144218"></a><a name="p18624814144218"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p198019184297"><a name="p198019184297"></a><a name="p198019184297"></a>dsts、srcs和sizes数组的长度。</p>
</td>
</tr>
<tr id="row20722916124210"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p20722816124213"><a name="p20722816124213"></a><a name="p20722816124213"></a>attrs</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p1372291694219"><a name="p1372291694219"></a><a name="p1372291694219"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p2080013184298"><a name="p2080013184298"></a><a name="p2080013184298"></a>内存复制属性数组。</p>
</td>
</tr>
<tr id="row957083612295"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p65711636172911"><a name="p65711636172911"></a><a name="p65711636172911"></a>attrsIndexes</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p4571163632916"><a name="p4571163632916"></a><a name="p4571163632916"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p195711936112919"><a name="p195711936112919"></a><a name="p195711936112919"></a>内存复制属性索引数组，<span>用于指定attrs数组中每个条目适用的复制范围。attrs[k]中指定的属性将应用于从attrsIndexes[k]</span><span>到attrsIndexes[k+1] - 1的复制操作，同时attrs[numAttrs-1]</span><span>将应用于从attrsIndexes[numAttrs-1]到numBatches - 1的复制操作</span>。</p>
</td>
</tr>
<tr id="row6744173852920"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p14744938132918"><a name="p14744938132918"></a><a name="p14744938132918"></a>numAttrs</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p37448384299"><a name="p37448384299"></a><a name="p37448384299"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p1274493819296"><a name="p1274493819296"></a><a name="p1274493819296"></a><span>attrs和attrsIndexes数组的长度</span>。</p>
</td>
</tr>
<tr id="row072154916292"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p3721124911290"><a name="p3721124911290"></a><a name="p3721124911290"></a>failIndex</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p9721124914293"><a name="p9721124914293"></a><a name="p9721124914293"></a>输出</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p1172174915296"><a name="p1172174915296"></a><a name="p1172174915296"></a>用于发生错误时<span>指示出错的复制项下标</span>（仅支持对内存属性和复制方向的校验）。若错误不涉及特定复制操作，该值将为SIZE_MAX。</p>
</td>
</tr>
<tr id="row11647122191817"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p1964772181811"><a name="p1964772181811"></a><a name="p1964772181811"></a>stream</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p9647821191813"><a name="p9647821191813"></a><a name="p9647821191813"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p16774162816465"><a name="p16774162816465"></a><a name="p16774162816465"></a>指定执行内存复制任务的Stream。</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section25791320141317"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明<a name="section177420203915"></a>

-   将srcs中指定的数据复制到dsts中指定的内存区域，每个复制操作的大小由sizes指定，dsts、srcs、sizes这三个数组必须具有numBatches指定的相同长度。
-   批处理中的每个复制操作必须与attrs数组中指定的属性集相关联，attrs数组中的每个条目可应用于多个复制操作，具体通过attrsIndexes数组指定对应属性条目生效的起始复制索引。attrs和attrsIndexes这两个数组必须具有numAttrs指定的相同长度。例如：若批处理包含dsts/srcs/sizes列出的10个复制操作，其中前6个使用一组属性，后4个使用另一组属性，则numAttrs为2，attrsIndexes为\{0,6\}，attrs包含两组属性。注意，attrsIndexes的首个条目必须为0，且每个条目必须大于前一个条目，最后一个条目应小于numBatches。此外numAttrs必须小于等于numBatches。
-   批量内存复制的方向仅支持“从Host到Device”或者“从Device到Host”中的一种。

