FROM debian

RUN \
	apt-get update && \
	apt-get install -y subversion wget zip p7zip xz-utils patch && \
	echo OK!

WORKDIR /usr/src/dd-wrt

ENV BASE_REV=39508

RUN \
	svn co -r $BASE_REV --depth immediates svn://svn.dd-wrt.com/DD-WRT . && \
	\
	svn update -r $BASE_REV --set-depth=infinity   tools && \
	svn update -r $BASE_REV --set-depth=infinity   opt && \
	svn update -r $BASE_REV --set-depth=immediates src && \
	svn update -r $BASE_REV --set-depth=immediates src/linux && \
	svn update -r $BASE_REV --set-depth=immediates src/linux/universal && \
	svn update -r $BASE_REV --set-depth=infinity   src/linux/universal/linux-4.4 && \
	\
	echo OK!

RUN \
	svn update -r $BASE_REV --set-depth=infinity   src/linux/universal/linux-4.9 && \
	svn update -r $BASE_REV --set-depth=infinity   src/include.v24 src/include.bcm && \
	svn update -r $BASE_REV --set-depth=immediates src/router && \
	\
	echo OK!

RUN \
	cd src/router && \
	svn update -r $BASE_REV --set-depth=infinity \
		services nvram utils shared \
		rules configs dropbear libutils \
		iptables dnsmasq pcre gmp nettle \
		libpcap tcpdump \
		wol samba36 hostapd2 \
		jansson ntfs-3g igmp-proxy dhcpv6 \
		zlib openssl openvpn \
	&& \
	echo OK!

RUN \
	cd src/router && \
	svn update -r $BASE_REV --set-depth=infinity \
		httpd kromo \
		mtd-utils libnet wiviz2 rc \
		bridge busybox netconf \
		ntpclient libnl-tiny ipvsadm \
		rp-pppoe udhcpc udhcpd upnp \
		iproute2 xl2tpd cron pptp-client \
		ebtables-2.0.9 \
		inadyn others json-c \
		iperf comgt usb_modeswitch \
	&& \
	echo OK!

RUN \
	cd src/router && \
	svn update -r $BASE_REV --set-depth=infinity \
		samba igmp-proxy nas wlconf \
		pciutils proxywatchdog jffs2 \
		language networksettings routerstyle scheduler syslog \
		telnet wdswatchdog ipv6 conntrack radiooff hwmon \
		stabridge ifenslave stuck_beacon usb disktype hotplug2 udev \
		mstp ttraff filesharing misc tools netgear lzo \
		wireless-tools qtn \
	&& \
	echo OK!

ENV REV=40459
ENV PATCH44=186
ENV PATCH49=186

RUN \
	svn update -r $REV --set-depth=infinity   tools && \
	svn update -r $REV --set-depth=infinity   opt && \
	svn update -r $REV --set-depth=infinity   src/linux/universal/linux-4.4 && \
	svn update -r $REV --set-depth=infinity   src/linux/universal/linux-4.9 && \
	svn update -r $REV --set-depth=infinity   src/include.v24 src/include.bcm && \
	cd src/router && \
	svn update -r $REV --set-depth=infinity \
		services nvram utils shared \
		rules configs dropbear libutils \
		iptables dnsmasq pcre gmp nettle \
		libpcap tcpdump \
		wol samba36 hostapd2 \
		jansson ntfs-3g igmp-proxy dhcpv6 \
		zlib openssl openvpn \
		httpd kromo \
		mtd-utils libnet wiviz2 rc \
		bridge busybox netconf \
		ntpclient libnl-tiny ipvsadm

RUN \
	cd src/router && \
	svn update -r $REV --set-depth=infinity \
		rp-pppoe udhcpc udhcpd upnp \
		iproute2 xl2tpd cron pptp-client \
		ebtables-2.0.9 \
		inadyn others json-c \
		iperf comgt usb_modeswitch \
		samba igmp-proxy nas wlconf \
		pciutils proxywatchdog jffs2 \
		language networksettings routerstyle scheduler syslog \
		telnet wdswatchdog ipv6 conntrack radiooff hwmon \
		stabridge ifenslave stuck_beacon usb disktype hotplug2 udev \
		mstp ttraff filesharing misc tools netgear lzo \
		wireguard wireless-tools madwifi hostapd-2017-08-24 qtn \
		hostapd-2018-07-08 \
		wlc ubi-utils \
	&& \
	echo OK!

RUN \
	svn update -r $REV --depth=files src && \
	svn update -r $REV --depth=files src/linux && \
	svn update -r $REV --depth=files src/linux/universal && \
	svn update -r $REV --depth=files src/router && \
	echo OK!

RUN \
	cd src/router && \
	svn update -r $REV --set-depth=infinity \
		pppd exfat-utils qrencode

RUN \
	cd .. && \
	wget --progress=bar:force:noscroll \
		https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz && \
	wget --progress=bar:force:noscroll \
		https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.$PATCH44.xz && \
	wget --progress=bar:force:noscroll \
		https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz && \
	wget --progress=bar:force:noscroll \
		https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.$PATCH49.xz && \
	echo OK!

