# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# CMake picked to avoid automagic dependencies in meson.build
inherit cmake

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.freedesktop.org/monado/${PN}.git"
else
	KEYWORDS="~amd64"
	SRC_URI="https://gitlab.freedesktop.org/monado/${PN}/-/archive/v${PV}/${PN}-v${PV}.zip -> ${P}.zip"
	S="${WORKDIR}/${PN}-v${PV}"
fi
DESCRIPTION="The open source OpenXR runtime."
HOMEPAGE="https://monado.dev"
LICENSE="Boost-1.0"
SLOT="0"

IUSE="dbus ffmpeg gles gstreamer opencv openhmd opengl psvr sdl steamvr systemd uvc vive vulkan wayland X"

# TODO: percetto?, libsurvive?
BDEPEND=""
DEPEND="
	media-libs/openxr-loader
	media-libs/mesa[egl(+)]
	dev-cpp/eigen:3
	dev-util/glslang
	virtual/libusb:=
	virtual/libudev
	media-libs/libv4l
	dev-libs/libbsd
	dev-libs/cJSON
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
	opengl? ( virtual/opengl )
	opencv? ( media-libs/opencv:= )
	openhmd? ( media-libs/OpenHMD )
	dbus? ( sys-apps/dbus )
	systemd? ( sys-apps/systemd:= )
	uvc? ( media-libs/libuvc )
	ffmpeg? ( media-video/ffmpeg:= )
	sdl? ( media-libs/libsdl2 )
	gstreamer? ( media-libs/gstreamer )
	psvr? ( dev-libs/hidapi )
	vive? ( sys-libs/zlib:= )
	steamvr? (
		x11-misc/xdg-utils
	)
"
RDEPEND="${DEPEND}"

pkg_setup() {
	if [[ ${PV} == 21.0.0 ]]; then die "Version 21.0.0 is known to not work due to requiring old build-time dependencies, please wait until a new stable release is put out or switch to the live package."; fi
	return
}

src_configure() {
	local mycmakeargs=(
		-DXRT_HAVE_WAYLAND=$(usex wayland)
		-DXRT_HAVE_XLIB=$(usex X)
		-DXRT_HAVE_XRANDR=$(usex X)
		-DXRT_HAVE_XCB=$(usex X)

		-DXRT_HAVE_VULKAN=$(usex vulkan)
		-DXRT_HAVE_OPENGL=$(usex opengl)
		-DXRT_HAVE_OPENGLES=$(usex gles)
		-DXRT_HAVE_EGL=ON
		-DXRT_HAVE_LIBBSD=ON
		-DXRT_HAVE_SYSTEMD=$(usex systemd)
		-DXRT_INSTALL_SYSTEMD_UNIT_FILES=$(usex systemd)

		-DXRT_HAVE_LIBUSB=ON
		-DXRT_HAVE_JPEG=ON
		-DXRT_HAVE_OPENCV=$(usex opencv)
		-DXRT_HAVE_LIBUVC=$(usex uvc)
		-DXRT_HAVE_FFMPEG=$(usex ffmpeg)
		-DXRT_HAVE_SDL2=$(usex sdl)
		-DXRT_HAVE_SYSTEM_CJSON=ON
		-DXRT_HAVE_GST=$(usex gstreamer)
		-DXRT_HAVE_PERCETTO=OFF

		-DXRT_BUILD_DRIVER_PSVR=$(usex psvr)
		-DXRT_BUILD_DRIVER_RS=OFF
		-DXRT_BUILD_DRIVER_VIVE=$(usex vive)
		-DXRT_BUILD_DRIVER_OHMD=$(usex openhmd)
		-DXRT_BUILD_DRIVER_HANDTRACKING=$(usex vive)
		-DXRT_BUILD_DRIVER_DAYDREAM=$(usex dbus)
		-DXRT_BUILD_DRIVER_ARDUINO=$(usex dbus)
		-DXRT_BUILD_DRIVER_ILLIXR=OFF
		-DXRT_BUILD_DRIVER_ULV2=OFF

		-DXRT_BUILD_DRIVER_SURVIVE=OFF
		-DXRT_BUILD_DRIVER_QWERTY=$(usex sdl)
	)

	cmake_src_configure
}

pkg_postinst() {
	ewarn "If Monado is not registered with steamvr yet, then please run the following command."
	ewarn "\$HOME/.steam/steam/steamapps/common/SteamVR/bin/vrpathreg.sh adddriver /usr/share/steamvr-monado"
	ewarn "if you want to remove the steamvr driver then just replace 'adddriver' with 'removedriver'"
}
