{ pkgs ? import <nixpkgs> {}, system ? "x86_64-linux" }:

let
  nixpkgs = import pkgs.path {
    inherit system;
    overlays = [
      (import ./holochain-overlay)
    ];
  };
in
nixpkgs
