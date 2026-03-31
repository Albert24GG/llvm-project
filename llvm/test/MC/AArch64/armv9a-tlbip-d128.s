// RUN: not llvm-mc -triple=aarch64 -show-encoding < %s 2>&1 \
// RUN:        | FileCheck %s --check-prefix=CHECK-ERROR
// RUN: llvm-mc -triple=aarch64 -show-encoding -mattr=+d128 < %s \
// RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
// RUN: llvm-mc -triple=aarch64 -filetype=obj -mattr=+d128 < %s \
// RUN:        | llvm-objdump -d --mattr=+d128 --no-print-imm-hex - | FileCheck %s --check-prefix=CHECK-INST
// RUN: llvm-mc -triple=aarch64 -filetype=obj -mattr=+d128 < %s \
// RUN:        | llvm-objdump -d --mattr=-d128 --no-print-imm-hex - | FileCheck %s --check-prefix=CHECK-UNKNOWN
// Disassemble encoding and check the re-encoding (-show-encoding) matches.
// RUN: llvm-mc -triple=aarch64 -show-encoding -mattr=+d128 < %s \
// RUN:        | sed '/.text/d' | sed 's/.*encoding: //g' \
// RUN:        | llvm-mc -triple=aarch64 -mattr=+d128 -disassemble -show-encoding \
// RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST

// +d128 required for these tlbip SYSP aliases.

tlbip IPAS2E1, x4, x5
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip ipas2e1, x4, x5
// CHECK-ENCODING: encoding: [0x24,0x84,0x4c,0xd5]
// CHECK-UNKNOWN: d54c8424 sysp #4, c8, c4, #1, x4, x5

tlbip IPAS2E1NXS, x4, x5
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip ipas2e1nxs, x4, x5
// CHECK-ENCODING: encoding: [0x24,0x94,0x4c,0xd5]
// CHECK-UNKNOWN: d54c9424 sysp #4, c9, c4, #1, x4, x5

tlbip IPAS2LE1, x4, x5
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip ipas2le1, x4, x5
// CHECK-ENCODING: encoding: [0xa4,0x84,0x4c,0xd5]
// CHECK-UNKNOWN: d54c84a4 sysp #4, c8, c4, #5, x4, x5

tlbip IPAS2LE1NXS, x4, x5
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip ipas2le1nxs, x4, x5
// CHECK-ENCODING: encoding: [0xa4,0x94,0x4c,0xd5]
// CHECK-UNKNOWN: d54c94a4 sysp #4, c9, c4, #5, x4, x5

tlbip VAE1, x8, x9
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip vae1, x8, x9
// CHECK-ENCODING: encoding: [0x28,0x87,0x48,0xd5]
// CHECK-UNKNOWN: d5488728 sysp #0, c8, c7, #1, x8, x9

tlbip VAE1NXS, x8, x9
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip vae1nxs, x8, x9
// CHECK-ENCODING: encoding: [0x28,0x97,0x48,0xd5]
// CHECK-UNKNOWN: d5489728 sysp #0, c9, c7, #1, x8, x9

tlbip VALE1, x8, x9
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip vale1, x8, x9
// CHECK-ENCODING: encoding: [0xa8,0x87,0x48,0xd5]
// CHECK-UNKNOWN: d54887a8 sysp #0, c8, c7, #5, x8, x9

tlbip VALE1NXS, x8, x9
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip vale1nxs, x8, x9
// CHECK-ENCODING: encoding: [0xa8,0x97,0x48,0xd5]
// CHECK-UNKNOWN: d54897a8 sysp #0, c9, c7, #5, x8, x9

tlbip VAAE1, x8, x9
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip vaae1, x8, x9
// CHECK-ENCODING: encoding: [0x68,0x87,0x48,0xd5]
// CHECK-UNKNOWN: d5488768 sysp #0, c8, c7, #3, x8, x9

tlbip VAAE1NXS, x8, x9
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip vaae1nxs, x8, x9
// CHECK-ENCODING: encoding: [0x68,0x97,0x48,0xd5]
// CHECK-UNKNOWN: d5489768 sysp #0, c9, c7, #3, x8, x9

