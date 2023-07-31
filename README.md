# Patched ghc

There is a [bug in the ghc Haskell
compiler](https://gitlab.haskell.org/ghc/ghc/-/issues/23138), that on macOS
produces symptoms like this:

```
ghc: loadArchive: Neither an archive, nor a fat archive: `/nix/store/y432q34aj5h9qn5qzm4w066j5l5dhmd2-clang-wrapper-11.1.0/bin/clang++'

<no location info>: error:
    loadArchive "/nix/store/y432q34aj5h9qn5qzm4w066j5l5dhmd2-clang-wrapper-11.1.0/bin/clang++": failed
```

This is triggered by a combination of macOS, template haskell, and packages
using C++.

There is currently no fix. A workaround is via [this
patch](https://github.com/input-output-hk/haskell.nix/blob/master/overlays/patches/ghc/ghc-9.2-macOS-loadArchive-fix.patch)
but it has [not been merged into
nixpkgs](https://github.com/NixOS/nixpkgs/pull/149942) because it breaks some
other things (eg using `extra-libraries: z` in the cabal file).

However, if you need it, then this flake provides an overlay with the fix. It
currently just applies the patch to ghc928, but if other versions are needed,
the logic was cherry-picked from
[haskell.nix](https://github.com/input-output-hk/haskell.nix/blob/0f2a6a9dfad636680367c0462dcd50ee64a9bddc/overlays/bootstrap.nix#L137-L141).
