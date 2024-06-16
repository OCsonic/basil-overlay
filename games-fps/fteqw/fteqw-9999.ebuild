# Copyright 2024 Basil
# Distributed under the terms of the BSD-3-Clause-CA-AD-v1.0 License

EAPI=8

CMAKE_MAKEFILE_GENERATOR=emake
inherit cmake

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/fte-team/${PN}.git"
else
	KEYWORDS="~amd64 ~x86"
	SRC_URI="https://github.com/fte-team/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi
DESCRIPTION="A implementation of the IDTech engine compatible with Quake 1 - Quake 3"
HOMEPAGE="https://www.fteqw.org/"
LICENSE="GPL-3"
SLOT="0"

IUSE="timidity sdl"

BDEPEND=""
RDEPEND=""
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DFTE_ENGINE=yes
		-DFTE_ENGINE_CLIENT_ONLY=no
		-DFTE_ENGINE_SERVER_ONLY=no
		-DFTE_PLUG_TIMIDITY=$(usex timidity)
		-DFTE_USE_SDL=$(usex sdl)
	)

	MYCMAKEARGS+="-S ${CMAKE_USE_DIR} -B ${BUILD_DIR}"
	cmake_src_configure
}

src_install() {
	cp ${BUILD_DIR}/*.pk3 ${CMAKE_USE_DIR}
	cmake_src_install
}
