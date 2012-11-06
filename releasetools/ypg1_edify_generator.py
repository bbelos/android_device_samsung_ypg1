#
# Copyright (C) 2008 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import os, sys

LOCAL_DIR = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..'))
RELEASETOOLS_DIR = os.path.abspath(os.path.join(LOCAL_DIR, '../../../build/tools/releasetools'))
VENDOR_SAMSUNG_DIR = os.path.abspath(os.path.join(LOCAL_DIR, '../../../vendor/samsung'))

import edify_generator

class EdifyGenerator(edify_generator.EdifyGenerator):

    def UpdateKernel(self):
     self.script.append('ui_print("Updating Kernel...");')

     self.script.append(
            ('package_extract_file("boot.img", "/tmp/boot.img");\n'
             'set_perm(0, 0, 0755, "/tmp/boot.img");'))

     self.script.append(
            ('package_extract_file("flash_kernel", "/tmp/flash_kernel");\n'
             'set_perm(0, 0, 0755, "/tmp/flash_kernel");'))
   
     self.script.append('assert(run_program("/tmp/flash_kernel", "/tmp/boot.img") == 0);')

     self.script.append('ui_print("Updating kernel...  DONE");')

    def ConvertToMtd(self):
      self.script.append('ui_print("Converting to mtd...");')

      self.script.append(
            ('package_extract_file("busybox", "/tmp/busybox");\n'
             'set_perm(0, 0, 0755, "/tmp/busybox");'))

      self.script.append(
            ('package_extract_file("erase_image", "/tmp/erase_image");\n'
             'set_perm(0, 0, 0755, "/tmp/erase_image");'))

      self.script.append(
            ('package_extract_file("make_ext4fs", "/tmp/make_ext4fs");\n'
             'set_perm(0, 0, 0755, "/tmp/make_ext4fs");'))

      self.script.append(
            ('package_extract_file("convert_to_mtd.sh", "/tmp/convert_to_mtd.sh");\n'
             'set_perm(0, 0, 0755, "/tmp/convert_to_mtd.sh");'))

      self.script.append('assert(run_program("/tmp/convert_to_mtd.sh") == 0);')

      self.script.append('ui_print("Converting to mtd...   DONE");')

      self.script.append('ui_print("Now Installing...");')

    def RunBackup(self, command):
      edify_generator.EdifyGenerator.RunBackup(self, command)
