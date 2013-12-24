CM11.0 for YP-G1/YP-GB1
=======================

How to build
------------
This is a quick tutorial on building an ota package for Samsung Galaxy S Wifi/Player 4.0 using the CyanogenMod Android repo.

This tutorial begins with a belief that you have already sync'd down CyanogenMod sources and have set up your build environment.

* First, create a `roomservice.xml` for the Palladio (YP-G1 kernel). Put this file in /.repo/local_manifests/ (create "local_manifests" folder if you don't have one

```xml
<?xml version="1.0" encoding="UTF-8"?>
  <manifest>
    <project path="kernel/samsung/ypg13.0" name="bbelos/android_kernel_samsung_aries" remote="github" revision="cm-11.0-ypg1-dev"/>
  </manifest>
```

* To set up the vendor tree, you'll need to `cd` to `device/samsung/ypg1` and:

  1. Run `extract-files.sh` while phone is connected via usb to pull proprietaries from device. The script will then call `setup-makefiles` to generate `vendor/samsung/ypg1/` and the necessary makefiles for blob manipulation.

  2. Next, from the root android directory, you'll need to:

```
repo sync
make clobber
brunch ypg1

Or

repo sync
. build/envsetup.sh && brunch ypg1
```

and the build will begin!

At the end of the compile, the generate ota package will be in `out/target/product/ypg1/`
