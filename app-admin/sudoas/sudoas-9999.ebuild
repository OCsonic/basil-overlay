# Copyright 2024 Basil
# Distributed under the terms of the BSD-3-Clause-CA-AD-v1.0 License

EAPI=8

DESCRIPTION="A compatibility layer for replacing Sudo with other SUID programs."
HOMEPAGE="https://codeberg.org/BasilBasil/sudoas"

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
