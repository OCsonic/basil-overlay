# Copyright 2024 Basil
# Distributed under the terms of the BSD-3-Clause-CA-AD-v1.0 License

EAPI=8
inherit bash-completion-r1 go-module

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/darkhz/${PN}.git"
else
	KEYWORDS="~amd64"
	SRC_URI="https://github.com/darkhz/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	SRC_URI+=" http://ADD_THIS_NEXT/${P}-deps.tar.xz"
	S="${WORKDIR}/${P}"
fi

DESCRIPTION="A TUI bluetooth manager for Linux."
HOMEPAGE="https://github.com/darkhz/bluetuith/"
LICENSE="MIT BSD-2 BSD Apache-2.0"
SLOT="0"

IUSE="networkmanager pipewire pulseaudio"
REQUIRED_USE="^^ ( pipewire pulseaudio )"

BDEPEND=""
DEPEND="
	dev-lang/go
	net-wireless/bluez
	sys-apps/dbus
	pulseaudio? (
		media-sound/pulseaudio
	)
	pipewire? (
		media-video/pipewire
	)
	networkmanager? (
		net-misc/networkmanager
	)
"
RDEPEND="${DEPEND}"


src_unpack() {
	if [[ ${PV} == *9999 ]]; then
		git-r3_src_unpack
		go-module_live_vendor
	else
		go-module_src_unpack
	fi
}

src_compile() {
	[[ ${PV} == *9999 ]] || export GH_VERSION="v${PV}"
	ego build
}

src_install() {
	dobin ${PN}
}
