# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Description TBA"
HOMEPAGE="https://codeberg.org/BasilBasil/Charon"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://codeberg.org/BasilBasil/${PN}.git"
else
	SRC_URI="https://codeberg.org/BasilBasil/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="*"
	S="${WORKDIR}/${PN}"
fi

LICENSE="Unlicense"
SLOT="0"

BDEPEND=""
DEPEND="
	x11-apps/mesa-progs
	dev-util/vulkan-tools
	dev-util/clinfo
	media-video/libva-utils
	x11-misc/vdpauinfo
"
RDEPEND="${DEPEND}"

src_compile() {
	:
}

src_install() {
	#dobin asphodel
	#dosym asphodel ap
	dobin elysium
	dosym /usr/bin/elysium /usr/bin/elnvidiad
	dosym /usr/bin/elysium /usr/bin/elnouveaud
	dosym /usr/bin/elysium /usr/bin/elamdd
	dosym /usr/bin/elysium /usr/bin/elinteli
	dobin tartarus
	dosym /usr/bin/tartarus /usr/bin/ta
}
