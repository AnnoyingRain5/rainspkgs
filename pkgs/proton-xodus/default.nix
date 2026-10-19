{
  proton-ge-bin,
  runCommandLocal,
  xz,
  ...
}:

proton-ge-bin.overrideAttrs (
  finalAttrs: _: rec {
    version = "11.0-20260803-3-g7c0b4354";
    xodusToolName = "proton-xodus-bleeding-edge-${version}-x86_64";
    srcTarball = ./${xodusToolName}.tar.xz;
    pname = "proton-xodus-bin";
    steamDisplayName = "Proton-Xodus";
    src =
      runCommandLocal "proton-xodus-${finalAttrs.version}"
        {
          nativeBuildInputs = [ xz ];
        }
        ''
          mkdir -p $out
          ls
          tar -xf ${srcTarball} --strip-components=1 -C $out
        '';
    toolName = xodusToolName;
  }
)
