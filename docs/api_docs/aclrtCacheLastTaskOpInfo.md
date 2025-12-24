# aclrtCacheLastTaskOpInfo

## AI处理器支持情况

<table><thead align="left"><tr id="row20831180131817"><th class="cellrowborder" valign="top" width="57.99999999999999%" id="mcps1.1.3.1.1"><p id="p1883113061818"><a name="p1883113061818"></a><a name="p1883113061818"></a><span id="ph20833205312295"><a name="ph20833205312295"></a><a name="ph20833205312295"></a>AI处理器类型</span></p>
</th>
<th class="cellrowborder" align="center" valign="top" width="42%" id="mcps1.1.3.1.2"><p id="p783113012187"><a name="p783113012187"></a><a name="p783113012187"></a>是否支持</p>
</th>
</tr>
</thead>
<tbody><tr id="row220181016240"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="p48327011813"><a name="p48327011813"></a><a name="p48327011813"></a><span id="ph583230201815"><a name="ph583230201815"></a><a name="ph583230201815"></a><term id="zh-cn_topic_0000001312391781_term1253731311225"><a name="zh-cn_topic_0000001312391781_term1253731311225"></a><a name="zh-cn_topic_0000001312391781_term1253731311225"></a>Ascend 910C</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p183501357115213"><a name="p183501357115213"></a><a name="p183501357115213"></a>√</p>
</td>
</tr>
<tr id="row173226882415"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="p14832120181815"><a name="p14832120181815"></a><a name="p14832120181815"></a><span id="ph1483216010188"><a name="ph1483216010188"></a><a name="ph1483216010188"></a><term id="zh-cn_topic_0000001312391781_term11962195213215"><a name="zh-cn_topic_0000001312391781_term11962195213215"></a><a name="zh-cn_topic_0000001312391781_term11962195213215"></a>Ascend 910B</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p11349105713526"><a name="p11349105713526"></a><a name="p11349105713526"></a>√</p>
</td>
</tr>
</tbody>
</table>

## 功能说明

基于捕获方式构建模型运行实例场景下，把指定内存中的算子信息按照infoSize大小缓存到当前线程中最后下发的任务上。

## 函数原型

```
aclError aclrtCacheLastTaskOpInfo(const void * const infoPtr, const size_t infoSize)
```

## 参数说明

<table><thead align="left"><tr id="zh-cn_topic_0122830089_row53871743113510"><th class="cellrowborder" valign="top" width="18%" id="mcps1.1.4.1.1"><p id="zh-cn_topic_0122830089_p1438834363520"><a name="zh-cn_topic_0122830089_p1438834363520"></a><a name="zh-cn_topic_0122830089_p1438834363520"></a>参数名</p>
</th>
<th class="cellrowborder" valign="top" width="14.000000000000002%" id="mcps1.1.4.1.2"><p id="p1769255516412"><a name="p1769255516412"></a><a name="p1769255516412"></a>输入/输出</p>
</th>
<th class="cellrowborder" valign="top" width="68%" id="mcps1.1.4.1.3"><p id="zh-cn_topic_0122830089_p173881843143514"><a name="zh-cn_topic_0122830089_p173881843143514"></a><a name="zh-cn_topic_0122830089_p173881843143514"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="row198943121925"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p4487610155311"><a name="p4487610155311"></a><a name="p4487610155311"></a>infoPtr</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p4487181014532"><a name="p4487181014532"></a><a name="p4487181014532"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p4388859358"><a name="p4388859358"></a><a name="p4388859358"></a>缓存信息内存地址指针，此处是Host内存</p>
</td>
</tr>
<tr id="row72911443183611"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p32911643133612"><a name="p32911643133612"></a><a name="p32911643133612"></a>infoSize</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p029154313368"><a name="p029154313368"></a><a name="p029154313368"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p25171614103714"><a name="p25171614103714"></a><a name="p25171614103714"></a>缓存信息内存大小，单位Byte。</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 接口调用流程

本接口需与以下其它关键接口配合使用，以便控制后续采集性能数据时附带算子信息：

1.  调用[aclmdlRICaptureBegin](aclmdlRICaptureBegin.md)接口开始捕获任务。
2.  调用[aclrtSetStreamAttribute](aclrtSetStreamAttribute.md)接口开启算子信息缓存开关。
3.  下发算子执行任务，例如调用[aclrtLaunchKernelWithConfig](aclrtLaunchKernelWithConfig.md)接口。
4.  调用[aclrtGetStreamAttribute](aclrtGetStreamAttribute.md)接口获取算子信息缓存开关是否开启。

    只有在捕获状态下，且通过[aclrtSetStreamAttribute](aclrtSetStreamAttribute.md)接口开启了算子信息缓存开关，此处的[aclrtGetStreamAttribute](aclrtGetStreamAttribute.md)接口才能获取到算子信息缓存开关已开启的状态。

5.  调用[aclrtCacheLastTaskOpInfo](aclrtCacheLastTaskOpInfo.md)接口缓存算子信息。
6.  再次调用[aclrtSetStreamAttribute](aclrtSetStreamAttribute.md)接口关闭算子信息缓存开关。
7.  调用[aclmdlRICaptureEnd](aclmdlRICaptureEnd.md)接口结束任务捕获。
8.  开启采集性能数据（参见[Profiling数据采集接口](Profiling数据采集接口.md)章节下的接口）后，调用[aclmdlRIExecuteAsync](aclmdlRIExecuteAsync.md)接口执行推理。

    在此过程中，采集的性能数据会附带算子信息。

9.  最后，调用[aclmdlRIDestroy](aclmdlRIDestroy.md)接口销毁模型运行实例时，算子缓存信息也会被一并释放。

