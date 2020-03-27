# ownCloud als SAML service provider in UCS anbinden

UCS bietet seit UCS 4.1 einen SAML Identity Provider für Single-Sign-On mittels simplesamlphp.
Um Single Sign-On für ownCloud benutzen zu können muss die SAML-Integration in ownCloud erst konfiguriert werden. Dieses Paket führt die dafür notwendigen Schritte aus.

Das Paket baut auf der [offiziellen ownCloud Anleitung](https://doc.owncloud.org/server/10.0/admin_manual/enterprise/user_management/user_auth_shibboleth.html?highlight=saml) für die Einrichtung von SAML mittels dem Apache Modul mod\_shib (Shibboleth) auf.

## Vorraussetungen
Vorraussetzung dafür, dass das Paket installiert werden kann sind folgende:
* Die ownCloud-App ist auf dem UCS System installiert
* ownCloud Enterprise oder eine [30 Tage ownCloud Test Lizenz](https://marketplace.owncloud.com/enterprise-trial) ist aktiviert
* Unter https://$fqdn/owncloud/index.php/apps/market/ [Settings] → [Edit API Key] muss ein entsprechender API Key, den man bei ownCloud erhält eingetragen werden. Danach auf den Button [START ENTERPRISE TRIAL] klicken und den Instruktionen dort folgen.

## Was macht dieses Paket
Dieses Paket führt dann u.a. die folgenden Schritte aus:
* Installieren der ownCloud-App "SAML"
* Aktivieren und konfigurieren der ownCloud SAML App
* Einrichen von Apache-Konfigurationen für mod\_shib im docker container
* Einrichtungen von weiterem reverse-Proxy einträgen für single sign on auf dem Host-System(en)
* Einrichtung eines Portal-Eintrags für Single Sign On zu ownCloud

## In Betrieb nehmen
Um das ganze in Betrieb zu nehmen sind folgende Scrhitte notwendig:
* Ggf. Setzen der UCR-Variable `owncloud/saml/path` (Standard: /oc-shib)
* Herunterladen oder Bauen des Debian-Pakets z.B. von der [github release page](https://github.com/univention/univention-owncloud-saml/releases)
* Installieren des Debian-Pakets
* Sicherstellen, dass das Joinscript erfolgreich ausgeführt wurde
* Erstellen eines ownCloud-Benutzer in UMC
* Aktivieren des ownCloud-Benutzer für den SAML Service Provider unterhalb von [Konto] → [SAML Einstellungen]

## Hinweise
* Die Änderungen an /root/subpath.conf werden ein Container-Update nicht überleben.
* Zum Debuggen eignet sich https://$fqdn//Shibboleth.sso/Session, um zu prüfen was in der Session gespeichert ist.
* Die SAML Metadaten des Service Provider befinden sich unter https://$fqdn//Shibboleth.sso/Metadata.
* https://$fqdn//Shibboleth.sso/Status von localhost!
