Team SuperNova Device Repo
=======================

How to build
------------
This is a quick tutorial on building an ota package for Samsung Galaxy S Wifi/Player 4.0 using the CyanogenMod Android repo.

This tutorial begins with a belief that you have already sync'd down CyanogenMod sources and have set up your build environment.

* First, create a `local_manifest.xml` for the EpicCM kernel. Since we're merged upstream now, you no longer need to override Cyanogen vendor or add the EpicMTD device tree.

```xml
<?xml version="1.0" encoding="UTF-8"?>
  <manifest>
    <project path="kernel/samsung/ypg1" name="TeamSupernovaSGP/android_kernel_samsung_ypg1" remote="github" revision="ics"/>
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
