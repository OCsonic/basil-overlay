# Copyright 2024 Basil
# Distributed under the terms of the BSD-3-Clause-CA-AD-v1.0 License

EAPI=8

inherit cmake
if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.freedesktop.org/monado/${PN}.git"
else
	KEYWORDS="~amd64"
	SRC_URI="https://gitlab.freedesktop.org/monado/${PN}/-/archive/v${PV}/${PN}-v${PV}.zip -> ${P}.zip"
	S="${WORKDIR}/${PN}-v${PV}"
fi
DESCRIPTION="Open-source OpenXR runtime"
HOMEPAGE="https://monado.dev"
LICENSE="Boost-1.0"
SLOT="0"

IUSE="
	X wayland
	systemd udev dbus uvc
	+opengl gles +vulkan gstreamer ffmpeg opencv
	+openhmd steamvr psvr psmv vive arduino daydream qwerty
"
REQUIRED_USE="
	|| ( X wayland )
	gles? ( !opengl )
	arduino? ( dbus )
	daydream? ( dbus )
"

DEPEND="
	X? ( x11-libs/libX11 media-libs/openxr-loader[X(+)] media-libs/mesa[wayland(+)] )
	wayland? ( dev-libs/wayland	media-libs/openxr-loader[wayland(+)] media-libs/mesa[wayland(+)] )
	virtual/opengl
	dev-cpp/eigen:3
	dev-util/glslang
	virtual/libusb
	virtual/libudev
	media-libs/libv4l
	media-libs/mesa[egl(+)]

	openhmd? ( media-libs/OpenHMD )
	psvr? ( dev-libs/hidapi )
	vive? ( sys-libs/zlib )
	qwerty? ( media-libs/libsdl2 )
	dbus? ( sys-apps/dbus )

	opencv? ( media-libs/opencv )
	uvc? ( media-libs/libuvc )
	dev-libs/libbsd
	dev-libs/cJSON
	ffmpeg? ( media-video/ffmpeg )
	gstreamer? ( media-libs/gstreamer )
	steamvr? ( x11-misc/xdg-utils )
	systemd? ( sys-apps/systemd )
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DXRT_HAVE_WAYLAND=$(usex wayland)
		-DXRT_HAVE_WAYLAND_DIRECT=$(usex wayland)
		-DXRT_HAVE_XCB=$(usex X)
		-DXRT_HAVE_XLIB=$(usex X)
		-DXRT_HAVE_XRANDR=$(usex X)
		
		-DXRT_HAVE_VULKAN=$(usex vulkan)
		-DXRT_HAVE_OPENGL=$(usex opengl)
		-DXRT_HAVE_OPENGLES=$(usex gles)
		-DXRT_HAVE_EGL=ON

		-DXRT_HAVE_JPEG=ON
		-DXRT_HAVE_OPENCV=$(usex opencv)
		-DXRT_HAVE_LIBUVC=$(usex uvc)
		-DXRT_HAVE_DBUS=$(usex dbus)
		-DXRT_HAVE_SDL2=$(usex qwerty)
		-DXRT_HAVE_SYSTEM_CJSON=ON
		-DXRT_HAVE_FFMPEG=$(usex ffmpeg)
		-DXRT_HAVE_GST=$(usex gstreamer)
		-DXRT_HAVE_PERCETTO=OFF

		-DXRT_BUILD_DRIVER_OHMD=$(usex openhmd)
		-DXRT_BUILD_DRIVER_PSVR=$(usex psvr)
		-DXRT_BUILD_DRIVER_PSMV=$(usex psmv)
		-DXRT_BUILD_DRIVER_VIVE=$(usex vive)
		-DXRT_BUILD_DRIVER_HANDTRACKING=$(usex vive)
		-DXRT_BUILD_DRIVER_ARDUINO=$(usex arduino)
		-DXRT_BUILD_DRIVER_DAYDREAM=$(usex daydream)
		-DXRT_BUILD_DRIVER_QWERTY=$(usex qwerty)
		-DXRT_BUILD_DRIVER_RIFT_S=OFF
		-DXRT_BUILD_DRIVER_ILLIXR=OFF
		-DXRT_BUILD_DRIVER_ULV2=OFF
		-DXRT_BUILD_DRIVER_SURVIVE=OFF

		-DXRT_HAVE_LIBBSD=ON
		-DXRT_HAVE_LIBUSB=ON
		-DXRT_FEATURE_STEAMVR_PLUGIN=$(usex steamvr)
		-DXRT_HAVE_LIBUDEV=$(usex udev)
		-DXRT_HAVE_SYSTEMD=$(usex systemd)
		-DXRT_INSTALL_SYSTEMD_UNIT_FILES=$(usex systemd)
	)

	cmake_src_configure
}

pkg_postinst() {
	ewarn "If Monado is not registered with steamvr yet, then please run the following command."
	ewarn "\$HOME/.steam/steam/steamapps/common/SteamVR/bin/vrpathreg.sh adddriver /usr/share/steamvr-monado"
	ewarn "if you want to remove the steamvr driver then just replace 'adddriver' with 'removedriver'"
}
