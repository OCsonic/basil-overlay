# Copyright 2024 Basil
# Distributed under the terms of the BSD-3-Clause-CA-AD-v1.0 License

EAPI=7
CRATES="
	adler-1.0.2
	aes-0.8.3
	android-tzdata-0.1.1
	android_system_properties-0.1.5
	autocfg-1.1.0
	base64ct-1.6.0
	bitflags-1.3.2
	block-buffer-0.10.4
	bumpalo-3.13.0
	bwrap-1.3.0
	byteorder-1.4.3
	bzip2-0.4.4
	bzip2-sys-0.1.11+1.0.8
	cc-1.0.83
	cfg-if-1.0.0
	chrono-0.4.26
	cipher-0.4.4
	constant_time_eq-0.1.5
	content_inspector-0.2.4
	core-foundation-sys-0.8.4
	cpufeatures-0.2.9
	crc-3.0.1
	crc-catalog-2.2.0
	crc32fast-1.3.2
	crossbeam-channel-0.5.8
	crossbeam-deque-0.8.3
	crossbeam-epoch-0.9.15
	crossbeam-utils-0.8.16
	crossterm-0.26.1
	crossterm_winapi-0.9.1
	crypto-common-0.1.6
	deranged-0.3.8
	devtimer-4.0.1
	digest-0.10.7
	dirs-5.0.1
	dirs-sys-0.4.1
	either-1.9.0
	equivalent-1.0.1
	filetime-0.2.22
	flate2-1.0.27
	generic-array-0.14.7
	getrandom-0.2.10
	hashbrown-0.14.0
	hermit-abi-0.3.2
	hmac-0.12.1
	iana-time-zone-0.1.57
	iana-time-zone-haiku-0.1.2
	indexmap-2.0.0
	inout-0.1.3
	itoa-1.0.9
	jobserver-0.1.26
	js-sys-0.3.64
	libc-0.2.147
	lock_api-0.4.10
	log-0.4.20
	lzma-rs-0.3.0
	memchr-2.5.0
	memoffset-0.7.1
	memoffset-0.9.0
	miniz_oxide-0.7.1
	mio-0.8.8
	natord-1.0.9
	nix-0.26.2
	num-traits-0.2.16
	num_cpus-1.16.0
	num_threads-0.1.6
	once_cell-1.18.0
	option-ext-0.2.0
	parking_lot-0.12.1
	parking_lot_core-0.9.8
	password-hash-0.4.2
	pbkdf2-0.11.0
	pin-utils-0.1.0
	pkg-config-0.3.27
	proc-macro2-1.0.66
	quote-1.0.33
	rand_core-0.6.4
	rayon-1.7.0
	rayon-core-1.11.0
	redox_syscall-0.2.16
	redox_syscall-0.3.5
	redox_users-0.4.3
	ryu-1.0.15
	same-file-1.0.6
	scopeguard-1.2.0
	serde-1.0.186
	serde_derive-1.0.186
	serde_yaml-0.9.25
	sha1-0.10.5
	sha2-0.10.7
	signal-hook-0.3.17
	signal-hook-mio-0.2.3
	signal-hook-registry-1.4.1
	simplelog-0.12.1
	smallvec-1.11.0
	static_assertions-1.1.0
	subtle-2.5.0
	syn-2.0.29
	tar-0.4.40
	termcolor-1.1.3
	thiserror-1.0.47
	thiserror-impl-1.0.47
	time-0.3.27
	time-core-0.1.1
	time-macros-0.2.13
	typenum-1.16.0
	unicode-ident-1.0.11
	unicode-width-0.1.10
	unsafe-libyaml-0.2.9
	version_check-0.9.4
	walkdir-2.3.3
	wasi-0.11.0+wasi-snapshot-preview1
	wasm-bindgen-0.2.87
	wasm-bindgen-backend-0.2.87
	wasm-bindgen-macro-0.2.87
	wasm-bindgen-macro-support-0.2.87
	wasm-bindgen-shared-0.2.87
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	windows-0.48.0
	windows-sys-0.48.0
	windows-targets-0.48.5
	windows_aarch64_gnullvm-0.48.5
	windows_aarch64_msvc-0.48.5
	windows_i686_gnu-0.48.5
	windows_i686_msvc-0.48.5
	windows_x86_64_gnu-0.48.5
	windows_x86_64_gnullvm-0.48.5
	windows_x86_64_msvc-0.48.5
	xattr-1.0.1
	zip-0.6.6
	zstd-0.11.2+zstd.1.5.2
	zstd-0.12.4
	zstd-safe-5.0.2+zstd.1.5.2
	zstd-safe-6.0.6
	zstd-sys-2.0.8+zstd.1.5.5
"
inherit cargo

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/kyoheiu/${PN}.git"
else
	KEYWORDS="-* -x86 ~amd64 -arm -arm64"
	SRC_URI="https://github.com/kyoheiu/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	SRC_URI+=" $(cargo_crate_uris)"
fi
DESCRIPTION="TUI file manager with vim-like key mapping"
HOMEPAGE="https://kyoheiu.dev/felix/"
LICENSE="MIT"
SLOT="0"

IUSE="custom-rustflags"

BDEPEND=""
DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	if [[ ${PV} == *9999 ]]; then
		git-r3_src_unpack
		cargo_live_src_unpack
	else
		cargo_src_unpack
	fi
}

src_configure() {
	# This program does not work with LTO, so it's been disabled here,
	# though the option is still given to override this decision.
	if ! use custom-rustflags ; then
		RUSTFLAGS="$RUSTFLAGS -C lto=off"
	fi
#	local myfeatures=(
#		barfeature
#		$(usev foo)
#	)
	cargo_src_configure --bin fx
}
