#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>

#include "flash_bml.h"
#include "flash_mtd.h"

int
main(int argc, char** argv, char** envp)
{
    struct stat st;

    if (argc != 2) {
        fprintf(stderr, "Usage: %s <image>\n", argv[0]);
        exit(1);
    }

    if (stat(BML_KERNEL_DEVICE, &st) == 0) {
        if (bml_unlock(BML_KERNEL_DEVICE) != 0) {
            fprintf(stderr, "Cannot unlock bml\n");
            exit(1);
        }
        if (bml_write(BML_KERNEL_DEVICE, argv[1]) != 0) {
            fprintf(stderr, "Cannot write kernel to bml\n");
            exit(1);
        }
    }
    else {
        char* execargv[5];
        execargv[0] = (char*)"/sbin/flash_image";
        execargv[1] = (char*)"kernel";
        execargv[2] = (char*)argv[1];
        execargv[3] = NULL;
        execve(execargv[0], execargv, envp);
        fprintf(stderr, "Cannot write kernel to mtd: %s\n", strerror(errno));
        exit(1);
    }

    return 0;
}
