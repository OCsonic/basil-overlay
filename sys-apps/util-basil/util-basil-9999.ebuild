# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A collection of small utilities wrote to assist in other programs."
HOMEPAGE="https://codeberg.org/BasilBasil/util-basil"

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

USE="whatgpu"

src_compile() {
	:
}

src_install() {
	dobin countdown
	dobin localbin
	dobin timebetween
	use whatgpu && dobin whatgpu
}
