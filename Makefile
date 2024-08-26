
RESET   = \033[0m
WHITE   = \033[37m
PURPLE  = \033[35m
YELLOW  = \033[33m

define holochain_url
https://github.com/matthme/holochain-binaries/releases/download/holochain-binaries-$(1)/holochain-v$(1)-$(2)
endef

define hc_url
https://github.com/matthme/holochain-binaries/releases/download/hc-binaries-$(1)/hc-v$(1)-$(2)
endef

define lair_url
https://github.com/matthme/holochain-binaries/releases/download/lair-binaries-$(1)/lair-keystore-v$(1)-$(2)
endef

define convert_hash
nix hash convert --hash-algo sha256 --from nix32 --to base64 $(1)
endef

LINUX_X86_SUFFIX	= x86_64-unknown-linux-gnu
DARWIN_X86_SUFFIX	= x86_64-apple-darwin
DARWIN_AARCH_SUFFIX	= aarch64-apple-darwin
WINDOWS_X86_SUFFIX	= x86_64-pc-windows-msvc.exe

calc-holochain-sha256-hashes:
	@echo "$(WHITE)Linux x86$(RESET)";\
		linux_x86_hash=$$( $(call convert_hash, $$(nix-prefetch-url $(call holochain_url,$(VERSION),$(LINUX_X86_SUFFIX))) ));\
	echo "$(WHITE)Darwin x86$(RESET)";\
		darwin_x86_hash=$$( $(call convert_hash, $$(nix-prefetch-url $(call holochain_url,$(VERSION),$(DARWIN_X86_SUFFIX))) ));\
	echo "$(WHITE)Darwin aarch64$(RESET)";\
		darwin_aarch_hash=$$( $(call convert_hash, $$(nix-prefetch-url $(call holochain_url,$(VERSION),$(DARWIN_AARCH_SUFFIX))) ));\
	echo "$(WHITE)Windows x86$(RESET)";\
		windows_x86_hash=$$( $(call convert_hash, $$(nix-prefetch-url $(call holochain_url,$(VERSION),$(WINDOWS_X86_SUFFIX))) ));\
	echo "\n$(WHITE)Copy into default.nix configuration:$(RESET)\n\nself.selectArchConfig {\n\
  version = \"$(VERSION)\";\n\
  linux_x64 = \"$$linux_x86_hash\";\n\
  darwin_x64 = \"$$darwin_x86_hash\";\n\
  darwin_aarch64 = \"$$darwin_aarch_hash\";\n\
  windows_x64 = \"$$windows_x86_hash\";\n\
}";

calc-hc-sha256-hashes:
	@echo "$(WHITE)Linux x86$(RESET)";\
		linux_x86_hash=$$( $(call convert_hash, $$(nix-prefetch-url $(call hc_url,$(VERSION),$(LINUX_X86_SUFFIX))) ));\
	echo "$(WHITE)Darwin x86$(RESET)";\
		darwin_x86_hash=$$( $(call convert_hash, $$(nix-prefetch-url $(call hc_url,$(VERSION),$(DARWIN_X86_SUFFIX))) ));\
	echo "$(WHITE)Darwin aarch64$(RESET)";\
		darwin_aarch_hash=$$( $(call convert_hash, $$(nix-prefetch-url $(call hc_url,$(VERSION),$(DARWIN_AARCH_SUFFIX))) ));\
	echo "$(WHITE)Windows x86$(RESET)";\
		windows_x86_hash=$$( $(call convert_hash, $$(nix-prefetch-url $(call hc_url,$(VERSION),$(WINDOWS_X86_SUFFIX))) ));\
	echo "\n$(WHITE)Copy into default.nix configuration:$(RESET)\n\nself.selectArchConfig {\n\
  version = \"$(VERSION)\";\n\
  linux_x64 = \"$$linux_x86_hash\";\n\
  darwin_x64 = \"$$darwin_x86_hash\";\n\
  darwin_aarch64 = \"$$darwin_aarch_hash\";\n\
  windows_x64 = \"$$windows_x86_hash\";\n\
}";

calc-lair-sha256-hashes:
	@echo "$(WHITE)Linux x86$(RESET)";\
		linux_x86_hash=$$( $(call convert_hash, $$(nix-prefetch-url $(call lair_url,$(VERSION),$(LINUX_X86_SUFFIX))) ));\
	echo "$(WHITE)Darwin x86$(RESET)";\
		darwin_x86_hash=$$( $(call convert_hash, $$(nix-prefetch-url $(call lair_url,$(VERSION),$(DARWIN_X86_SUFFIX))) ));\
	echo "$(WHITE)Darwin aarch64$(RESET)";\
		darwin_aarch_hash=$$( $(call convert_hash, $$(nix-prefetch-url $(call lair_url,$(VERSION),$(DARWIN_AARCH_SUFFIX))) ));\
	echo "$(WHITE)Windows x86$(RESET)";\
		windows_x86_hash=$$( $(call convert_hash, $$(nix-prefetch-url $(call lair_url,$(VERSION),$(WINDOWS_X86_SUFFIX))) ));\
	echo "\n$(WHITE)Copy into default.nix configuration:$(RESET)\n\nself.selectArchConfig {\n\
  version = \"$(VERSION)\";\n\
  linux_x64 = \"$$linux_x86_hash\";\n\
  darwin_x64 = \"$$darwin_x86_hash\";\n\
  darwin_aarch64 = \"$$darwin_aarch_hash\";\n\
  windows_x64 = \"$$windows_x86_hash\";\n\
}";
