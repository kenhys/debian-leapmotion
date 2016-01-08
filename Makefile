
DEB=Leap-2.3.1+31549-0.1-x64.deb
TEMPDIR=tmp

all: systemd
	dpkg-deb -b $(TEMPDIR) $(DEB)

systemd: patch
	cp -a overwrite/lib $(TEMPDIR)/

patch: extract
	(cd $(TEMPDIR); patch -p0 < ../use-systemd-for-leapmotion.patch)

extract:
	rm -fr $(TEMPDIR)
	if [ ! -d Leap_Motion_Installer_Packages_release_public_linux ]; then \
	  tar xf Leap_Motion_Setup_Linux_2.3.1.tgz; \
	fi
	dpkg-deb -R Leap_Motion_Installer_Packages_release_public_linux/Leap-2.3.1+31549-x64.deb $(TEMPDIR)
