[back to README](README.md)

# Legacy Nix Shell Support

The traditional `nix-shell` approach is maintained for compatibility with older projects and systems. This method uses Nix channels which are being phased out in favor of flakes. While functional, it does not provide the reproducibility guarantees of the modern approach.

**Only use this if:**
- You're maintaining a legacy project that uses `shell.nix`
- You're working with tools that don't yet support flakes
- You're constrained to an older version of Nix

Example `shell.nix` with no overlay:

```nix
{ pkgs ? import <nixpkgs> {} }:

with pkgs;

mkShell {
  buildInputs = [
    nodejs_22
  ];
}
```

To use this setup, run `nix-shell` in your project directory.

## Adding This Overlay (Legacy Method)

Create a `pkgs.nix` file in your project:

```nix
{ pkgs ? import <nixpkgs> {} }:

import (pkgs.fetchFromGitHub {
  owner = "spartan-holochain-counsel";
  repo = "nix-overlay";
  rev = "b12037ca0ac4fde1d4049ba40c6e375c5e156e9a";
  sha256 = "Ou5Xs2r90f/+OsH3Y6mrnzeQ5aUNxLg1G1GGniK3f3o=";
}) {}
```

Create a `shell.nix` file in your project.  Instead of using `<nixpkgs>`, use the `pkgs.nix` file you just created.  This package overlay will provide the `holochain`, `lair-keystore`, and `hc` packages.

```nix
{ pkgs ? import ./pkgs.nix {} }:

with pkgs;

mkShell {
  buildInputs = [
    nodejs_22
    holochain
    lair-keystore
    hc
  ];
}
```