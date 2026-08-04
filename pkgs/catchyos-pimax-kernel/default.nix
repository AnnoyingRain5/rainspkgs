{
  cachyosKernels,
}:

cachyosKernels.linux-cachyos-latest-lto-x86_64-v3.override {
  pname = "catchyos-pimax-kernel";
  lto = "thin";

  patches = [
    ./pimax.patch
    ./pimax2.patch
  ];
}
