#define BML_KERNEL_DEVICE "/dev/block/bml7"

int bml_unlock(const char* dev);
int bml_write(const char* dev, const char* imgname);
