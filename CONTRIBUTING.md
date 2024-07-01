[back to README.md](README.md)


# Contributing

The purpose of this repo is to enable quick and easy access to many versions of Holochain binaries.
It is also useful for CI environments to avoid lengthy build times.


## Development

Requires [`nix`](https://nixos.org)


### Testing

There are no automated tests.

The `tests/shell.nix` should include every defined derivation so that `nix-shell` can act as our
user testing.
