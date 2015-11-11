ECUAPP_SITE = git://git.assembla.com/lnxEmbdDevice.git
ECUAPP_SITE_METHOD = git
ECUAPP_VERSION = v1.12
ECUAPP_SOURCE = ecuApp-$(ECUAPP_VERSION).tar.gz
ECUAPP_INSTALL_STAGING = YES
ECUAPP_INSTALL_TARGET = YES
ECUAPP_DEPENDENCIES = sdl flite

define ECUAPP_BUILD_CMDS
	$(@D)/br2_config $(TARGET_CXX) $(@D) $(STAGING_DIR)
	$(MAKE) PROJECT_ROOT=$(@D) -C $(@D)/Src
endef

define ECUAPP_INSTALL_STAGING_CMDS
	$(INSTALL) -D -m 0755 $(@D)/Bin/Target/usr/bin/* $(STAGING_DIR)/usr/bin
	$(INSTALL) -D -m 0755 $(@D)/Bin/Target/usr/lib/* $(STAGING_DIR)/usr/lib
endef

define ECUAPP_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/Bin/Target/usr/bin/* $(TARGET_DIR)/usr/bin
	$(INSTALL) -D -m 0755 $(@D)/Bin/Target/usr/lib/* $(TARGET_DIR)/usr/lib
	mkdir -p $(TARGET_DIR)/etc/opt
	mkdir -p $(TARGET_DIR)/srv/www/cgi-bin
	$(INSTALL) -D -m 0755 $(@D)/Configuration/* $(TARGET_DIR)/etc/opt
	$(INSTALL) -D -m 0755 $(@D)/HTMLSource/* $(TARGET_DIR)/srv/www
	rm -rf $(TARGET_DIR)/srv/www/cgi-bin/controller
	ln -s '/usr/bin/cgiprocessor' $(TARGET_DIR)/srv/www/cgi-bin/controller
endef

$(eval $(generic-package))
