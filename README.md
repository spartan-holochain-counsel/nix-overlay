
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

These instructions will use the modern flakes-based approach.  For legacy `nix-shell` support, see [LEGACY_NIX_SHELL.md](LEGACY_NIX_SHELL.md).

### What are Nix flakes?

Nix flakes are the modern approach to managing Nix packages.  They provide better dependency management by removing reliance on channels (`<nixpkgs>`) and explicitly tracking package sources.  Flakes does this by using:
- Precise tracking of package sources
- Locked dependency versions via `flake.lock`
- Guaranteed reproducible environments across machines

Example `flake.nix` with no overlay:

```nix
{
  description = "Simple flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: {
      devShells.default =
        let pkgs = nixpkgs.legacyPackages.${system};
      in
        pkgs.mkShell {
          buildInputs = [
            pkgs.nodejs_22
          ];
        };
    });
}
```

To use this setup, run `nix develop` in your project directory.


## Adding This Overlay

Create a `pkgs.nix` file in your project:

```nix
{ pkgs, system }:

import (pkgs.fetchFromGitHub {
  owner = "spartan-holochain-counsel";
  repo = "nix-overlay";
  rev = "513d98c24f95dd86b452a346b7d1c6e589eac9a8";
  sha256 = "0RgYJW9lxb2Y3I1UFm8zW1MlAASFe0IrwoW7gLISyv0=";
}) {
  inherit pkgs;
  inherit system;
}
```

Create a `flake.nix` file in your project that uses `./pkgs.nix` so that the holochain binaries are available:

```nix
{
  description = "Holochain Development Env";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import ./pkgs.nix {
          pkgs = nixpkgs.legacyPackages.${system};
          inherit system;
        };
      in {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            # From nix-overlay
            holochain
            lair-keystore
            hc

            # From nixpkgs
            nodejs_22
          ];

          shellHook = ''
            export PS1="\[\e[1;32m\](flake-env)\[\e[0m\] \[\e[1;34m\]\u@\h:\w\[\e[0m\]$ "
            export CARGO_HOME=$(pwd)/.cargo
            export RUSTUP_HOME=$(pwd)/.rustup
            rustup default stable
            rustup target add wasm32-unknown-unknown
          '';
        };
      }
    );
}
```

### Understanding the Shell Hook

The shell hook in the flake configuration sets up your development environment with several important configurations:

#### 1. Visual Environment Indicator
```bash
export PS1="\[\e[1;32m\](flake-env)\[\e[0m\] \[\e[1;34m\]\u@\h:\w\[\e[0m\]$ "
```
This sets a custom shell prompt that clearly shows when you're working inside the flake environment. It helps prevent confusion about which environment you're currently using.

#### 2. Project-Local Rust Configuration
```bash
export CARGO_HOME=$(pwd)/.cargo
export RUSTUP_HOME=$(pwd)/.rustup
```
These commands keep your Rust toolchain local to the project directory. This is important because:
- It prevents conflicts between different projects that might need different Rust versions
- Makes the project more portable and reproducible
- Allows multiple developers to work with exactly the same Rust setup
- Isolates project-specific Rust dependencies from your global installation

#### 3. WASM-Specific Rust Setup
```bash
rustup default stable
rustup target add wasm32-unknown-unknown
```
These commands configure Rust for WebAssembly compilation:
- Sets up stable Rust as the default toolchain for reliable builds
- Adds WebAssembly (WASM) support, which is essential because:
  - Holochain DNAs are composed of Zomes, which are WASM modules
  - The `wasm32-unknown-unknown` target enables direct compilation of Rust code to WASM

### Confirming the Setup

After setting up the flake, and entering the development shell with `nix develop`, you can verify that the dependencies are working correctly by running:

```bash
holochain --version
lair-keystore --version
hc --version
```

This should display the version of each of the Holochain binaries that were installed by the flake.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md)
