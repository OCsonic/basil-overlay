# Copyright 2024 Basil
# Distributed under the terms of the BSD-3-Clause-CA-AD-v1.0 License

EAPI=8

DESCRIPTION="A collection of small utilities wrote to assist in other programs."
HOMEPAGE="https://codeberg.org/BasilBasil/eplug"

SRC_URI="https://codeberg.org/BasilBasil/eplug/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="*"
S="${WORKDIR}/eplug"

LICENSE="BSD-CA-AD-v1.0"
SLOT="0"

src_compile() {
	:
}

src_install() {
	insinto /etc/portage/
	doins bashrc
	doins ehook
}
