{
  lib,
  moonPlatform,
  moonRegistryIndex,
  stdenv,
}:
let
  dependencies = {
    "totto2727/admiral" = "0.6.2";
    "totto2727/lens" = "0.4.1";
    "moonbitlang/x" = "0.4.47";
    "moonbitlang/async" = "0.20.3";
    "gmlewis/base64" = "0.16.11";
  };
  cachedRegistry = moonPlatform.buildCachedRegistry {
    moonModDepsSet = dependencies;
    registryIndexSrc = moonRegistryIndex;
  };
  moonHome = moonPlatform.bundleWithRegistry {
    inherit cachedRegistry;
  };
  packageSrc = lib.fileset.toSource {
    root = ./.;
    fileset = lib.fileset.unions [
      ./moon.mod
      ./README.mbt.md
      ./README.md
      ./src
    ];
  };
in
stdenv.mkDerivation {
  pname = "bw";
  version = "0.2.2";
  src = packageSrc;
  nativeBuildInputs = [ moonHome ];
  dontConfigure = true;
  buildPhase = ''
    runHook preBuild

    writable_home="$TMPDIR/moon_home"
    cp -rL ${moonHome} "$writable_home"
    chmod -R u+w "$writable_home"
    export MOON_HOME="$writable_home"
    export HOME="$TMPDIR"

    moon_bin="$MOON_HOME/bin/.moon-wrapped"
    "$moon_bin" build --release --strip

    runHook postBuild
  '';
  installPhase = ''
    runHook preInstall

    mkdir -p "$out/bin"
    install -Dm755 _build/native/release/build/bw.exe "$out/bin/bw"

    runHook postInstall
  '';
  meta = {
    description = "Native MoonBit CLI for Cloudflare Browser Rendering API";
    homepage = "https://github.com/totto2727-org/bw";
    license = lib.licenses.mit;
    mainProgram = "bw";
  };
}
