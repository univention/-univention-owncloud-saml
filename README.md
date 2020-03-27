# Connect ownCloud as SAML service provider in UCS

Since UCS 4.1, UCS offers a SAML Identity Provider for Single-Sign-On via simplesamlphp. In order to use Single Sign-On for ownCloud, the SAML integration in ownCloud must first be configured. This package performs the necessary steps.

The package is based on the [official ownCloud instructions](https://doc.owncloud.org/server/10.0/admin_manual/enterprise/user_management/user_auth_shibboleth.html?highlight=saml) for setting up SAML using the Apache module mod\_shib (Shibboleth).

## Prerequisites
Prerequisite for installing the package are the following:
* The ownCloud app is installed on the UCS system
* ownCloud Enterprise or a [30 day ownCloud test license](https://marketplace.owncloud.com/enterprise-trial) is activated
* At https://$fqdn/owncloud/index.php/apps/market/ [Settings] → [Edit API Key] you have to enter a corresponding API Key, which you can get at ownCloud. Then click on the [START ENTERPRISE TRIAL] button and follow the instructions there.

## What does this package do
This package then performs the following steps, among others:

* Installing the ownCloud app "SAML"
* Activating and configuring the ownCloud SAML App
* Setting up Apache configurations for mod\_shib in the docker container
* Set up additional reverse proxy entries for single sign on on host system(s)
* Set-up of a portal entry for Single Sign On to ownCloud

## Putting into operation
The following steps are necessary to start the whole process:

* If necessary, set the UCR variable `owncloud/saml/path` (default: /oc-shib).
* Download or build the Debian package e.g. from the [github release page](https://github.com/univention/univention-owncloud-saml/releases)
* Installing the Debian package
* Ensure that the joinscript was executed successfully
* Creating an ownCloud user in UMC
* Activate the ownCloud user for the SAML Service Provider under [Account] → [SAML Settings].

## Clues
* The changes to /root/subpath.conf will not survive a container update.
* For debugging, https://$fqdn//Shibboleth.sso/Session can be used to check what is stored in the session.
* The SAML metadata of the service provider can be found at https://$fqdn//Shibboleth.sso/Metadata.
* https://$fqdn//Shibboleth.sso/Status of localhost!
