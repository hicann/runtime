# aclrtAllocatorGetByStream<a name="ZH-CN_TOPIC_0000002476103057"></a>

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

根据Stream查询用户注册的Allocator信息。

## 函数原型<a name="section13230182415108"></a>

```
aclError aclrtAllocatorGetByStream(aclrtStream stream, aclrtAllocatorDesc *allocatorDesc, aclrtAllocator *allocator, aclrtAllocatorAllocFunc *allocFunc, aclrtAllocatorFreeFunc *freeFunc, aclrtAllocatorAllocAdviseFunc *allocAdviseFunc, aclrtAllocatorGetAddrFromBlockFunc *getAddrFromBlockFunc)
```

## 参数说明<a name="section75395119104"></a>

<a name="zh-cn_topic_0122830089_table438764393513"></a>
<table><thead align="left"><tr id="zh-cn_topic_0122830089_row53871743113510"><th class="cellrowborder" valign="top" width="23.69%" id="mcps1.1.4.1.1"><p id="zh-cn_topic_0122830089_p1438834363520"><a name="zh-cn_topic_0122830089_p1438834363520"></a><a name="zh-cn_topic_0122830089_p1438834363520"></a>参数名</p>
</th>
<th class="cellrowborder" valign="top" width="12.64%" id="mcps1.1.4.1.2"><p id="p1769255516412"><a name="p1769255516412"></a><a name="p1769255516412"></a>输入/输出</p>
</th>
<th class="cellrowborder" valign="top" width="63.67%" id="mcps1.1.4.1.3"><p id="zh-cn_topic_0122830089_p173881843143514"><a name="zh-cn_topic_0122830089_p173881843143514"></a><a name="zh-cn_topic_0122830089_p173881843143514"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="row16791142193514"><td class="cellrowborder" valign="top" width="23.69%" headers="mcps1.1.4.1.1 "><p id="p15958212071"><a name="p15958212071"></a><a name="p15958212071"></a>stream</p>
</td>
<td class="cellrowborder" valign="top" width="12.64%" headers="mcps1.1.4.1.2 "><p id="p195951218713"><a name="p195951218713"></a><a name="p195951218713"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="63.67%" headers="mcps1.1.4.1.3 "><p id="p17756574599"><a name="p17756574599"></a><a name="p17756574599"></a>注册的类型，按照不同的子模块区分。</p>
</td>
</tr>
<tr id="row10434124115174"><td class="cellrowborder" valign="top" width="23.69%" headers="mcps1.1.4.1.1 "><p id="p5435741201718"><a name="p5435741201718"></a><a name="p5435741201718"></a>allocatorDesc</p>
</td>
<td class="cellrowborder" valign="top" width="12.64%" headers="mcps1.1.4.1.2 "><p id="p34356415171"><a name="p34356415171"></a><a name="p34356415171"></a>输出</p>
</td>
<td class="cellrowborder" valign="top" width="63.67%" headers="mcps1.1.4.1.3 "><p id="p19435341181711"><a name="p19435341181711"></a><a name="p19435341181711"></a>Allocator描述符指针。</p>
</td>
</tr>
<tr id="row47855443171"><td class="cellrowborder" valign="top" width="23.69%" headers="mcps1.1.4.1.1 "><p id="p678584411711"><a name="p678584411711"></a><a name="p678584411711"></a>allocator</p>
</td>
<td class="cellrowborder" valign="top" width="12.64%" headers="mcps1.1.4.1.2 "><p id="p127851944111714"><a name="p127851944111714"></a><a name="p127851944111714"></a>输出</p>
</td>
<td class="cellrowborder" valign="top" width="63.67%" headers="mcps1.1.4.1.3 "><p id="p7785144131718"><a name="p7785144131718"></a><a name="p7785144131718"></a>用户提供的Allocator对象指针。</p>
</td>
</tr>
<tr id="row19988133618518"><td class="cellrowborder" valign="top" width="23.69%" headers="mcps1.1.4.1.1 "><p id="p16593182119716"><a name="p16593182119716"></a><a name="p16593182119716"></a>allocFunc</p>
</td>
<td class="cellrowborder" valign="top" width="12.64%" headers="mcps1.1.4.1.2 "><p id="p2593112118713"><a name="p2593112118713"></a><a name="p2593112118713"></a>输出</p>
</td>
<td class="cellrowborder" valign="top" width="63.67%" headers="mcps1.1.4.1.3 "><p id="p48811531152813"><a name="p48811531152813"></a><a name="p48811531152813"></a>申请内存block的回调函数。</p>
<p id="p128968121218"><a name="p128968121218"></a><a name="p128968121218"></a>回调函数定义如下：</p>
<pre class="screen" id="screen714239138"><a name="screen714239138"></a><a name="screen714239138"></a>typedef void *(*aclrtAllocatorAllocFunc)(<a href="aclrtAllocator.md">aclrtAllocator</a> allocator, size_t size);</pre>
</td>
</tr>
<tr id="row18465121462415"><td class="cellrowborder" valign="top" width="23.69%" headers="mcps1.1.4.1.1 "><p id="p104661314162415"><a name="p104661314162415"></a><a name="p104661314162415"></a>freeFunc</p>
</td>
<td class="cellrowborder" valign="top" width="12.64%" headers="mcps1.1.4.1.2 "><p id="p174666141243"><a name="p174666141243"></a><a name="p174666141243"></a>输出</p>
</td>
<td class="cellrowborder" valign="top" width="63.67%" headers="mcps1.1.4.1.3 "><p id="p184661214122413"><a name="p184661214122413"></a><a name="p184661214122413"></a>释放内存block的回调函数。</p>
<p id="p12951363445"><a name="p12951363445"></a><a name="p12951363445"></a>回调函数定义如下：</p>
<pre class="screen" id="screen3537163391415"><a name="screen3537163391415"></a><a name="screen3537163391415"></a>typedef void (*aclrtAllocatorFreeFunc)(<a href="aclrtAllocator.md">aclrtAllocator</a> allocator, <a href="aclrtAllocatorBlock.md">aclrtAllocatorBlock</a> block);</pre>
</td>
</tr>
<tr id="row2794191952418"><td class="cellrowborder" valign="top" width="23.69%" headers="mcps1.1.4.1.1 "><p id="p10794111972415"><a name="p10794111972415"></a><a name="p10794111972415"></a>allocAdviseFunc</p>
</td>
<td class="cellrowborder" valign="top" width="12.64%" headers="mcps1.1.4.1.2 "><p id="p3794419172410"><a name="p3794419172410"></a><a name="p3794419172410"></a>输出</p>
</td>
<td class="cellrowborder" valign="top" width="63.67%" headers="mcps1.1.4.1.3 "><p id="p13794119102414"><a name="p13794119102414"></a><a name="p13794119102414"></a>根据建议地址申请内存block的回调函数。</p>
<p id="p13531268427"><a name="p13531268427"></a><a name="p13531268427"></a>回调函数定义如下：</p>
<pre class="screen" id="screen1034084411311"><a name="screen1034084411311"></a><a name="screen1034084411311"></a>typedef void *(*aclrtAllocatorAllocAdviseFunc)(<a href="aclrtAllocator.md">aclrtAllocator</a> allocator, size_t size, <a href="aclrtAllocatorAddr.md">aclrtAllocatorAddr</a> addr);</pre>
</td>
</tr>
<tr id="row77331626172416"><td class="cellrowborder" valign="top" width="23.69%" headers="mcps1.1.4.1.1 "><p id="p173320267249"><a name="p173320267249"></a><a name="p173320267249"></a>getAddrFromBlockFunc</p>
</td>
<td class="cellrowborder" valign="top" width="12.64%" headers="mcps1.1.4.1.2 "><p id="p15733122617242"><a name="p15733122617242"></a><a name="p15733122617242"></a>输出</p>
</td>
<td class="cellrowborder" valign="top" width="63.67%" headers="mcps1.1.4.1.3 "><p id="p19733152612415"><a name="p19733152612415"></a><a name="p19733152612415"></a>根据申请来的block获取device内存地址的回调函数。</p>
<p id="p189741728144410"><a name="p189741728144410"></a><a name="p189741728144410"></a>回调函数定义如下：</p>
<pre class="screen" id="screen5887813171518"><a name="screen5887813171518"></a><a name="screen5887813171518"></a>typedef void *(*aclrtAllocatorGetAddrFromBlockFunc)(<a href="aclrtAllocatorBlock.md">aclrtAllocatorBlock</a> block);</pre>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section25791320141317"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

