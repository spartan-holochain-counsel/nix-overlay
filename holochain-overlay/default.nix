self: super: {
  # 0000000000000000000000000000000000000000000=

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

  holochain_0-3-x = self.holochain_0-3-1;
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

  holochain_0-4-x = self.holochain_0-4-0-dev-15;
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

  lair-keystore_0-4-x = self.lair-keystore_0-4-5;
  lair-keystore_0-4 = self.createSymlink self.lair-keystore_0-4-x "lair-keystore-0.4";

  lair-keystore_0-x = self.lair-keystore_0-4-x;
  lair-keystore_0 = self.createSymlink self.lair-keystore_0-x "lair-keystore-0";

  lair-keystore_x = self.lair-keystore_0-x;
  lair-keystore = self.createSymlink self.lair-keystore_x "lair-keystore";


  hc_0-2-8 = super.callPackage ./hc/default.nix { version = "0.2.8"; sha256 = "97RJfx5JM+kJ1WU1M63ty+Ga7A/ohWOJ9r1qoL/AASY="; };

  hc_0-2-x = self.hc_0-2-8;
  hc_0-2 = self.createSymlink self.hc_0-2-x "hc-0.2";

  hc_0-3-0-beta-dev-47 = super.callPackage ./hc/default.nix { version = "0.3.0-beta-dev.47"; sha256 = "ctkBtXog3+HF2pfpYMiyLhApptwGevD0ve17RSKfttA="; };
  hc_0-3-1 = super.callPackage ./hc/default.nix { version = "0.3.1"; sha256 = "6zccpmpOBisxd3REzEfM58iZgiFZ3H5NvWdtYKrAC3k="; };
  hc_0-3-2 = super.callPackage ./hc/default.nix { version = "0.3.2"; sha256 = "dD5lKhHR0kPLNXLGl528Oc+4hBdPQWX8MmpMsmfDQs8="; };

  hc_0-3-x = self.hc_0-3-1;
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

  hc_0-4-x = self.hc_0-4-0-dev-15;
  hc_0-4 = self.createSymlink self.hc_0-4-x "hc-0.4";

  hc_0-x = self.hc_0-3-x;
  hc_0 = self.createSymlink self.hc_0-x "hc-0";

  hc_x = self.hc_0-x;
  hc = self.createSymlink self.hc_x "hc";
}
