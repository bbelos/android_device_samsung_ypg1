#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>

#define PROC_MTD "/proc/mtd"

static int
mtd_find_partition(const char* name, char* res)
{
    char buf[1024];
    ssize_t len;
    int fd;
    const char* p;

    fd = open(PROC_MTD, O_RDONLY);
    if (fd == -1) {
        return -1;
    }
    len = read(fd, buf, sizeof(buf));
    close(fd);
    if (len < 0 || len >= sizeof(buf)) {
        return -1;
    }
    buf[len] = '\0';
    p = buf;
    while (*p) {
        const char* q;
        const char* fs;
        const char* fe;
        q = strchr(p, '\n');
        if (q)
            ++q;
        else
            q = &buf[len];

        if (q-p < 80) {
            char devname[80];
            char partname[80];

            memset(devname, 0, sizeof(devname));
            fs = p;
            fe = strchr(fs, ':');
            if (fe) {
                memcpy(devname, fs, fe-fs);
            }

            memset(partname, 0, sizeof(partname));
            fs = strchr(p, '"');
            if (fs) {
                fe = strchr(fs+1, '"');
                if (fe) {
                    memcpy(partname, fs+1, fe-fs-2);
                }
            }

            if (!strcmp(name, partname)) {
                strcpy(res, devname);
                return 0;
            }
        }

        p = q;
    }

    return -1;
}

int
mtd_write(const char* partname, const char* imgname)
{
    int rc = -1;
    char devname[80];
    int ifd = -1;
    int ofd = -1;
    struct stat st;
    ssize_t nr, nw;
    size_t tr, tw;
    char buf[BML_BLOCK_SIZE];

    if (stat(imgname, &st) != 0) {
        return -1;
    }
    if (!S_ISREG(st.st_mode)) {
        return -1;
    }

    if (mtd_find_partition(partname, devname) != 0) {
        return -1;
    }

    printf("Writing image %s to device %s (%d bytes) ...\n",
            imgname, devname, st.st_mode);

    ifd = open(imgname, O_RDONLY);
    if (ifd < 0) {
        fprintf(stderr, "Cannot open %s: %s\n", imgname, strerror(errno));
        rc = -1;
        goto error;
    }
    ofd = open(devname, O_RDWR | O_LARGEFILE);
    if (ofd < 0) {
        fprintf(stderr, "Cannot open %s: %s\n", dev, strerror(errno));
        rc = -1;
        goto error;
    }

    tr = tw = 0;
    do {
        nr = read(ifd, buf, BML_BLOCK_SIZE);
        if (nr < 0) {
            fprintf(stderr, "read failed: %s\n", strerror(errno));
            rc = -1;
            goto error;
        }
        if (nr != BML_BLOCK_SIZE && tr+nr != st.st_size) {
            rc = -1;
            goto error;
        }
        if (nr < BML_BLOCK_SIZE) {
            memset(buf+nr, 0, BML_BLOCK_SIZE-nr);
        }
        tr += nr;

        nw = write(ofd, buf, BML_BLOCK_SIZE);
        if (nw < 0) {
            fprintf(stderr, "write failed: %s\n", strerror(errno));
            rc = -1;
            goto error;
        }
        if (nw != BML_BLOCK_SIZE) {
            fprintf(stderr, "short write\n");
            rc = -1;
            goto error;
        }
        tw += nw;
    }
    while (tw < st.st_size);

    printf("... success!\n");
    rc = 0;

error:
    fsync(ofd);
    close(ofd);
    close(ifd);
    return rc;
}