RUN \
	cd .. && \
	tar xf linux-4.4.tar.xz && \
	cd linux-4.4 && \
	cat ../patch-4.4.$PATCH44.xz | xz -d | patch -p1 > /dev/null && \
	cd .. && \
	mv linux-4.4 linux-4.4.orig && \
	\
	ln -s dd-wrt/src/linux/universal/linux-4.4 linux-4.4 && \
	cd linux-4.4 && \
	tar cJf ../brcm-4.4.tar.xz brcm drivers/char/rtl8365mb/*.o && \
	rm -rf brcm && \
	rm drivers/char/rtl8365mb/*.o && \
	rm scripts/squashfs/mksquashfs* && \
	rm drivers/net/wireless/rt3352 && \
	rm drivers/net/wireless/rt5592 && \
	rm drivers/net/wireless/rt7612 && \
	rm drivers/net/wireless/rt7620 && \
	cd .. && \
	\
	(diff -urN linux-4.4.orig linux-4.4 > ddwrt-4.4.$PATCH44-$REV.diff || echo) && \
	mv linux-4.4 linux-4.4.ddwrt && \
	\
	tar xf linux-4.4.tar.xz && \
	cd linux-4.4 && \
	cat ../patch-4.4.$PATCH44.xz | xz -d | patch -p1 > /dev/null && \
	echo applying ddwrt diff && \
	cat ../ddwrt-4.4.$PATCH44-$REV.diff | (patch -p1 > /dev/null || echo there are few known errors) && \
	cd .. && \
	echo generating patch again && \
	(diff -urN --no-dereference linux-4.4.orig linux-4.4 > ddwrt-4.4.$PATCH44-$REV.diff || echo) && \
	mv linux-4.4 linux-4.4.patched && \
	\
	tar xf linux-4.4.tar.xz && \
	cd linux-4.4 && \
	cat ../patch-4.4.$PATCH44.xz | xz -d | patch -p1 > /dev/null && \
	echo applying generated patch && \
	cat ../ddwrt-4.4.$PATCH44-$REV.diff | patch -p1 > /dev/null && \
	cd .. && \
	\
	echo verifying generated patch && \
	(diff -urN linux-4.4.ddwrt linux-4.4.patched > /dev/null || echo failed) && \
	rm -rf linux-4.4* patch-4.4* && \
	xz ddwrt-4.4.$PATCH44-$REV.diff && \
	mv ddwrt-4.4.$PATCH44-$REV.diff.xz dd-wrt/src/linux/universal && \
	echo OK!

RUN \
	cd .. && \
	tar xf linux-4.9.tar.xz && \
	cd linux-4.9 && \
	cat ../patch-4.9.$PATCH49.xz | xz -d | patch -p1 > /dev/null && \
	cd .. && \
	mv linux-4.9 linux-4.9.orig && \
	\
	ln -s dd-wrt/src/linux/universal/linux-4.9 linux-4.9 && \
	cd linux-4.9 && \
	tar cJf ../brcm-4.9.tar.xz brcm && \
	tar cJf ../ucode-4.9.tar.xz firmware/amd-ucode firmware/intel-ucode && \
	rm -rf brcm firmware/amd-ucode firmware/intel-ucode && \
	rm scripts/squashfs/mksquashfs* && \
	rm drivers/net/wireless/rt3352 && \
	rm drivers/net/wireless/rt5592 && \
	rm drivers/net/wireless/rt7610 && \
	rm drivers/net/wireless/rt7612 && \
	rm drivers/net/wireless/rt7615 && \
	rm drivers/net/wireless/rt7620 && \
	cd .. && \
	\
	(diff -urN linux-4.9.orig linux-4.9 > ddwrt-4.9.$PATCH49-$REV.diff || echo) && \
	mv linux-4.9 linux-4.9.ddwrt && \
	\
	tar xf linux-4.9.tar.xz && \
	cd linux-4.9 && \
	cat ../patch-4.9.$PATCH49.xz | xz -d | patch -p1 > /dev/null && \
	echo applying ddwrt diff && \
	cat ../ddwrt-4.9.$PATCH49-$REV.diff | (patch -p1 > /dev/null || echo there are few known errors) && \
	cd .. && \
	echo generating patch again && \
	(diff -urN --no-dereference linux-4.9.orig linux-4.9 > ddwrt-4.9.$PATCH49-$REV.diff || echo) && \
	mv linux-4.9 linux-4.9.patched && \
	\
	tar xf linux-4.9.tar.xz && \
	cd linux-4.9 && \
	cat ../patch-4.9.$PATCH49.xz | xz -d | patch -p1 > /dev/null && \
	echo applying generated patch && \
	cat ../ddwrt-4.9.$PATCH49-$REV.diff | patch -p1 > /dev/null && \
	cd .. && \
	\
	echo verifying generated patch && \
	(diff -urN linux-4.9.ddwrt linux-4.9.patched > failed || echo failed) && \
	rm -rf linux-4.9* patch-4.9* && \
	xz ddwrt-4.9.$PATCH49-$REV.diff && \
	mv ddwrt-4.9.$PATCH49-$REV.diff.xz dd-wrt/src/linux/universal && \
	echo OK!

RUN \
	rm -rf \
		src/linux/universal/linux-4.4/* \
		src/linux/universal/linux-4.4/.[cgm]* \
		src/linux/universal/linux-4.9/* \
		src/linux/universal/linux-4.9/.[cgm]* \
	&& \
	tar cvJf ../src.tar.xz * && \
	rm -rf * .[s]* && \
	mv ../src.tar.xz ./src.tar.xz

CMD \
	cat ./src.tar.xz
