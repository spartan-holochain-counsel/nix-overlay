self: super: {
  # 0000000000000000000000000000000000000000000=

  eachSystem = f: builtins.concatMap (system: f system) [
    "x86_64-linux"
    "x86_64-windows"
    "x86_64-darwin"
    "aarch64-darwin"
  ];

  checkCompatibility = { version, arch, name }: let
    # Function to split a string into components by hyphen and filter out empty strings
    splitComponents = str: builtins.filter (s: s != "") (builtins.split "-" str);

    # Ensure "set2" contains all items from "set1"
    #
    # Example:
    #
    #     system = "x86_64-linux"
    #     arch = "x86_64-unknown-linux-gnu"
    #
    #     [ "x86_64", "linux" ] is subset of [ "x86_64", "unknown", "linux", "gnu" ]
    isSubset = set1: set2: builtins.all (x: builtins.elem x set2) set1;

    # Function to check if all elements of "system" are in "arch"
    isMatch = isSubset
      (splitComponents (builtins.replaceStrings ["mingw32"] ["windows"] super.system))
      (splitComponents arch);
  in
    # If the system and arch do not match, display a warning message; otherwise, do nothing.  This
    # warning helps inform the user of potential incompatibilities
    if ! isMatch
    then builtins.trace
      "WARNING: Supplying ${name} version ${version} for ${arch} on a ${super.system} system; this may not work correctly"
    else (x: x);

  # Helper function to create symbolic links
  createSymlink = pkg: alias: super.runCommand "symlink-${alias}" {} ''
    mkdir -p $out/bin
    ln -s ${pkg}/bin/${pkg.pname} $out/bin/${pkg.pname}
    ln -s ${pkg}/bin/${pkg.pname}-${pkg.version} $out/bin/${pkg.pname}-${pkg.version}
    ln -fs ${pkg}/bin/${pkg.pname}-${pkg.version} $out/bin/${alias}
  '';

  # Helper function to select the appropriate architecture and construct the config
  selectArchConfig = { system ? super.system, version, linux_x64, darwin_x64 ? null, darwin_aarch64 ? null, windows_x64 ? null }:
    let
      archMap = {
        "x86_64-linux" = { arch = "x86_64-unknown-linux-gnu"; sha256 = linux_x64; };
        "x86_64-darwin" = { arch = "x86_64-apple-darwin"; sha256 = darwin_x64; };
        "aarch64-darwin" = { arch = "aarch64-apple-darwin"; sha256 = darwin_aarch64; };
        "x86_64-mingw32" = { arch = "x86_64-pc-windows-msvc"; sha256 = windows_x64; };
      };
    in
      if builtins.hasAttr system archMap
      then archMap.${system} // { inherit version; }
      else throw "Unsupported system: ${system}";

  holochain_0-1-8 = super.callPackage ./holochain/default.nix { version = "0.1.8"; sha256 = "HVJ6SItgOj2fkGAOsbzS5d/+4yau+xIyTxl/59Ela8s="; };

  holochain_0-1-x = self.holochain_0-1-8;
  holochain_0-1 = self.createSymlink self.holochain_0-1-x "holochain-0.1";

  holochain_0-2-5 = super.callPackage ./holochain/default.nix { version = "0.2.5"; sha256 = "1Nj6pMVNib0a8bELk43dv/t5NRAUehzLUsLPbhyu9k8="; };
  holochain_0-2-6-rc-0 = super.callPackage ./holochain/default.nix { version = "0.2.6-rc.0"; sha256 = "IY55Ol7Bg1pLm23rXtatauX5b5oIizdIJ/nGAgnJazg="; };
  holochain_0-2-6 = super.callPackage ./holochain/default.nix { version = "0.2.6"; sha256 = "V+025Zpow/0b6DkoWJea0xwm/HzIyiFjtDKXS9e3C3A="; };
  holochain_0-2-7-rc-0 = super.callPackage ./holochain/default.nix { version = "0.2.7-rc.0"; sha256 = "85qRtMHs2vduOA8h+fWhUM3QI0qU/XsWVVNq+gwIg10="; };
  holochain_0-2-7-rc-1 = super.callPackage ./holochain/default.nix { version = "0.2.7-rc.1"; sha256 = "HGveiCSbm4zKaISG1gTKH3IltBSj2czhA4y6l75o+4A="; };
  holochain_0-2-7 = super.callPackage ./holochain/default.nix { version = "0.2.7"; sha256 = "ZYGuZQfPhjEgXL/vGsW2SlaIZwjpnbqUhhB3N1vJZC0="; };
  holochain_0-2-8-rc-0 = super.callPackage ./holochain/default.nix { version = "0.2.8-rc.0"; sha256 = "J9ly21yEDbZ1wv+uUyD4EcD1cjvRK0VOrtJPVp2Q3Xk="; };
  holochain_0-2-8-rc-1 = super.callPackage ./holochain/default.nix { version = "0.2.8-rc.1"; sha256 = "PEXEgPG/r6lRCn4yYNtllrnqex9iQUdbw91si5uInEg="; };
  holochain_0-2-8 = super.callPackage ./holochain/default.nix { version = "0.2.8"; sha256 = "pWk8KvPwrw6hLNilX8oZxUOqs9wQeLRddg1fnMXUHlk="; };

  holochain_0-2-x = self.holochain_0-2-8;
  holochain_0-2 = self.createSymlink self.holochain_0-2-x "holochain-0.2";

  holochain_0-3-0-beta-dev-35 = super.callPackage ./holochain/default.nix { version = "0.3.0-beta-dev.35"; sha256 = "ZM/aAmRu6no96pK5pPkOCGrLlzIdTPKSTIo2WrogRds="; };
  holochain_0-3-0-beta-dev-36 = super.callPackage ./holochain/default.nix { version = "0.3.0-beta-dev.36"; sha256 = "GjxfUUHHFQVVXlM/9Eep6o69/iSoRzTNTBErc943UYE="; };
  holochain_0-3-0-beta-dev-37 = super.callPackage ./holochain/default.nix { version = "0.3.0-beta-dev.37"; sha256 = "qYJjppgmvT0lZiZmbhLiK9Kc61F06JCdBthxcG1iQoo="; };
  holochain_0-3-0-beta-dev-38 = super.callPackage ./holochain/default.nix { version = "0.3.0-beta-dev.38"; sha256 = "73AojnHA1Fw8YQgV6ewyKmi6yiAYei8up3oTI/X2w/U="; };
  holochain_0-3-0-beta-dev-39 = super.callPackage ./holochain/default.nix { version = "0.3.0-beta-dev.39"; sha256 = "FKbpChXksnl3TLFJKfHhbzf02sdo/P7id6KjKJxZF9c="; };
  holochain_0-3-0-beta-dev-43 = super.callPackage ./holochain/default.nix { version = "0.3.0-beta-dev.43"; sha256 = "yM+P1qnz7lI+MNW+m00UywpJOaX96opGxjYlRK7Bkts="; };
  holochain_0-3-0-beta-dev-44 = super.callPackage ./holochain/default.nix { version = "0.3.0-beta-dev.44"; sha256 = "OCuehzccffrOCvTTm7H1aXfMdLlnuREBeeIU7JTqxzk="; };
  holochain_0-3-0-beta-dev-45 = super.callPackage ./holochain/default.nix { version = "0.3.0-beta-dev.45"; sha256 = "LTdY9WxtOXiKMp6TSlAE2sKy0vUF99GHLfQR4kYZA9U="; };
  holochain_0-3-0-beta-dev-46 = super.callPackage ./holochain/default.nix { version = "0.3.0-beta-dev.46"; sha256 = "iFzban2JWWBLav3ehEUYfN41FtGV+8F4WM1MO1YMGqg="; };
  holochain_0-3-0-beta-dev-48 = super.callPackage ./holochain/default.nix { version = "0.3.0-beta-dev.48"; sha256 = "A1TPtmHt9hH+39gQpgvwOVrv6PFBVkOSvJ7JuavZaEw="; };
  holochain_0-3-0 = super.callPackage ./holochain/default.nix { version = "0.3.0"; sha256 = "wJHIBEG1Ixz2dk3qPMsBIoAxa5F5dmFWN15TYvDIGZM="; };
  holochain_0-3-1-rc-1 = super.callPackage ./holochain/default.nix { version = "0.3.1-rc.1"; sha256 = "/j4wxFh8qR2b5CwXp3eLxoJP3t1RB4b4Z+IwMPesW3Y="; };
  holochain_0-3-1-rc-2 = super.callPackage ./holochain/default.nix { version = "0.3.1-rc.2"; sha256 = "SD7nMtyhBZbpIkD7TVN5utM0tGGegwiyhi8MuX3Os0w="; };
  holochain_0-3-1 = super.callPackage ./holochain/default.nix { version = "0.3.1"; sha256 = "AkNc8ex/a4Uo8jHXN3M8wFog+/wOPOJRIYkLVMIaHhs="; };
  holochain_0-3-2 = super.callPackage ./holochain/default.nix { version = "0.3.2"; sha256 = "syzrXdVmiqVqvVC1DZQF+rkxLHkTMmTpJz8DylTMyU8="; };

  holochain_0-3-x = self.holochain_0-3-2;
  holochain_0-3 = self.createSymlink self.holochain_0-3-x "holochain-0.3";

  holochain_0-4-0-dev-1 = super.callPackage ./holochain/default.nix { version = "0.4.0-dev.1"; sha256 = "hSu6oidXEMESIxiFvFcnSwI7rjk6iM0XhOS1UJdh7Sw="; };
  holochain_0-4-0-dev-2 = super.callPackage ./holochain/default.nix { version = "0.4.0-dev.2"; sha256 = "H3hPT5jzPBOmMV9fPwarHiZzhi4hzLhWxf+HyHRcecs="; };
  holochain_0-4-0-dev-3 = super.callPackage ./holochain/default.nix { version = "0.4.0-dev.3"; sha256 = "1gUPIJgcfvVMoLhimmscY0rEttJrxxjOSaGyYqMtonU="; };
  holochain_0-4-0-dev-4 = super.callPackage ./holochain/default.nix { version = "0.4.0-dev.4"; sha256 = "zt3c3RbCgYL5/VD8MyFtjtZk3Hagkz22pXYWqy0CLIU="; };
  holochain_0-4-0-dev-5 = super.callPackage ./holochain/default.nix { version = "0.4.0-dev.5"; sha256 = "V+ur67qJj65949eaEn8fqhaeuKcdIcJoQ5ZU8FXlycg="; };
  holochain_0-4-0-dev-6 = super.callPackage ./holochain/default.nix { version = "0.4.0-dev.6"; sha256 = "llLW/drAhP3NJFqxgXT34zLieI1WZ9wzQ7Se328e5+o="; };
  holochain_0-4-0-dev-7 = super.callPackage ./holochain/default.nix { version = "0.4.0-dev.7"; sha256 = "Px8niMs0xW784HH2XmksunOWJUm+GgzQQUMn+zSVcVA="; };
  holochain_0-4-0-dev-8 = super.callPackage ./holochain/default.nix { version = "0.4.0-dev.8"; sha256 = "puFkAsU3yt5Il2q03D/FHezE8T8qHjjZ6MFx69G7TRk="; };
  holochain_0-4-0-dev-9 = super.callPackage ./holochain/default.nix { version = "0.4.0-dev.9"; sha256 = "CSrFxHr39zoa+NFTVRAV0M8glVfEvEmJv3SByR7gqHA="; };
  holochain_0-4-0-dev-10 = super.callPackage ./holochain/default.nix { version = "0.4.0-dev.10"; sha256 = "POl+Zu3QhI6LB3PN1bUVVKo1A0FiLSzCc8gX9Jwb/7M="; };
  holochain_0-4-0-dev-11 = super.callPackage ./holochain/default.nix { version = "0.4.0-dev.11"; sha256 = "ncS9Drru8qNcAt/KmW18CAnAiHYfwdcaiE2qAOseNIc="; };
  holochain_0-4-0-dev-12 = super.callPackage ./holochain/default.nix { version = "0.4.0-dev.12"; sha256 = "jQtswjO7d1nzaexr09ygmKGscXj9IRFJqXFQgnqFqPc="; };
  holochain_0-4-0-dev-13 = super.callPackage ./holochain/default.nix (
    self.selectArchConfig {
      version = "0.4.0-dev.13";
      linux_x64 = "Ub7Mj+XM50EYIWJonn3UD++dfkGUUssA8LxJTKuDbGs=";
      darwin_x64 = "Z5OmPR1/TXFW4NuRjGCEby4WMngW0ho/EdLXSwavs4I=";
      darwin_aarch64 = "KCzCf+vqMdAWk4GylCIp8ot13xN+61grxsje3DqL53A=";
      windows_x64 = "yeoJ40XqQ6oP8G9xKBNL13WGbc9sS9VpMCNk2rgAmcY=";
    }
  );
  holochain_0-4-0-dev-14 = super.callPackage ./holochain/default.nix (
    self.selectArchConfig {
      version = "0.4.0-dev.14";
      linux_x64 = "ckT0+aKOiGmgAlreS/cmMPu8pJyymiiybOwAgaZI/tI=";
      darwin_x64 = "RafQ+SuQ8FpIqNpRcE0LFW9+RlQMXIbC8R0cYe3+j2Y=";
      darwin_aarch64 = "8EXyGuFjS5kBycELDLpFIgbmcEOu2TDrz4738SLKJVM=";
      windows_x64 = "c4Tdv/6iUrPlU7SxdxI65Op7w7rb4bLeZkKOv/ZaUZ4=";
    }
  );
  holochain_0-4-0-dev-15 = super.callPackage ./holochain/default.nix (
    self.selectArchConfig {
      version = "0.4.0-dev.15";
      linux_x64 = "f5Mf3D1ih5W6dWUX5oa5Mgwl8HE1cf2/ITpoDx437Ks=";
      darwin_x64 = "5DMkJeB7AMGKi5whBmuL+wjAGr20lSxlaPY3ku+QGFE=";
      darwin_aarch64 = "MhPMgkgFqi7f44BgRqNPV5+be3W7CdnduBdnnxN7YNw=";
      windows_x64 = "C8Rmebd4J6ekH7uH3kUKxwADRAY/DhomQzxhcW7SbPw=";
    }
  );
  holochain_0-4-0-dev-16 = super.callPackage ./holochain/default.nix (
    self.selectArchConfig {
      version = "0.4.0-dev.16";
      linux_x64 = "gckMuZma6o42DUqmM+Z9HUid7hnYE594tjz/toj72DU=";
      darwin_x64 = "9Jkod3tXn030J0lKNpbNnJUzPh+8GbfdhEZ4+k3bpzY=";
      darwin_aarch64 = "a2OqPv9aIcbftLlDHCOPD7nKwiy2CQKmBA4+otV/4GQ=";
      windows_x64 = "l0SRO1SNhbPavmpxJkG6FqjPixIHKY4p6XZVUDmSWUc=";
    }
  );
  holochain_0-4-0-dev-17 = super.callPackage ./holochain/default.nix (
    self.selectArchConfig {
      version = "0.4.0-dev.17";
      linux_x64 = "/UviK1j5sHd5y+XMdRuEBhNCvze6ZJxjBLamBXa86YA=";
      darwin_x64 = "7B4HEdtvnFJgHEAtszljP1vo/Pb3naIIYUBcZE7OGT0=";
      darwin_aarch64 = "pLrgismrY9r6oCFQgQa42U0iLz5WcHfkNvQFsQgi0BM=";
      windows_x64 = "XblHxQiUBDVtkyKhTjSrkEsAaQU+e1LJ1QrjC5hRbMw=";
    }
  );
  holochain_0-4-0-dev-18 = super.callPackage ./holochain/default.nix (
    self.selectArchConfig {
      version = "0.4.0-dev.18";
      linux_x64 = "/wFiI0LWY9xc+eVpiZksG+wKKEFazBsWyznrlRR0Yfo=";
      darwin_x64 = "u78BfZlQMa2XC+2ykIQo98cEUgX40COEtnh4Arg1bJA=";
      darwin_aarch64 = "uR1U/T8BzHxrrRxFqT1N/0Aahz+FEd4tPzqa+J7zZYM=";
      windows_x64 = "bBwYu09Zb7XLbRG2TI4ecfOB4ZI0sfkRWFEpoRdF2cM=";
    }
  );
  holochain_0-4-0-dev-20 = super.callPackage ./holochain/default.nix (
    self.selectArchConfig {
      version = "0.4.0-dev.20";
      linux_x64 = "MfT8Ch+vYVTKF8bqc3gvfdfAIe3YjVmRTVYM+7V3TOw=";
      darwin_x64 = "7+3R+lTzzu/rGHbbJUZpHtTUJj23GztPanUH772AnIU=";
      darwin_aarch64 = "kjlALv8jVVIjTa7rSCzjyPxlAyQ64fRqY8iRzgMaOXE=";
      windows_x64 = "Ek7Hzz+S6lp9fNfavc6N8yL+aoI/eK+u4IC6sF4iTYU=";
    }
  );
  # holochain_0-4-0-dev-21 = super.callPackage ./holochain/default.nix (
  # Missing linux binary
  # );
  holochain_0-4-0-dev-22 = super.callPackage ./holochain/default.nix (
    self.selectArchConfig {
      version = "0.4.0-dev.22";
      linux_x64 = "JG/kK/aKAi6z9YIN+Kh0qewgo8p5nO2iPalOntVPrHE=";
      darwin_x64 = "PmRBpShf1vtAuSx/vb7KHSULA7tr8JaumprkGNUCv/s=";
      darwin_aarch64 = "WuIQwVUrPUUyCSNChzV1dRJUL3wJsBEhyW3YvK2iB6o=";
      windows_x64 = "cvUjbE84R/oX9JONprTd+U/j6JZO1vTq8eciT8SwCBI=";
    }
  );
  holochain_0-4-0-dev-23 = super.callPackage ./holochain/default.nix (
    self.selectArchConfig {
      version = "0.4.0-dev.23";
      linux_x64 = "tHgIvCwMuZZtr+ECR3mfV5fQqR5QUxmLvt0zhVttJaA=";
      darwin_x64 = "iBHd2CdsA83X+A6IsT6iH3ojv3KxM8thbhjbgejQTf4=";
      darwin_aarch64 = "uSQ0OpbCHytF3EHsbNVrtN7QiFHKYFAnyh2jK73qAN8=";
      windows_x64 = "lvdFNMQuTPnoCizoh9CZ8SEwl8f9xWjOaXV3UAud+Es=";
    }
  );
  holochain_0-4-0-dev-24 = super.callPackage ./holochain/default.nix (
    self.selectArchConfig {
      version = "0.4.0-dev.24";
      linux_x64 = "MTa8aenFC0VKolb+Ti+ZMACgcrv6tSj+ZMgUL+FAl54=";
      darwin_x64 = "oUa3lY4rKxub/MgYsFHTLJOBMh9LoD/Q/PsHZk+qNRk=";
      darwin_aarch64 = "iw/hxCpSQViNKwSnKWw/RZWDZ63mdTCe7Uw5qJrZORQ=";
      windows_x64 = "MC+DqGGwjH9bOx+Fi7yhUXDJtt5oWaiFBUbk71pH9rM=";
    }
  );
  holochain_0-4-0-dev-25 = super.callPackage ./holochain/default.nix (
    self.selectArchConfig {
      version = "0.4.0-dev.25";
      linux_x64 = "d5wa4Pe+LX2K24AY/rXCViwOLVIAT23aafuVDPRD6g8=";
      darwin_x64 = "zoezLDviRKHOvtn169ASft5enAk5pTEK5kBHiGJZ85k=";
      darwin_aarch64 = "CdU7nycNnw1ctNbP6MOFRkJFElIgwyOHhud6RuHU5l0=";
      windows_x64 = "4EY8sO3fpw10IySW8hNpQsdZmVeCdFgRH9bmwTPmDXc=";
    }
  );
  holochain_0-4-0-dev-26 = super.callPackage ./holochain/default.nix (
    self.selectArchConfig {
      version = "0.4.0-dev.26";
      linux_x64 = "W0e+NYyOlx/Oyo+P9f4zlG+l9LehHB+6r7ngTgS4++4=";
      darwin_x64 = "0STNTaofYtFQfq5mHOaG8j6eoV9zCml8oBGIel0phL8=";
      darwin_aarch64 = "JrpvJc52HM4JUj6IpIsq7D3huawxAd3imMM6txe1yHo=";
      windows_x64 = "pKySJFFIIItg72JIYxlrV6odUv9uHxEflYXoRbRqgKE=";
    }
  );
  holochain_0-4-0-dev-27 = super.callPackage ./holochain/default.nix (
    self.selectArchConfig {
      version = "0.4.0-dev.27";
      linux_x64 = "Kva+mVQpGWwBXjcdzDyqvZl/Dzas3Yc6ZpSaXPKrC9c=";
      darwin_x64 = "+037vfXK/+hq/AVdCLJu2ZBHneAqzf4TmOXCP6gmjWM=";
      darwin_aarch64 = "ms1etvOrH5lK/iFR0m94vIBLUnOWfu+QtU92vRKZLyM=";
      windows_x64 = "v4Ntf4zCFs4fYM2rFf0h1rHTxapI/c+A7Qo+H2qPRlE=";
    }
  );

  holochain_0-4-x = self.holochain_0-4-0-dev-27;
  holochain_0-4 = self.createSymlink self.holochain_0-4-x "holochain-0.4";

  holochain_0-x = self.holochain_0-3-x;
  holochain_0 = self.createSymlink self.holochain_0-x "holochain-0";

  holochain_x = self.holochain_0-x;
  holochain = self.createSymlink self.holochain_x "holochain";


  lair-keystore_0-4-2 = super.callPackage ./lair-keystore/default.nix { version = "0.4.2"; sha256 = "Q4AvHOvW5800eFcj8Di+9CUflMBELl83BASEdrNLB0A="; };
  lair-keystore_0-4-3 = super.callPackage ./lair-keystore/default.nix { version = "0.4.3"; sha256 = "R1H4HA5LL9axFe/bFJ9hq2iX7BOOug2vdWqyKFbyGO8="; };
  lair-keystore_0-4-4 = super.callPackage ./lair-keystore/default.nix { version = "0.4.4"; sha256 = "KVx0P/KmxVag0fboriAzoBtgeEW8D0wzhZv4WTEHpCo="; };
  lair-keystore_0-4-5 = super.callPackage ./lair-keystore/default.nix (
    self.selectArchConfig {
      version = "0.4.5";
      linux_x64 = "Z7Wo0GV1/BTGKV/sBc0tzTON52oFHOrG3XsD6SHuF2I=";
      darwin_x64 = "YMgRBLuqN+aXSaf1OwedBkFNB0GKFRSjxnZQPOKGHEo=";
      darwin_aarch64 = "9uQnVXJx0TqzK92GcvBAi4skgReECtxkyFjVWmrlZYM=";
      windows_x64 = "d8tOUamBYEhSCjApN2AhRIOgo3KrVUrUlpVRZ+YAnJk=";
    }
  );
  lair-keystore_0-5-0 = super.callPackage ./lair-keystore/default.nix (
    self.selectArchConfig {
      version = "0.5.0";
      linux_x64 = "DZv04RctitdXXo57BjqpqbB9chz/kcJChPfBUKaLF4E=";
      darwin_x64 = "eQi7Nd8hI6Fo8li2f1/TfloE23umgrvsZNCVu9xqHKs=";
      darwin_aarch64 = "MT7iPNx8p9gz9pCeW2r7bqSxvO+Qsxn5gRIbaccO+qo=";
      windows_x64 = "hCiMgwLhgeHI5JCp/f9t68XbkYKflZ7ns2cFDxHP3UQ=";
    }
  );
  lair-keystore_0-5-1 = super.callPackage ./lair-keystore/default.nix (
    self.selectArchConfig {
      version = "0.5.1";
      linux_x64 = "e0FeYdLlfbyHNpjD9g6nmTjinmDbLE/L1iFduUvYSjo=";
      darwin_x64 = "8VkBlhTIFex/vyD8InAF1MnvCdkYbDJ9LxpWEVDoXvA=";
      darwin_aarch64 = "BzJoJD1OmMLm76xosxa8pnSAYHmCdnzEdEVq4Vg4asE=";
      windows_x64 = "Lmz/chrzM9OFlCQtbA+AHyCG1uT5Tv1H+JwfCIcpvbc=";
    }
  );
  lair-keystore_0-5-2 = super.callPackage ./lair-keystore/default.nix (
    self.selectArchConfig {
      version = "0.5.2";
      linux_x64 = "X6Gy7OiJYgjDE8AbUx2Z2GHhVt6PLS3cJwmoK8JTNVA=";
      darwin_x64 = "IsrftzQ1zgyX5lgRI7T8P+n/Cl71sE7tO0iVqE9cu3k=";
      darwin_aarch64 = "JGuxCQ6eh1ur4FbfQT91rY3Ruklx8pPdXpTqBeo2SqA=";
      windows_x64 = "QqSm6vPNHLUr3GUSs5LodEZ7xtf1djuJowN2ep2Xmtk=";
    }
  );

  lair-keystore_0-4-x = self.lair-keystore_0-4-5;
  lair-keystore_0-4 = self.createSymlink self.lair-keystore_0-4-x "lair-keystore-0.4";

  lair-keystore_0-5-x = self.lair-keystore_0-5-2;
  lair-keystore_0-5 = self.createSymlink self.lair-keystore_0-5-x "lair-keystore-0.5";

  lair-keystore_0-x = self.lair-keystore_0-5-x;
  lair-keystore_0 = self.createSymlink self.lair-keystore_0-x "lair-keystore-0";

  lair-keystore_x = self.lair-keystore_0-x;
  lair-keystore = self.createSymlink self.lair-keystore_x "lair-keystore";


  hc_0-2-8 = super.callPackage ./hc/default.nix { version = "0.2.8"; sha256 = "97RJfx5JM+kJ1WU1M63ty+Ga7A/ohWOJ9r1qoL/AASY="; };

  hc_0-2-x = self.hc_0-2-8;
  hc_0-2 = self.createSymlink self.hc_0-2-x "hc-0.2";

  hc_0-3-0-beta-dev-47 = super.callPackage ./hc/default.nix { version = "0.3.0-beta-dev.47"; sha256 = "ctkBtXog3+HF2pfpYMiyLhApptwGevD0ve17RSKfttA="; };
  hc_0-3-1 = super.callPackage ./hc/default.nix { version = "0.3.1"; sha256 = "6zccpmpOBisxd3REzEfM58iZgiFZ3H5NvWdtYKrAC3k="; };
  hc_0-3-2 = super.callPackage ./hc/default.nix { version = "0.3.2"; sha256 = "dD5lKhHR0kPLNXLGl528Oc+4hBdPQWX8MmpMsmfDQs8="; };

  hc_0-3-x = self.hc_0-3-2;
  hc_0-3 = self.createSymlink self.hc_0-3-x "hc-0.3";

  hc_0-4-0-dev-0 = super.callPackage ./hc/default.nix { version = "0.4.0-dev.0"; sha256 = "vQSeazkmySI4sSVy2EGi60LUtv1uyYdg3/TfsKVYei0="; };
  hc_0-4-0-dev-1 = super.callPackage ./hc/default.nix { version = "0.4.0-dev.1"; sha256 = "KjvDf+1/p2qaw2Y5f3lg7OVcdSm11qJIBAakHwz5iLA="; };
  hc_0-4-0-dev-2 = super.callPackage ./hc/default.nix { version = "0.4.0-dev.2"; sha256 = "OaoonW5ZHcCVhhNjPywY1jaLv6ajQckz3bkDKk3BI+8="; };
  hc_0-4-0-dev-3 = super.callPackage ./hc/default.nix { version = "0.4.0-dev.3"; sha256 = "CW37nfE4ueps2Qyr+9Pogg7u/BAN5dar5x/UJSBxJ1w="; };
  hc_0-4-0-dev-4 = super.callPackage ./hc/default.nix { version = "0.4.0-dev.4"; sha256 = "CPbvJFkcNQR4YcHWGE9O3+G/EorNA0JSsH5AOJN/Ung="; };
  hc_0-4-0-dev-5 = super.callPackage ./hc/default.nix { version = "0.4.0-dev.5"; sha256 = "ozp5k0HxtSJU4Cs3MVQw6YfV0NkFVKiE5B0afrHA/34="; };
  hc_0-4-0-dev-6 = super.callPackage ./hc/default.nix { version = "0.4.0-dev.6"; sha256 = "PXoouZJc5fepzeHRZmIKbR5suszjdgEYl3gmUlnjQvg="; };
  hc_0-4-0-dev-7 = super.callPackage ./hc/default.nix { version = "0.4.0-dev.7"; sha256 = "9ZHEpG7HuzxfFnC+KMjkDQ5RmKhbpCZo67Y/HVlJUOs="; };
  hc_0-4-0-dev-8 = super.callPackage ./hc/default.nix { version = "0.4.0-dev.8"; sha256 = "6AItiC2kM8bGYmrm5C1EHlIP9tVYFB3oiiVVJt5FKJE="; };
  hc_0-4-0-dev-9 = super.callPackage ./hc/default.nix { version = "0.4.0-dev.9"; sha256 = "usxUMqHF3Onr9YQ6bSvjYs2f+NiQ2mEeRmE81tIGhWQ="; };
  hc_0-4-0-dev-10 = super.callPackage ./hc/default.nix { version = "0.4.0-dev.10"; sha256 = "iFPxtUYPw3qw6DcQNd2kUPko2bWqKHqZe7eQvYkAukg="; };
  hc_0-4-0-dev-11 = super.callPackage ./hc/default.nix { version = "0.4.0-dev.11"; sha256 = "7AWGvEYRA7MuEzXbCbxIY3HSDFJmxiq2wMUqoXDruaM="; };
  hc_0-4-0-dev-12 = super.callPackage ./hc/default.nix { version = "0.4.0-dev.12"; sha256 = "iWrApgqni5S+tI9SpPxbIJw5EdIQrzX/xM+50jOk/4k="; };
  hc_0-4-0-dev-13 = super.callPackage ./hc/default.nix (
    self.selectArchConfig {
      version = "0.4.0-dev.13";
      linux_x64 = "/OdBIq8hhePmnQ6FXbt4jD6+4Pm+KIfPHCfd1mgAF8s=";
      darwin_x64 = "iUcUdQak6hCyBzvH7cHvHxuVhs6b14KLQkNnaNfe6mE=";
      darwin_aarch64 = "gwzLxNimwM1pgG/+jetX6QLfZj0pKYPh3X636H0gB8w=";
      windows_x64 = "d3RMBeNpkxKaGz0KTHxfrNmlyB1H0ZAeW4Li2U9nfcI=";
    }
  );
  hc_0-4-0-dev-14 = super.callPackage ./hc/default.nix (
    self.selectArchConfig {
      version = "0.4.0-dev.14";
      linux_x64 = "1HlzhtFoU0MrVXnXgZbtvCoQp+oPE1c6yMPUCrliD5g=";
      darwin_x64 = "1PyX6nJlxQ7kT9QDNzNGkBI4Rf0wmXZF5RBUjgcGM4o=";
      darwin_aarch64 = "bmmqphb5x04x/OR91yeONzQ6fMiRd2317AGuHpou1n0=";
      windows_x64 = "FbN+4e8EGdXUdDtpameBN8iTKmyS6ajBx3ZTIBzsF+g=";
    }
  );
  hc_0-4-0-dev-15 = super.callPackage ./hc/default.nix (
    self.selectArchConfig {
      version = "0.4.0-dev.15";
      linux_x64 = "YHLzk5Rr5NVL/Aoi+MqL8uA9wR9YQpoCa+htzzVfiZM=";
      darwin_x64 = "NURYLoNEqTXqDf69mF/vHsOXUXqGgJ0Hy2wDdWA3PZQ=";
      darwin_aarch64 = "NOO8z4R/0uTBDcHOevczteruWg3SMzmHCK8etXXSGZI=";
      windows_x64 = "h2k0mnrGPeho1RPR9Lm5Z9rBMqTPWEekVMKZ4gNICys=";
    }
  );
  hc_0-4-0-dev-16 = super.callPackage ./hc/default.nix (
    self.selectArchConfig {
      version = "0.4.0-dev.16";
      linux_x64 = "VfrSFjRVKppIs7eseZnjZm1CroEn42w0RlcwX2BU0i8=";
      darwin_x64 = "U/L6nvKzAsSOA87TR8s4BlHH9an+ufSV+UUz8QdaZNY=";
      darwin_aarch64 = "/vvdqW5l+iSL5zq0dzYZxgbH8Puu2uQyHeN+Cu96h1A=";
      windows_x64 = "+1gzsvfPCs2fmQXR9GdOzn8czzu1QBr+gZEAMUarSWw=";
    }
  );
  hc_0-4-0-dev-17 = super.callPackage ./hc/default.nix (
    self.selectArchConfig {
      version = "0.4.0-dev.17";
      linux_x64 = "MFwbHhw9e6OcFFNtClvGviBK+aMth6mHGiHgHe6sQnU=";
      darwin_x64 = "pvO5Z0h30OUSZ7sokPhqSE0iUbqsiGR8wIowjepKXPc=";
      darwin_aarch64 = "sXhdWp5hCRd3RGNOiwqqYHoBtkvRlBlPJKJf9orI5pA=";
      windows_x64 = "+/1uvAGVtnm76TubQX272FoKFEPpX5XivdHEKzEh2h0=";
    }
  );
  hc_0-4-0-dev-18 = super.callPackage ./hc/default.nix (
    self.selectArchConfig {
      version = "0.4.0-dev.18";
      linux_x64 = "58tepf6pYha4n8cnkG2g3hsQf+SofIz4+/QQsDmUKbk=";
      darwin_x64 = "ufFHH394I7nsaWxS4meTgwzeImG/X8CFlf3jzD7bIO0=";
      darwin_aarch64 = "MS8q+385/bf74zh2qwX6HnGYbpmV+6kDs41UX97ofZY=";
      windows_x64 = "jJ1YqBsnjx2nbd3DBxOXBzw4CcLnr82g+Nw+mQchyhY=";
    }
  );
  hc_0-4-0-dev-19 = super.callPackage ./hc/default.nix (
    self.selectArchConfig {
      version = "0.4.0-dev.19";
      linux_x64 = "s+cJs/LSiwaoCtIo7Bjte6z9XMzfJsJl6ySCh2CJtm8=";
      darwin_x64 = "QtDvRAw9ClmVOFw3nn9SaI82v/YIoWr6iJQCKKpiXEI=";
      darwin_aarch64 = "VSTPr/345BvzcPQpChku3nagEpVtBH42S98xp7Fy0ts=";
      windows_x64 = "+LduQgfjR8kWY8CZN4IQDVuZ+1ANy9tIXBzb43wsCBc=";
    }
  );
  hc_0-4-0-dev-20 = super.callPackage ./hc/default.nix (
    self.selectArchConfig {
      version = "0.4.0-dev.20";
      linux_x64 = "WTwQCDOkANJbPteIxF1OXW0GZaI0G0r29pXKWGdUJ60=";
      darwin_x64 = "bGQZYWrkdV23n0+Cr+kycFvMcgQPrnhKGjQ+BrxBmD0=";
      darwin_aarch64 = "a3+Y4x/PUTZU/i2vSWibPH9w0eATE5PRB4nuI4IYHqw=";
      windows_x64 = "IP4NZTUbfQleE8/PKCK6rszvJMygLkpNAvzOIyRubqA=";
    }
  );
  hc_0-4-0-dev-21 = super.callPackage ./hc/default.nix (
    self.selectArchConfig {
      version = "0.4.0-dev.21";
      linux_x64 = "dgEqVo92kY2DdHujq1yjgj3lgXpGwwbUxmleQmUmHg0=";
      darwin_x64 = "M2N14DVrPsjWJj8JH0tJQRp/4jz4HyeqCdyL7b0McgA=";
      darwin_aarch64 = "Sd417NlLMBBQzO1KsPFAlDYtQgP3dcLnmdErQWDfijg=";
      windows_x64 = "5KbVKrY5Vhf0Xui9weGCZYOOKKnY+dxHW3aXesrDLcQ=";
    }
  );
  hc_0-4-0-dev-22 = super.callPackage ./hc/default.nix (
    self.selectArchConfig {
      version = "0.4.0-dev.22";
      linux_x64 = "p+Aep6mzDhay/t408AJDedzSfeQ4IrxLfZFUrp90a5Q=";
      darwin_x64 = "HOeYMepzcZB/x2o+jR14HEhzpVw4xvPONvPaKcyvYfc=";
      darwin_aarch64 = "PCMhoBpGiStmq0ttsz4Kzq0gGIXihV6LiMSziEiW92c=";
      windows_x64 = "uHKY87wt5KxyGcm0EuJ1xeZSRTDk8CZ6vAZwYaTgdYk=";
    }
  );
  hc_0-4-0-dev-23 = super.callPackage ./hc/default.nix (
    self.selectArchConfig {
      version = "0.4.0-dev.23";
      linux_x64 = "emQ4biUpLy4LixU+dUXX4v4Lnc0+OvCDE6nRNHCBRgc=";
      darwin_x64 = "EP5wlxiQ1dtKeB8p+1H/08oc9eFyqzY8dNS29nQhqXk=";
      darwin_aarch64 = "cGm/gp0zjEjk568B53JvM+Dh1hJ0GzZj4Vq/SPp7uRw=";
      windows_x64 = "EU09awsxWiOxseObw+R/3OrIo+Bc2ldzhsEbym9z3Iw=";
    }
  );
  hc_0-4-0-dev-24 = super.callPackage ./hc/default.nix (
    self.selectArchConfig {
      version = "0.4.0-dev.24";
      linux_x64 = "riWvARqdanb/NJYJf365bSn8ZLuihxxmOLIxsQnbtWg=";
      darwin_x64 = "lKSpGYdEXtUE2X2Aof7Fu+raFdNpIYjYJkBUoyzxUA4=";
      darwin_aarch64 = "vF54bHCb4og/DcQ1wxJxtvCgqGFyxrfB1N4I40/1HBg=";
      windows_x64 = "KCXthhfDWgLJ/yMQbm6CYZ4TSeVoevI7Ac/hXj1N9CE=";
    }
  );
  hc_0-4-0-dev-25 = super.callPackage ./hc/default.nix (
    self.selectArchConfig {
      version = "0.4.0-dev.25";
      linux_x64 = "4TLwgkST9g4Tdt23AdAczIpwuLWzFGtjPxWwttJ4Jv4=";
      darwin_x64 = "M3Q5oAlxoXHktWlmKB+YFZtQrEOyaZiBwUqP5RVefz8=";
      darwin_aarch64 = "rnjA79jhBKG1EvsW7qXi0ocGZgNKMYUJob6lyVvHGQA=";
      windows_x64 = "kXGPHGifk/BTWN4ns+bT1KeoWs+YjLRjB36Sz9nqC3I=";
    }
  );
  hc_0-4-0-dev-26 = super.callPackage ./hc/default.nix (
    self.selectArchConfig {
      version = "0.4.0-dev.26";
      linux_x64 = "4b9BXA3h0bTLuKcumsxcEAW4PrD74oGDu1EbzD7akzk=";
      darwin_x64 = "dxgL73NJGzV/5uTOIbfLth7g+PByIOtvrMbNT4yegaw=";
      darwin_aarch64 = "IwZaOKieHqBRALmpFJd9xWgJgt1iXdb1KowrwVLUbWE=";
      windows_x64 = "FGtoEgAdRpdKx8j6GU7A4Ko4tp3otRa4HpeCQzGBSU0=";
    }
  );
  hc_0-4-0-dev-27 = super.callPackage ./hc/default.nix (
    self.selectArchConfig {
      version = "0.4.0-dev.27";
      linux_x64 = "kDatAC28sQdOxT1uWe159A7+nonniG0agQkRKJAzDik=";
      darwin_x64 = "HNLzKgLcVWiDERLckNu8C57YXnWb9Ta3QvnL2sr3mqs=";
      darwin_aarch64 = "E+7dWEuUTl+1H5ypimuWBQHl1pHRyoiCEwaHIjsFtD0=";
      windows_x64 = "poEE813SKeRjzo09hFW+BE9JkZzEAMRm2WHG3G7bBYw=";
    }
  );

  hc_0-4-x = self.hc_0-4-0-dev-27;
  hc_0-4 = self.createSymlink self.hc_0-4-x "hc-0.4";

  hc_0-x = self.hc_0-3-x;
  hc_0 = self.createSymlink self.hc_0-x "hc-0";

  hc_x = self.hc_0-x;
  hc = self.createSymlink self.hc_x "hc";
}
