# Make Leap Motion deb package for Debian/unstable

Leap Motion official deb package are designed to use
on Ubuntu.

And it seems that it supports Debian and other Debian derivative
distributions, but that is not true because installed init script which
is generated from /etc/init.d/skeleton is pretty different and
lacks functionality for Debian.

This repository provides set of script and a bit modified version of
well known patch from https://gist.github.com/jmwilson/8e6c579eac5fa7fa9f0d.

Thus, you can easily create fixed version of deb package.

## How to build modified version of deb package

Step 1. Download software from https://www.leapmotion.com/setup.

Step 2. Clone this repository into working directory.

```
git clone https://github.com/kenhys/debian-leapmotion.git
```

Step 3. Put `Leap_Motion_Setup_Linux_2.3.1.tgz` to cloned directory.

```
% cp PATH_TO_Leap_Motion_Setup_Linux_2.3.1.tgz debian-leapmotion/
```

Step 4. Just type `make`.

```
% cd debian-leapmotion
% make
rm -fr tmp
if [ ! -d Leap_Motion_Installer_Packages_release_public_linux ]; then \
  tar xf Leap_Motion_Setup_Linux_2.3.1.tgz; \
fi
dpkg-deb -R Leap_Motion_Installer_Packages_release_public_linux/Leap-2.3.1+31549-x64.deb tmp
(cd tmp; patch -p0 < ../use-systemd-for-leapmotion.patch)
patching file DEBIAN/control
patching file DEBIAN/md5sums
patching file DEBIAN/postinst
patching file DEBIAN/postrm
patching file DEBIAN/prerm
cp -a overwrite/lib tmp/
dpkg-deb -b tmp Leap-2.3.1+31549-0.1-x64.deb
dpkg-deb: building package 'leap' in 'Leap-2.3.1+31549-0.1-x64.deb'.
```

Step 5. Just install it!

```
% sudo dpkg -i Leap-2.3.1+31549-0.1-x64.deb
```

