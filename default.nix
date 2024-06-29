let
  nixpkgs = import <nixpkgs> {
    overlays = [ (import ./holochain-overlay) ];
  };
in
nixpkgs