tlbip VAALE1, x8, x9
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip vaale1, x8, x9
// CHECK-ENCODING: encoding: [0xe8,0x87,0x48,0xd5]
// CHECK-UNKNOWN: d54887e8 sysp #0, c8, c7, #7, x8, x9

tlbip VAALE1NXS, x8, x9
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip vaale1nxs, x8, x9
// CHECK-ENCODING: encoding: [0xe8,0x97,0x48,0xd5]
// CHECK-UNKNOWN: d54897e8 sysp #0, c9, c7, #7, x8, x9

tlbip VAE2, x14, x15
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip vae2, x14, x15
// CHECK-ENCODING: encoding: [0x2e,0x87,0x4c,0xd5]
// CHECK-UNKNOWN: d54c872e sysp #4, c8, c7, #1, x14, x15

tlbip VAE2NXS, x14, x15
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip vae2nxs, x14, x15
// CHECK-ENCODING: encoding: [0x2e,0x97,0x4c,0xd5]
// CHECK-UNKNOWN: d54c972e sysp #4, c9, c7, #1, x14, x15

tlbip VALE2, x14, x15
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip vale2, x14, x15
// CHECK-ENCODING: encoding: [0xae,0x87,0x4c,0xd5]
// CHECK-UNKNOWN: d54c87ae sysp #4, c8, c7, #5, x14, x15

tlbip VALE2NXS, x14, x15
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip vale2nxs, x14, x15
// CHECK-ENCODING: encoding: [0xae,0x97,0x4c,0xd5]
// CHECK-UNKNOWN: d54c97ae sysp #4, c9, c7, #5, x14, x15

tlbip VAE3, x24, x25
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip vae3, x24, x25
// CHECK-ENCODING: encoding: [0x38,0x87,0x4e,0xd5]
// CHECK-UNKNOWN: d54e8738 sysp #6, c8, c7, #1, x24, x25

tlbip VAE3NXS, x24, x25
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip vae3nxs, x24, x25
// CHECK-ENCODING: encoding: [0x38,0x97,0x4e,0xd5]
// CHECK-UNKNOWN: d54e9738 sysp #6, c9, c7, #1, x24, x25

tlbip VAE3IS, x24, x25
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip vae3is, x24, x25
// CHECK-ENCODING: encoding: [0x38,0x83,0x4e,0xd5]
// CHECK-UNKNOWN: d54e8338 sysp #6, c8, c3, #1, x24, x25

tlbip VAE3ISNXS, x24, x25
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip vae3isnxs, x24, x25
// CHECK-ENCODING: encoding: [0x38,0x93,0x4e,0xd5]
// CHECK-UNKNOWN: d54e9338 sysp #6, c9, c3, #1, x24, x25

tlbip VAE3OS, x24, x25
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip vae3os, x24, x25
// CHECK-ENCODING: encoding: [0x38,0x81,0x4e,0xd5]
// CHECK-UNKNOWN: d54e8138 sysp #6, c8, c1, #1, x24, x25

tlbip VAE3OSNXS, x24, x25
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip vae3osnxs, x24, x25
// CHECK-ENCODING: encoding: [0x38,0x91,0x4e,0xd5]
// CHECK-UNKNOWN: d54e9138 sysp #6, c9, c1, #1, x24, x25

tlbip VALE3, x24, x25
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip vale3, x24, x25
// CHECK-ENCODING: encoding: [0xb8,0x87,0x4e,0xd5]
// CHECK-UNKNOWN: d54e87b8 sysp #6, c8, c7, #5, x24, x25

tlbip VALE3NXS, x24, x25
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip vale3nxs, x24, x25
// CHECK-ENCODING: encoding: [0xb8,0x97,0x4e,0xd5]
// CHECK-UNKNOWN: d54e97b8 sysp #6, c9, c7, #5, x24, x25

tlbip VALE3IS, x24, x25
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip vale3is, x24, x25
// CHECK-ENCODING: encoding: [0xb8,0x83,0x4e,0xd5]
// CHECK-UNKNOWN: d54e83b8 sysp #6, c8, c3, #5, x24, x25

tlbip VALE3ISNXS, x24, x25
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip vale3isnxs, x24, x25
// CHECK-ENCODING: encoding: [0xb8,0x93,0x4e,0xd5]
// CHECK-UNKNOWN: d54e93b8 sysp #6, c9, c3, #5, x24, x25

