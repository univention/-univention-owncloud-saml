#!/bin/bash
#
# Copyright 2017-2020 Univention GmbH
#
# http://www.univention.de/
#
# All rights reserved.
#
# The source code of this program is made available
# under the terms of the GNU Affero General Public License version 3
# (GNU AGPL V3) as published by the Free Software Foundation.
#
# Binary versions of this program provided by Univention to you as
# well as other copyrighted, protected or trademarked materials like
# Logos, graphics, fonts, specific documentations and configurations,
# cryptographic keys etc. are subject to a license agreement between
# you and Univention and not subject to the GNU AGPL V3.
#
# In the case you use this program under the terms of the GNU AGPL V3,
# the program is provided in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public
# License with the Debian GNU/Linux or Univention distribution in file
# /usr/share/common-licenses/AGPL-3; if not, see
# <http://www.gnu.org/licenses/>.

set -ex

. /usr/bin/entrypoint

cd /var/www/owncloud
sudo -u www-data php occ market:upgrade
sudo -u www-data php occ market:install enterprise_key
sudo -u www-data php occ market:install user_shibboleth
sudo -u www-data php occ app:enable user_shibboleth
sudo -u www-data php occ shibboleth:mode ssoonly
sudo -u www-data php occ shibboleth:mapping -u REMOTE_USER
sed -i 's/$NameQualifier!$SPNameQualifier!$Name/$Name/g' /etc/shibboleth/attribute-map.xml
a2enconf shibd.conf
service shibd stop || true
service shibd start

# apache runs in foreground, so use kill instead of service-reload
# service apache2 reload
pkill -U 0 -f /usr/sbin/apache2 --signal SIGUSR1
