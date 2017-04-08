
DEB=Leap-2.3.1+31549-0.1-x64.deb
TEMPDIR=tmp

SDK_DIR=LeapDeveloperKit_2.3.1+31549_linux
SETUP_DIR=Leap_Motion_Installer_Packages_release_public_linux

all: systemd
	dpkg-deb -b $(TEMPDIR) $(DEB)

systemd: patch
	cp -a overwrite/lib $(TEMPDIR)/
	rm -f $(TEMPDIR)/etc/init/leapd.conf

patch: extract
	(cd $(TEMPDIR); patch -p0 < ../use-systemd-for-leapmotion.patch)

extract:
	rm -fr $(TEMPDIR)
	if [ ! -d $(SETUP_DIR) -a -f Leap_Motion_Setup_Linux_2.3.1.tgz ]; then \
	  tar xf Leap_Motion_Setup_Linux_2.3.1.tgz; \
	  dpkg-deb -R $(SETUP_DIR)/Leap-2.3.1+31549-x64.deb $(TEMPDIR); \
	elif [ ! -d $(SDK_DIR) -a -f Leap_Motion_SDK_Linux_2.3.1.tgz ]; then \
	  tar xf Leap_Motion_SDK_Linux_2.3.1.tgz; \
	  dpkg-deb -R $(SDK_DIR)/Leap-2.3.1+31549-x64.deb $(TEMPDIR); \
	fi
