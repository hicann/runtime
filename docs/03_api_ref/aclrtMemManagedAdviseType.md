# aclrtMemManagedAdviseType

```
typedef enum aclrtMemManagedAdviseType {
     ACL_MEM_ADVISE_SET_READ_MOSTLY = 0,
     ACL_MEM_ADVISE_UNSET_READ_MOSTLY,
     ACL_MEM_ADVISE_SET_PREFERRED_LOCATION,
     ACL_MEM_ADVISE_UNSET_PREFERRED_LOCATION,
     ACL_MEM_ADVISE_SET_ACCESSED_BY,
     ACL_MEM_ADVISE_UNSET_ACCESSED_BY,
} aclrtMemManagedAdviseType;
```

枚举项说明如下：

-   **ACL\_MEM\_ADVISE\_SET\_READ\_MOSTLY**

    设置内存多副本属性，通常称为read mostly属性。

    若为某段UVM内存设置read mostly属性，除了首次访问该段内存的对象外（注：此处的对象指Host或Device），其他对象访问时，都会创建一个只读内存副本，即一个虚拟地址可以拥有多个只读副本。在有只读内存副本的对象上，只有首次访问时，需建立虚拟内存到物理内存的页表映射关系。再次在有只读内存副本的对象访问内存时，就不会触发缺页中断，以减少缺页中断带来的性能开销。

    但如果对设置了read mostly属性的内存进行了写操作，除了发生写操作的对象，其他对象上的副本都将会失效并取消read mostly属性，再次访问时会触发缺页中断，系统需要重新建立页表映射，从而影响性能。所以建议对通常只读、极少进行写操作的UVM内存设置read mostly属性。

    若设置为ACL\_MEM\_ADVISE\_SET\_READ\_MOSTLY选项，则location参数被忽略，这时会在Host上建立一个只读副本，默认拥有一份数据。

-   **ACL\_MEM\_ADVISE\_UNSET\_READ\_MOSTLY**

    取消设置read mostly属性。

    取消之后，该段UVM内存仅保留一个内存副本，保留哪个对象上的内存副本，取决于传入的location参数，若传invalid，则认为保留Host上的内存副本；若传入的location上没有副本，则会建立一个副本。同时，除了保留内存副本的对象，其他对象上的内存副本都会失效，相应的物理内存会释放。

-   **ACL\_MEM\_ADVISE\_SET\_PREFERRED\_LOCATION**

    设置内存首选位置属性，通常称为preferred location属性，表示访问该段内存的首选位置是Host或Device。

    该属性可与内存访问者属性（即ACL\_MEM\_ADVISE\_SET\_ACCESSED\_BY）配合使用，当location相同时，用于提前分配物理内存，建立页表映射，从而避免在首选位置访问内存时出现缺页中断的开销。

    在设置preferred location属性时，需要注意read mostly属性是否设置：

    -   read mostly属性未设置时，若将首选位置设置在Host上，则接口内部会检查当前内存地址在Device上是否已有映射，如果有映射，则返回报错；如果没有映射，接口内部会检查当前内存地址在Host上是否已有映射，有映射，则直接返回，没有映射，则申请物理内存、建立readwrite属性的页表映射后再返回。
    -   read mostly属性未设置时，若将首选位置设置在某个指定Device上，则接口内部会检查当前地址在Host或其他Device上是否有映射，如果有映射，则返回报错；如果没有映射，则在该指定Device上申请物理内存、建立readwrite属性的页表映射后再返回。
    -   read mostly属性已设置时，若将首选位置设置在Host上，则接口内部无需操作直接返回。
    -   read mostly属性已设置时，若将首选位置设置在某个指定Device上，则接口内部会检查指定Device上是否已有副本，如果有，则直接返回，如果没有，则建立只读副本后再返回。

-   **ACL\_MEM\_ADVISE\_UNSET\_PREFERRED\_LOCATION**

    取消设置preferred location属性。

-   **ACL\_MEM\_ADVISE\_SET\_ACCESSED\_BY**

    设置远端映射属性，通常称为accessed by属性。

    该属性需与首选位置属性（即ACL\_MEM\_ADVISE\_SET\_PREFERRED\_LOCATION）配合使用，当location相同时，用于提前分配物理内存，建立页表映射，从而避免在首选位置访问内存时出现缺页中断的开销。

-   **ACL\_MEM\_ADVISE\_UNSET\_ACCESSED\_BY**

    取消设置accessed by属性。
