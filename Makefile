
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
	dpkg-deb -R Leap-2.3.1+31549-x64.deb $(TEMPDIR)
