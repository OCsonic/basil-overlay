# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_MAKEFILE_GENERATOR=emake
inherit cmake epatch

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/OpenHMD/OpenHMD.git"
else
	KEYWORDS="~amd64"
	SRC_URI="https://github.com/OpenHMD/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi
DESCRIPTION="Free and Open Source API and drivers for immersive technology."
HOMEPAGE="http://www.openhmd.net/"
LICENSE="Boost-1.0"
SLOT="0"

IUSE="android deepoon examples external nolo psvr rift rift-s steamvr vive vrtek vulkan wayland wmr X xgvr"

BDEPEND=""
DEPEND="
	virtual/libusb:=
	virtual/libudev
	media-libs/libv4l
	media-libs/libsdl2
	wayland? (
		dev-libs/wayland
		dev-libs/wayland-protocols
		dev-util/wayland-scanner
	)
	X? (
		x11-libs/libX11
		x11-libs/libXrandr
		x11-libs/libxcb
	)
	vulkan? (
		media-libs/vulkan-loader
		dev-util/vulkan-headers
	)
	media-libs/libsdl2
	psvr? ( dev-libs/hidapi )
	vive? ( sys-libs/zlib:= )
	steamvr? (
		x11-misc/xdg-utils
	)
"
RDEPEND="${DEPEND}"

src_prepare() {
	PATCHES=(
		"${FILESDIR}/multilib-strict-fix.patch"
	)
	default
}

src_configure() {
	local mycmakeargs=(
		-BUILD_BOTH_STATIC_SHARED_LIBS=ON

		-DOPENHMD_DRIVER_ANDROID=$(usex android)
		-DOPENHMD_DRIVER_DEEPOON=$(usex deepoon)
		-DOPENHMD_DRIVER_EXTERNAL=$(usex external)
		-DOPENHMD_DRIVER_HTC_VIVE=$(usex vive)
		-DOPENHMD_DRIVER_NOLO=$(usex nolo)
		-DOPENHMD_DRIVER_OCULUS_RIFT=$(usex rift)
		-DOPENHMD_DRIVER_OCULUS_RIFT_S=$(usex rift-s)
		-DOPENHMD_DRIVER_PSVR=$(usex psvr)
		-DOPENHMD_DRIVER_VRTEK=$(usex vrtek)
		-DOPENHMD_DRIVER_WMR=$(usex wmr)
		-DOPENHMD_DRIVER_XGVR=$(usex xgvr)

		-DOPENHMD_EXAMPLE_SDL=$(usex examples)
		-DOPENHMD_EXAMPLE_SIMPLE=$(usex examples)
	)

	MYCMAKEARGS+="-S ${CMAKE_USE_DIR} -B ${BUILD_DIR}"
	cmake_src_configure
}
