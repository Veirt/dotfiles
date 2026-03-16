{ ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      nativeOptimized = pkg:
        pkg.overrideAttrs (old: {
          preferLocalBuild = true;
          allowSubstitutes = false;
          NIX_CFLAGS_COMPILE =
            (old.NIX_CFLAGS_COMPILE or "")
            + " -O3 -march=native -mtune=native";
        });

      nativeOptimizedLto = pkg:
        pkg.overrideAttrs (old: {
          preferLocalBuild = true;
          allowSubstitutes = false;
          NIX_CFLAGS_COMPILE =
            (old.NIX_CFLAGS_COMPILE or "")
            + " -O3 -march=native -mtune=native -flto";
          NIX_LDFLAGS = (old.NIX_LDFLAGS or "") + " -flto";
        });
    })
  ];
}
