.set    JUMP_ADDRESS_PTR,   0x9ff42850  @ end point of payload
.set    IMAGE3_TYPE,        0x69626f62  @ 'ibob' : new iBoot TYPE


    .text
    .syntax unified

    .arm
_entry:
    b   _entry


    .org    0x81c
    .thumb
    .thumb_func
_find_boot_images:
    bx    lr


    .org    0x1f054
    .thumb
    .thumb_func
_platform_init:
    bx    lr


    .org    0x20218
    .thumb
    .thumb_func
_prepare_and_jump:
    bx    lr


    .org    0x24c40
    .thumb
    .thumb_func
_image_load_type:
    bx    lr


    .org    0x34320
    .thumb
    .thumb_func
_disable_interrupts:
    bx    lr


    .org    0x42800
    .global _payload
    .thumb
    .thumb_func
_payload:
    ldr        sp, =0x9FFF8000
    bl         _disable_interrupts

    bl         _platform_init
    bl         _find_boot_images

    ldr        r0, =JUMP_ADDRESS_PTR
    adds       r1, r0, #0x4
    mov.w      r2, #0x84000000
    str        r2, [r0]
    mov.w      r2, #0x100000
    str        r2, [r1]
    ldr        r2, =IMAGE3_TYPE
    bl         _image_load_type         @ _image_load_type(*ptr, *sz, type)

    movs       r0, #0x2                 @ BOOT_IBOOT
    ldr        r1, =0x84000000          @ ptr
    movs       r2, #0x0                 @ args
    movs       r3, #0x0
    bl         _prepare_and_jump        @ _prepare_and_jump(BOOT_IBOOT, jumpaddr, 0, 0)

    nop
