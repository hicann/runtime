# aclrtMemcpy2dAsync<a name="ZH-CN_TOPIC_0000001312721889"></a>

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

实现异步内存复制，主要用于矩阵数据的复制。异步接口。

本接口中的Host内存支持锁页内存（例如通过aclrtMallocHost接口申请的内存）、非锁页内存（通过malloc接口申请的内存）。当Host内存是非锁页内存时，本接口在内存复制任务完成后才返回；当Host内存是锁页内存时，本接口是异步接口，调用接口成功仅表示任务下发成功，不表示任务执行成功，调用本接口后，需调用同步等待接口（例如，[aclrtSynchronizeStream](aclrtSynchronizeStream.md)）确保内存复制的任务已执行完成。

## 函数原型<a name="section13230182415108"></a>

```
aclError aclrtMemcpy2dAsync(void *dst, size_t dpitch, const void *src, size_t spitch, size_t width, size_t height, aclrtMemcpyKind kind, aclrtStream stream)
```

## 参数说明<a name="section299423513711"></a>

<a name="table10994103513715"></a>
<table><thead align="left"><tr id="row499511351477"><th class="cellrowborder" valign="top" width="14.000000000000002%" id="mcps1.1.4.1.1"><p id="p59957351711"><a name="p59957351711"></a><a name="p59957351711"></a>参数名</p>
</th>
<th class="cellrowborder" valign="top" width="14.000000000000002%" id="mcps1.1.4.1.2"><p id="p15995173518712"><a name="p15995173518712"></a><a name="p15995173518712"></a>输入/输出</p>
</th>
<th class="cellrowborder" valign="top" width="72%" id="mcps1.1.4.1.3"><p id="p209951235577"><a name="p209951235577"></a><a name="p209951235577"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="row99953351779"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p1199518352716"><a name="p1199518352716"></a><a name="p1199518352716"></a>dst</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p299513351716"><a name="p299513351716"></a><a name="p299513351716"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p4388859358"><a name="p4388859358"></a><a name="p4388859358"></a>目的内存地址指针。</p>
</td>
</tr>
<tr id="row19325172813547"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p132542895418"><a name="p132542895418"></a><a name="p132542895418"></a>dpitch</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p1932513281547"><a name="p1932513281547"></a><a name="p1932513281547"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p133251928165412"><a name="p133251928165412"></a><a name="p133251928165412"></a>目的内存中相邻两列向量的地址距离。</p>
</td>
</tr>
<tr id="row499523512713"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p9995133519716"><a name="p9995133519716"></a><a name="p9995133519716"></a>src</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p1699513351674"><a name="p1699513351674"></a><a name="p1699513351674"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p331381215420"><a name="p331381215420"></a><a name="p331381215420"></a>源内存地址指针。</p>
</td>
</tr>
<tr id="row11110144813545"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p12110174825419"><a name="p12110174825419"></a><a name="p12110174825419"></a>spitch</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p19110154865416"><a name="p19110154865416"></a><a name="p19110154865416"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p8110848185419"><a name="p8110848185419"></a><a name="p8110848185419"></a>源内存中相邻两列向量的地址距离。</p>
</td>
</tr>
<tr id="row1799553511716"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p99956359715"><a name="p99956359715"></a><a name="p99956359715"></a>width</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p299520357718"><a name="p299520357718"></a><a name="p299520357718"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p199593510719"><a name="p199593510719"></a><a name="p199593510719"></a>待复制的数据宽度。</p>
</td>
</tr>
<tr id="row55741570547"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p2575125716546"><a name="p2575125716546"></a><a name="p2575125716546"></a>height</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p757516578547"><a name="p757516578547"></a><a name="p757516578547"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p14575175716544"><a name="p14575175716544"></a><a name="p14575175716544"></a>待复制的数据高度。</p>
<p id="p294531020578"><a name="p294531020578"></a><a name="p294531020578"></a>height最大设置为5*1024*1024=5242880，否则接口返回失败。</p>
</td>
</tr>
<tr id="row129950357710"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p14995335171"><a name="p14995335171"></a><a name="p14995335171"></a>kind</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p899553513713"><a name="p899553513713"></a><a name="p899553513713"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p1799510352071"><a name="p1799510352071"></a><a name="p1799510352071"></a>内存复制的类型。</p>
</td>
</tr>
<tr id="row677517391276"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p1670412481572"><a name="p1670412481572"></a><a name="p1670412481572"></a>stream</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p070410481379"><a name="p070410481379"></a><a name="p070410481379"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p16774162816465"><a name="p16774162816465"></a><a name="p16774162816465"></a>指定执行内存复制任务的Stream。</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section25791320141317"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明<a name="section1613446194714"></a>

-   当前仅支持ACL\_MEMCPY\_HOST\_TO\_DEVICE类型和ACL\_MEMCPY\_DEVICE\_TO\_HOST类型的内存复制。

## 参考资源<a name="section18438172417714"></a>

本接口的内存复制示意图：

![](figures/主要接口调用流程.png)

