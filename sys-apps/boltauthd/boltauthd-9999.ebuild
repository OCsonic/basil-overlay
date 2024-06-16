# Copyright 2024 Basil
# Distributed under the terms of the BSD-3-Clause-CA-AD-v1.0 License

EAPI=8

DESCRIPTION="A simple Thunderbolt authorization daemon that tracks PCI IDs"
HOMEPAGE="https://codeberg.org/BasilBasil/util-basil"

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

src_compile() {
	:
}

src_install() {
	dobin boltauthd
	dobin boltauthd-boltctl-integration
	newinitd boltauthd-openrc boltauthd
}
