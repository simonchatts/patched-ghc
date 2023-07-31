# Workaround for "ghc: loadArchive: Neither an archive, nor a fat archive" bug
# with ghc on macOS.
#
# CURRENTLY APPLIES ONLY TO 9.2.8
#
# Patch from https://github.com/input-output-hk/haskell.nix/blob/0f2a6a9dfad636680367c0462dcd50ee64a9bddc/overlays/bootstrap.nix#L137
# Patch method inspired by https://github.com/NixOS/nixpkgs/issues/101580#issuecomment-716086458
{
  description = "Patch GHC loadArchive macOS bug";
  outputs = { self, nixpkgs }: {
    overlays.default = final: prev: {
      haskell = prev.haskell // {
        packages = prev.haskell.packages // {
          ghc928 = prev.haskell.packages.ghc928.override {
            overrides = self: super: {
              ghc = super.ghc.overrideAttrs
                (old: {
                  patches = old.patches
                    ++ final.lib.optional final.stdenv.isDarwin ./ghc-9.2-macOS-loadArchive-fix.patch;
                });
            };
          };
        };
      };
    };
  };
}
