
# Nix Overlay

This repository provides a Nix overlay for managing Holochain and related binaries. It simplifies
the setup and maintenance of Holochain development environments by offering pre-defined Nix
expressions.

[![](https://img.shields.io/github/issues-raw/spartan-holochain-counsel/nix-overlay?style=flat-square)](https://github.com/spartan-holochain-counsel/nix-overlay/issues)
[![](https://img.shields.io/github/issues-closed-raw/spartan-holochain-counsel/nix-overlay?style=flat-square)](https://github.com/spartan-holochain-counsel/nix-overlay/issues?q=is%3Aissue+is%3Aclosed)
[![](https://img.shields.io/github/issues-pr-raw/spartan-holochain-counsel/nix-overlay?style=flat-square)](https://github.com/spartan-holochain-counsel/nix-overlay/pulls)


## Overview

This overlay includes necessary tools and dependencies for
[developing](https://github.com/holochain/holochain) [Holochain](https://www.holochain.org/)
applications.


## Usage

To use this Nix overlay, you need to have Nix installed. If you don't have Nix installed, you can
follow the instructions [here](https://nixos.org/download.html).

Once you have Nix installed, you can use this overlay as your package source.

There are 3 example nix configurations

1. `pkgs.nix` + `shell.nix`
2. `pkgs.nix` + `default.nix`
3. `pkgs.nix` + `flake.nix`

Configuration #1 and #2 are used by the `nix-shell` command while #3 is used by the `nix develop`
command.


#### Example `pkgs.nix`

```nix
{ pkgs ? import <nixpkgs> {} }:

import (pkgs.fetchFromGitHub {
  owner = "spartan-holochain-counsel";
  repo = "nix-overlay";
  rev = "b12037ca0ac4fde1d4049ba40c6e375c5e156e9a";
  sha256 = "Ou5Xs2r90f/+OsH3Y6mrnzeQ5aUNxLg1G1GGniK3f3o=";
}) {}
```

or, a more condensed version using `fetchTarball`

```nix
import (fetchTarball {
  url = "https://github.com/spartan-holochain-counsel/nix-overlay/archive/b12037ca0ac4fde1d4049ba40c6e375c5e156e9a.tar.gz";
  sha256 = "Ou5Xs2r90f/+OsH3Y6mrnzeQ5aUNxLg1G1GGniK3f3o=";
}) {}
```

#### Example `shell.nix`

```nix
{ pkgs ? import ./pkgs.nix {} }:

with pkgs;

mkShell {
  buildInputs = [
    holochain
    lair-keystore
    hc
  ];
}
```

#### Example `default.nix`

```nix
{ pkgs ? import ./pkgs.nix {} }:

with pkgs;

stdenv.mkDerivation {
  name = "";
  src = ./.;

  nativeBuildInputs = [
    holochain
    lair-keystore
    hc
  ];
}
```

### Flake Support

Flakes are more strict and so we need to modify the previous `pkgs.nix` so that:

- `<nixpkgs>` is not used
- `system` is explicitly provided

```nix
{ pkgs, system }:

import (pkgs.fetchFromGitHub {
  owner = "spartan-holochain-counsel";
  repo = "nix-overlay";
  rev = "b12037ca0ac4fde1d4049ba40c6e375c5e156e9a";
  sha256 = "Ou5Xs2r90f/+OsH3Y6mrnzeQ5aUNxLg1G1GGniK3f3o=";
}) {
  inherit pkgs;
  inherit system;
}
```


#### Example `flake.nix`

```nix
{
  description = "Flake for Holochain development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import ./pkgs.nix {
        pkgs = nixpkgs.legacyPackages.${system};
        inherit system;
      };
    in
    {
      devShells.${system} = {
        default = pkgs.mkShell {
          buildInputs = with pkgs; [
            holochain
            lair-keystore
            hc
            nodejs_22
          ];
        };
      };
    };
}
```



## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md)
