# Copyright 2024 Basil
# Distributed under the terms of the BSD-3-Clause-CA-AD-v1.0 License

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

LICENSE="BSD-CA-AD-v1.0"
SLOT="0"

RDEPEND="app-eselect/eselect-repository sys-apps/util-basil"

src_compile() {
	:
}

src_install() {
	dobin etools
	if (( $(echo -e "${PV} <= 1.0" | bc -l) )); then
		dosym -r /usr/bin/etools /usr/bin/edepon
	fi
	dosym -r /usr/bin/etools /usr/bin/elistpkgs
	dosym -r /usr/bin/etools /usr/bin/erepo
	dosym -r /usr/bin/etools /usr/bin/eshowuse
	dosym -r /usr/bin/etools /usr/bin/etsls
	dosym -r /usr/bin/etools /usr/bin/eunfoldmarch
	if (( $(echo -e "${PV} >= 1.1" | bc -l) )); then
		dosym -r /usr/bin/etools /usr/bin/ebulkcond
	fi
}
