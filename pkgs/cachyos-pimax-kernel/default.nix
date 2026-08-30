{
  callPackage,
  linuxKernel,
  cachyosKernels,
  nix-cachyos-kernel,
}:

let
  kernel = cachyosKernels.linux-cachyos-latest-lto.override {
    pname = "cachyos-pimax-kernel";
    lto = "thin";

    patches = [
      ./pimax.patch
      ./pimax2.patch
    ];
  };

  helpers = callPackage "${nix-cachyos-kernel.outPath}/helpers.nix" { };
in
helpers.kernelModuleLLVMOverride (linuxKernel.packagesFor kernel)
