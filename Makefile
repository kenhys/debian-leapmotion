
DEB=Leap-2.3.1+31549-0.1-x64.deb
OFFICIAL_DEB=Leap-2.3.1+31549-x64.deb
TEMPDIR=tmp

SDK_DIR=LeapDeveloperKit_2.3.1+31549_linux
SDK_TGZ=Leap_Motion_SDK_Linux_2.3.1.tgz

SETUP_DIR=Leap_Motion_Installer_Packages_release_public_linux
SETUP_TGZ=Leap_Motion_Setup_Linux_2.3.1.tgz

all: systemd
	dpkg-deb -b $(TEMPDIR) $(DEB)

systemd: patch
	cp -a overwrite/lib $(TEMPDIR)/
	rm -f $(TEMPDIR)/etc/init/leapd.conf

patch: extract
	(cd $(TEMPDIR); patch -p0 < ../use-systemd-for-leapmotion.patch)

extract:
	rm -fr $(TEMPDIR)
	if [ ! -d $(SETUP_DIR) -a -f $(SETUP_TGZ) ]; then \
	  tar xf $(SETUP_TGZ); \
	  dpkg-deb -R $(SETUP_DIR)/$(OFFICIAL_DEB) $(TEMPDIR); \
	elif [ ! -d $(SDK_DIR) -a -f $(SDK_TGZ) ]; then \
	  tar xf $(SDK_TGZ); \
	  dpkg-deb -R $(SDK_DIR)/$(OFFICIAL_DEB) $(TEMPDIR); \
	fi
