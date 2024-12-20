# Copyright 2024 Basil
# Distributed under the terms of the BSD-3-Clause-CA-AD-v1.0 License

EAPI=8

DESCRIPTION="A simple toolkit for debugging and selecting GPUs"
HOMEPAGE="https://codeberg.org/BasilBasil/Charon"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://codeberg.org/BasilBasil/${PN}.git"
else
	SRC_URI="https://codeberg.org/BasilBasil/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="*"
	S="${WORKDIR}/${PN}"
fi

LICENSE="BSD-CA-AD-v1.0"
SLOT="0"

IUSE="opengl gles vulkan opencl vaapi vdpau"

RDEPEND="
	opengl? ( x11-apps/mesa-progs )
	gles? ( x11-apps/mesa-progs )
	vulkan? ( dev-util/vulkan-tools )
	opencl? ( dev-util/clinfo )
	vaapi? ( media-video/libva-utils )
	vdpau? ( x11-misc/vdpauinfo )
"

src_compile() {
	:
}

src_install() {
	dobin asphodel
	dosym /usr/bin/asphodel /usr/bin/ap
	dobin elysium
	dobin elysium-flatpak-cfg
	dosym /usr/bin/elysium /usr/bin/elnvidiad
	dosym /usr/bin/elysium /usr/bin/elnouveaud
	dosym /usr/bin/elysium /usr/bin/elamdd
	dosym /usr/bin/elysium /usr/bin/elinteli
	dobin tartarus
	dosym /usr/bin/tartarus /usr/bin/ta
}
