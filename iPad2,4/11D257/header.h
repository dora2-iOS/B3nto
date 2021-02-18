/* iPhone5,2 - 11D257 [iBoot] */
#define EXPLOIT_BASE                0x47bc8     // PC register obtained by exploit
#define EXPLOIT_SECOND_BASE         0x47bf2     // Set second point to bypass overwriting by exploit
#define EXPLOIT_SWAP_BASE           0x478c0     // Exploit area is small, so set points somewhere else

/* iPhone5,2 - 11D257 [NewiBoot] */
#define PAYLOAD_BASE                0x42800     // main_task() configured for new iBoot
#define PAYLOAD_BASE_SIZE           0x44        // sz

/* iPhone5,2 - 11D257 [ramdisk] */
#define RDSK_PD_BASE                0x854
#define RDSK_PD_SECOND_BASE         0x87E
#define RDSK_PD_SWAP_BASE           0x570

/* payload setting */
#define EXPLOIT_BASE_SIZE           0x24
#define EXPLOIT_SECOND_BASE_SIZE    0x52
#define EXPLOIT_SWAP_BASE_SIZE      0x12