tlbip VALE3OS, x24, x25
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip vale3os, x24, x25
// CHECK-ENCODING: encoding: [0xb8,0x81,0x4e,0xd5]
// CHECK-UNKNOWN: d54e81b8 sysp #6, c8, c1, #5, x24, x25

tlbip VALE3OSNXS, x24, x25
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip vale3osnxs, x24, x25
// CHECK-ENCODING: encoding: [0xb8,0x91,0x4e,0xd5]
// CHECK-UNKNOWN: d54e91b8 sysp #6, c9, c1, #5, x24, x25

tlbip RVAE1, x18, x19
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip rvae1, x18, x19
// CHECK-ENCODING: encoding: [0x32,0x86,0x48,0xd5]
// CHECK-UNKNOWN: d5488632 sysp #0, c8, c6, #1, x18, x19

tlbip RVAE1NXS, x18, x19
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip rvae1nxs, x18, x19
// CHECK-ENCODING: encoding: [0x32,0x96,0x48,0xd5]
// CHECK-UNKNOWN: d5489632 sysp #0, c9, c6, #1, x18, x19

tlbip RVAAE1, x18, x19
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip rvaae1, x18, x19
// CHECK-ENCODING: encoding: [0x72,0x86,0x48,0xd5]
// CHECK-UNKNOWN: d5488672 sysp #0, c8, c6, #3, x18, x19

tlbip RVAAE1NXS, x18, x19
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip rvaae1nxs, x18, x19
// CHECK-ENCODING: encoding: [0x72,0x96,0x48,0xd5]
// CHECK-UNKNOWN: d5489672 sysp #0, c9, c6, #3, x18, x19

tlbip RVALE1, x18, x19
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip rvale1, x18, x19
// CHECK-ENCODING: encoding: [0xb2,0x86,0x48,0xd5]
// CHECK-UNKNOWN: d54886b2 sysp #0, c8, c6, #5, x18, x19

tlbip RVALE1NXS, x18, x19
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip rvale1nxs, x18, x19
// CHECK-ENCODING: encoding: [0xb2,0x96,0x48,0xd5]
// CHECK-UNKNOWN: d54896b2 sysp #0, c9, c6, #5, x18, x19

tlbip RVAALE1, x18, x19
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip rvaale1, x18, x19
// CHECK-ENCODING: encoding: [0xf2,0x86,0x48,0xd5]
// CHECK-UNKNOWN: d54886f2 sysp #0, c8, c6, #7, x18, x19

tlbip RVAALE1NXS, x18, x19
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip rvaale1nxs, x18, x19
// CHECK-ENCODING: encoding: [0xf2,0x96,0x48,0xd5]
// CHECK-UNKNOWN: d54896f2 sysp #0, c9, c6, #7, x18, x19

tlbip RVAE2, x28, x29
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip rvae2, x28, x29
// CHECK-ENCODING: encoding: [0x3c,0x86,0x4c,0xd5]
// CHECK-UNKNOWN: d54c863c sysp #4, c8, c6, #1, x28, x29

tlbip RVAE2NXS, x28, x29
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip rvae2nxs, x28, x29
// CHECK-ENCODING: encoding: [0x3c,0x96,0x4c,0xd5]
// CHECK-UNKNOWN: d54c963c sysp #4, c9, c6, #1, x28, x29

tlbip RVALE2, x28, x29
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip rvale2, x28, x29
// CHECK-ENCODING: encoding: [0xbc,0x86,0x4c,0xd5]
// CHECK-UNKNOWN: d54c86bc sysp #4, c8, c6, #5, x28, x29

tlbip RVALE2NXS, x28, x29
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip rvale2nxs, x28, x29
// CHECK-ENCODING: encoding: [0xbc,0x96,0x4c,0xd5]
// CHECK-UNKNOWN: d54c96bc sysp #4, c9, c6, #5, x28, x29

tlbip RVAE3, x10, x11
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip rvae3, x10, x11
// CHECK-ENCODING: encoding: [0x2a,0x86,0x4e,0xd5]
// CHECK-UNKNOWN: d54e862a sysp #6, c8, c6, #1, x10, x11

