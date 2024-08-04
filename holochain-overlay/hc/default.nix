{ pkgs ? import <nixpkgs> {}, version, sha256, arch ? "x86_64-unknown-linux-gnu" }:

with pkgs;

let
  splitComponents = str: builtins.filter (s: s != "") (builtins.split "-" str);
  isSubset = set1: set2: builtins.all (x: builtins.elem x set2) set1;
  isMatch = isSubset
    (splitComponents (builtins.replaceStrings ["mingw32"] ["windows"] system))
    (splitComponents arch);
  warnMismatch =
    if ! isMatch
    then builtins.trace
        "WARNING: Supplying hc version ${version} for ${arch} on a ${system} system; this may not work correctly"
    else (x: x);
in
stdenv.mkDerivation rec {
  pname = "hc";
  inherit version;

  src = fetchurl {
    url = "https://github.com/matthme/holochain-binaries/releases/download/hc-binaries-${version}/hc-v${version}-${arch}";
    inherit sha256;
  };

  nativeBuildInputs = [];

  unpackPhase = "true"; # Skip the default unpackPhase

  buildPhase = "true"; # Skip the default buildPhase

  installPhase = warnMismatch ''
    mkdir -p $out/bin
    cp $src $out/bin/hc-${version}
    chmod +x $out/bin/hc-${version}
    ln -s $out/bin/hc-${version} $out/bin/${pname}
  '';

  meta = {
    description = "Holochain CLI binary downloaded from GitHub releases";
    homepage = "https://github.com/spartan-holochain-counsel/nix-overlay";
    platforms = with lib.platforms; linux ++ darwin ++ windows;
  };
}
