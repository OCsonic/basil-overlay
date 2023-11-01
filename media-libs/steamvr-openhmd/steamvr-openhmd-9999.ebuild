# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_MAKEFILE_GENERATOR=emake
inherit cmake

#if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ChristophHaag/SteamVR-OpenHMD.git"
#else
#	KEYWORDS="~amd64"
#	THIS PACKAGE DOES NOT HAVE ANY RELEASES YET, UNCOMMENT THIS WHEN IT DOES
#fi
DESCRIPTION="SteamVR plugin for using OpenHMD drivers in SteamVR"
HOMEPAGE="https://github.com/ChristophHaag/SteamVR-OpenHMD"
LICENSE="Boost-1.0"
SLOT="0"

IUSE="steamvr"

BDEPEND=""
DEPEND="
	media-libs/OpenHMD[steamvr]
"
RDEPEND="${DEPEND}"

src_install() {
	insinto /usr/share/SteamVR-OpenHMD
	doins -r resources
	doins driver.vrdrivermanifest
	doins ${BUILD_DIR}/bin/linux64/driver_openhmd.so
}

pkg_postinst() {
	ewarn "If OpenHMD is not registered with steamvr yet, then please run the following command."
	ewarn "\$HOME/.steam/steam/steamapps/common/SteamVR/bin/vrpathreg.sh adddriver /usr/share/StaemVR-OpenHMD"
	ewarn "if you want to remove the steamvr driver then just replace 'adddriver' with 'removedriver'"
}
