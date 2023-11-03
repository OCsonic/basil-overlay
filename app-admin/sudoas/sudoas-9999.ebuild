# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Simple tools to assist and automate some portage functions."
HOMEPAGE="https://codeberg.org/BasilBasil/etools"

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

RDEPEND="
	!app-admin/sudo
	app-admin/doas
"
#	|| (
#		app-admin/doas
#		sys-auth/polkit
#	)

src_compile() {
	:
}

src_install() {
	dobin sudoas
	dobin sudoasedit
	dosym -r /usr/bin/sudoas /usr/bin/sudo
	dosym -r /usr/bin/sudoasedit /usr/bin/sudoedit
}
