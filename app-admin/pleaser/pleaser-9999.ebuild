# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
CRATES="
	aho-corasick@0.7.18
	autocfg@1.1.0
	bitflags@1.3.2
	cfg-if@1.0.0
	chrono@0.4.19
	error-chain@0.12.4
	getopts@0.2.21
	getrandom@0.2.6
	hostname@0.3.1
	itoa@1.0.2
	libc@0.2.134
	log@0.4.17
	match_cfg@0.1.0
	memchr@2.5.0
	memoffset@0.6.5
	nix@0.25.0
	num-integer@0.1.45
	num-traits@0.2.15
	num_threads@0.1.6
	pam@0.7.0
	pam-sys@0.5.6
	pin-utils@0.1.0
	ppv-lite86@0.2.16
	proc-macro2@1.0.51
	quote@1.0.23
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.3
	regex@1.7.1
	regex-syntax@0.6.27
	rpassword@6.0.1
	ryu@1.0.12
	serde@1.0.152
	serde_derive@1.0.152
	serde_json@1.0.92
	syn@1.0.107
	syslog@6.0.1
	time@0.1.43
	time@0.3.9
	unicode-ident@1.0.6
	unicode-width@0.1.9
	users@0.8.1
	users@0.11.0
	version_check@0.9.4
	wasi@0.10.2+wasi-snapshot-preview1
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
"
inherit cargo

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/edneville/please.git"
else
	KEYWORDS="~amd64"
	SRC_URI="https://gitlab.com/edneville/please/-/archive/v${PV}/please-v${PV}.tar.gz -> ${P}.tar.gz"
	SRC_URI+=" $(cargo_crate_uris)"
fi

DESCRIPTION="please, a polite regex-first sudo alternative"
HOMEPAGE="https://gitlab.com/edneville/please"
LICENSE="GPL-3+"
LICENSE+=" Apache-2.0 Apache-2.0-with-LLVM-exceptions Boost-1.0 MIT Unicode-DFS-2016 Unlicense"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_unpack() {
	if [[ ${PV} == *9999 ]]; then
		git-r3_src_unpack
	else
		cargo_src_unpack
	fi
}

src_prepare() {
	cargo_gen_config
}

src_compile() {
	cargo_src_compile
}
