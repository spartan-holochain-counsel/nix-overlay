{ pkgs ? import ./default.nix }:

pkgs.mkShell {
  buildInputs = [
    pkgs.holochain
    pkgs.holochain_0
    pkgs.holochain_0-1
    pkgs.holochain_0-2
    pkgs.holochain_0-3
    pkgs.holochain_0-4

    pkgs.holochain_0-1-8

    pkgs.holochain_0-2-5
    pkgs.holochain_0-2-6-rc-0
    pkgs.holochain_0-2-6
    pkgs.holochain_0-2-7-rc-0
    pkgs.holochain_0-2-7-rc-1
    pkgs.holochain_0-2-7
    pkgs.holochain_0-2-8-rc-0
    pkgs.holochain_0-2-8-rc-1
    pkgs.holochain_0-2-8

    pkgs.holochain_0-3-0-beta-dev-35
    pkgs.holochain_0-3-0-beta-dev-36
    pkgs.holochain_0-3-0-beta-dev-37
    pkgs.holochain_0-3-0-beta-dev-38
    pkgs.holochain_0-3-0-beta-dev-39
    pkgs.holochain_0-3-0-beta-dev-43
    pkgs.holochain_0-3-0-beta-dev-44
    pkgs.holochain_0-3-0-beta-dev-45
    pkgs.holochain_0-3-0-beta-dev-46
    pkgs.holochain_0-3-0-beta-dev-48
    pkgs.holochain_0-3-0
    pkgs.holochain_0-3-1-rc-1
    pkgs.holochain_0-3-1-rc-2
    pkgs.holochain_0-3-1

    pkgs.holochain_0-4-0-dev-1
    pkgs.holochain_0-4-0-dev-2
    pkgs.holochain_0-4-0-dev-3
    pkgs.holochain_0-4-0-dev-4
    pkgs.holochain_0-4-0-dev-5
    pkgs.holochain_0-4-0-dev-6
    pkgs.holochain_0-4-0-dev-7
    pkgs.holochain_0-4-0-dev-8
    pkgs.holochain_0-4-0-dev-9
    pkgs.holochain_0-4-0-dev-10


    pkgs.lair-keystore
    pkgs.lair-keystore_0
    pkgs.lair-keystore_0-4

    pkgs.lair-keystore_0-4-2
    pkgs.lair-keystore_0-4-3
    pkgs.lair-keystore_0-4-4
    pkgs.lair-keystore_0-4-5


    pkgs.hc
    pkgs.hc_0
    pkgs.hc_0-2
    pkgs.hc_0-3
    pkgs.hc_0-4

    pkgs.hc_0-2-8

    pkgs.hc_0-3-0-beta-dev-47
    pkgs.hc_0-3-1

    pkgs.hc_0-4-0-dev-0
    pkgs.hc_0-4-0-dev-1
    pkgs.hc_0-4-0-dev-2
    pkgs.hc_0-4-0-dev-3
    pkgs.hc_0-4-0-dev-4
    pkgs.hc_0-4-0-dev-5
    pkgs.hc_0-4-0-dev-6
    pkgs.hc_0-4-0-dev-7
    pkgs.hc_0-4-0-dev-8
    pkgs.hc_0-4-0-dev-9
    pkgs.hc_0-4-0-dev-10
  ];
}
