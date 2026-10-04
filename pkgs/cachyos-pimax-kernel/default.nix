{
  callPackage,
  linuxKernel,
  cachyosKernels,
  nix-cachyos-kernel,
}:

let
  kernel = cachyosKernels.linux-cachyos-latest.override {
    pname = "cachyos-pimax-kernel";
    lto = "none";

    patches = [
      ./pimax.patch
      ./pimax2.patch
    ];
  };

  helpers = callPackage "${nix-cachyos-kernel.outPath}/helpers.nix" { };
in
helpers.kernelModuleLLVMOverride (linuxKernel.packagesFor kernel)
