WPEFRAMEWORK_PROVISIONING_VERSION = bb2679abcaba263d55eabebcdd44891de445e676
WPEFRAMEWORK_PROVISIONING_SITE_METHOD = git
WPEFRAMEWORK_PROVISIONING_SITE = git@github.com:Metrological/webbridge.git
WPEFRAMEWORK_PROVISIONING_INSTALL_STAGING = YES
WPEFRAMEWORK_PROVISIONING_DEPENDENCIES = WPEFramework libprovision

$(eval $(cmake-package))

