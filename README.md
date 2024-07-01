
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

There are 2 example nix configurations

1. `pkgs.nix` + `shell.nix`
2. `pkgs.nix` + `default.nix`

Either configuration will enable the `nix-shell` command to work.


### Example `pkgs.nix`

```nix
{ pkgs ? import <nixpkgs> {} }:

import (pkgs.fetchFromGitHub {
  owner = "spartan-holochain-counsel";
  repo = "nix-overlay";
  rev = "84d4ca0d7808ed7999854ba7ef5eac5951dc08ef";
  sha256 = "cCJaO09D1r//Knhohv8nFAmUQqBJQ4TOHrysoM7WAz4=";
})
```

or, a more condensed version using `fetchTarball`

```nix
import (fetchTarball {
  url = "https://github.com/spartan-holochain-counsel/nix-overlay/archive/84d4ca0d7808ed7999854ba7ef5eac5951dc08ef.tar.gz";
  sha256 = "cCJaO09D1r//Knhohv8nFAmUQqBJQ4TOHrysoM7WAz4=";
})
```

### Example `shell.nix`

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

### Example `default.nix`

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



## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md)
