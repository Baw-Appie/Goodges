ARCHS = arm64 armv7
OS := $(shell uname)
ifeq ($(OS),Darwin)
  ARCHS += arm64e
endif

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Goodges
Goodges_FILES  = Goodges.xm $(wildcard ./include/*.m)
Goodges_FRAMEWORKS = UIKit CoreGraphics Foundation QuartzCore
Goodges_LIBRARIES = colorpicker applist
include $(THEOS_MAKE_PATH)/tweak.mk

before-all::
	@cp -pf ./control ./layout/DEBIAN/control

after-install::
	install.exec "killall -9 backboardd"

SUBPROJECTS += prefs
include $(THEOS_MAKE_PATH)/aggregate.mk