tlbip RVAE3NXS, x10, x11
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip rvae3nxs, x10, x11
// CHECK-ENCODING: encoding: [0x2a,0x96,0x4e,0xd5]
// CHECK-UNKNOWN: d54e962a sysp #6, c9, c6, #1, x10, x11

tlbip RVAE3IS, x10, x11
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip rvae3is, x10, x11
// CHECK-ENCODING: encoding: [0x2a,0x82,0x4e,0xd5]
// CHECK-UNKNOWN: d54e822a sysp #6, c8, c2, #1, x10, x11

tlbip RVAE3ISNXS, x10, x11
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip rvae3isnxs, x10, x11
// CHECK-ENCODING: encoding: [0x2a,0x92,0x4e,0xd5]
// CHECK-UNKNOWN: d54e922a sysp #6, c9, c2, #1, x10, x11

tlbip RVAE3OS, x10, x11
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip rvae3os, x10, x11
// CHECK-ENCODING: encoding: [0x2a,0x85,0x4e,0xd5]
// CHECK-UNKNOWN: d54e852a sysp #6, c8, c5, #1, x10, x11

tlbip RVAE3OSNXS, x10, x11
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip rvae3osnxs, x10, x11
// CHECK-ENCODING: encoding: [0x2a,0x95,0x4e,0xd5]
// CHECK-UNKNOWN: d54e952a sysp #6, c9, c5, #1, x10, x11

tlbip RVALE3, x10, x11
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip rvale3, x10, x11
// CHECK-ENCODING: encoding: [0xaa,0x86,0x4e,0xd5]
// CHECK-UNKNOWN: d54e86aa sysp #6, c8, c6, #5, x10, x11

tlbip RVALE3NXS, x10, x11
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip rvale3nxs, x10, x11
// CHECK-ENCODING: encoding: [0xaa,0x96,0x4e,0xd5]
// CHECK-UNKNOWN: d54e96aa sysp #6, c9, c6, #5, x10, x11

tlbip RVALE3IS, x10, x11
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip rvale3is, x10, x11
// CHECK-ENCODING: encoding: [0xaa,0x82,0x4e,0xd5]
// CHECK-UNKNOWN: d54e82aa sysp #6, c8, c2, #5, x10, x11

tlbip RVALE3ISNXS, x10, x11
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip rvale3isnxs, x10, x11
// CHECK-ENCODING: encoding: [0xaa,0x92,0x4e,0xd5]
// CHECK-UNKNOWN: d54e92aa sysp #6, c9, c2, #5, x10, x11

tlbip RVALE3OS, x10, x11
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip rvale3os, x10, x11
// CHECK-ENCODING: encoding: [0xaa,0x85,0x4e,0xd5]
// CHECK-UNKNOWN: d54e85aa sysp #6, c8, c5, #5, x10, x11

tlbip RVALE3OSNXS, x10, x11
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip rvale3osnxs, x10, x11
// CHECK-ENCODING: encoding: [0xaa,0x95,0x4e,0xd5]
// CHECK-UNKNOWN: d54e95aa sysp #6, c9, c5, #5, x10, x11

tlbip RIPAS2E1, x20, x21
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip ripas2e1, x20, x21
// CHECK-ENCODING: encoding: [0x54,0x84,0x4c,0xd5]
// CHECK-UNKNOWN: d54c8454 sysp #4, c8, c4, #2, x20, x21

tlbip RIPAS2E1NXS, x20, x21
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip ripas2e1nxs, x20, x21
// CHECK-ENCODING: encoding: [0x54,0x94,0x4c,0xd5]
// CHECK-UNKNOWN: d54c9454 sysp #4, c9, c4, #2, x20, x21

tlbip RIPAS2LE1, x20, x21
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip ripas2le1, x20, x21
// CHECK-ENCODING: encoding: [0xd4,0x84,0x4c,0xd5]
// CHECK-UNKNOWN: d54c84d4 sysp #4, c8, c4, #6, x20, x21

tlbip RIPAS2LE1NXS, x20, x21
// CHECK-ERROR: error: instruction requires: d128
// CHECK-INST: tlbip ripas2le1nxs, x20, x21
// CHECK-ENCODING: encoding: [0xd4,0x94,0x4c,0xd5]
// CHECK-UNKNOWN: d54c94d4 sysp #4, c9, c4, #6, x20, x21
