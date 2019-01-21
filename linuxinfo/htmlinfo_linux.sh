#!/bin/sh

RPMINFO=/tmp/RPMINFO
DMIDECODE=/tmp/DMIDECODE

/bin/rpm -qa > $RPMINFO
/usr/sbin/dmidecode > $DMIDECODE


HOSTNAME=`uname -n | awk -F. '{print $1}'`
PROCESSORTYPE=`uname -p`
HOSTID=`hostid`
#LOGFILE="$HOSTNAME-$HOSTID-`date +%d-%m-%Y`"
LOGFILE="$HOSTNAME-webinfo"
OSVERSION=`uname -sr`
OSREAL=`cat /etc/redhat-release | head -1`
OSPATCH=`uname -v`
PLATFORM=`uname -i`
ARCH=`uname -m`
PNAME=`cat $DMIDECODE | grep "Product Name" | awk -F: '{print $2}'`
MEMORY=`cat $DMIDECODE | awk '/Memory Device$/ { getline; getline; getline; getline; getline; print $0}' | grep -v No | awk '{print $2}' | awk '{sum+=$1} END {print sum, "MB"}'`
LOGMEMORY=`cat /proc/cpuinfo | grep processor |wc -l`
PHYMEMORY=`dmidecode | grep "DMI type 4" | wc -l`
TIMEZONE=`date | cut -c21-24`
SERIALNO=`cat $DMIDECODE | grep "Serial Number" | head -1 | awk -F: '{print $2}'`


if [ `grep LGTOaama $RPMINFO | wc -l` -ne 0 ]
then
	LAAM=`rpm -qa | grep LGTOaama | cut -c14-`
fi
if [ `grep HPmwa $RPMINFO | wc -l` -ne 0 ]
then
	HPMWA=`rpm -qa | grep HPmwa | cut -c14-`
fi
if [ `grep -i QLA $RPMINFO | wc -l` -ne 0 ]
then
	QLAHBA=`rpm -qa | grep -i qla`
fi
if [ `grep HPOvCtrl $RPMINFO | wc -l` -ne 0 ]
then
	HPOVCTRL=`rpm -qa | grep HPOvCtrl | cut -c10-`
fi
if [ `grep OPC $RPMINFO | wc -l` -ne 0 ]
then
	OPC=`rpm -qa | grep OPC | cut -c14-`
fi
if [ `grep EMCpower $RPMINFO | wc -l` -ne 0 ]
then
	EMCPOWERPATH=`rpm -qa | grep EMCpower | cut -c14-`
fi


JAVA=`java -version 2>&1 | grep version | head -1 | sed -e 's/"//g' | awk '{print $3}'`

echo "<html>" > /tmp/$LOGFILE.html
echo "<head>" >> /tmp/$LOGFILE.html
echo "<meta http-equiv=\"Content-Type\"" >> /tmp/$LOGFILE.html
echo "content=\"text/html; charset=iso-8859-1\">" >> /tmp/$LOGFILE.html
echo "<title>$HOSTNAME - Server Information</title>" >> /tmp/$LOGFILE.html
echo "</head>" >> /tmp/$LOGFILE.html
echo "<body style=\"background-color:WhiteSmoke\" bgcolor=\"#FFFFFF\">" >> /tmp/$LOGFILE.html
echo "<font face=\"Arial\">" >> /tmp/$LOGFILE.html

echo "<p align=\"center\"><strong>$HOSTNAME Server Information</strong></p>" >> /tmp/$LOGFILE.html
echo "<p><a href=\"#Host\">Host Information</a><br>" >> /tmp/$LOGFILE.html
echo "<a href=\"#NW\">Network Interface Information</a><br>" >> /tmp/$LOGFILE.html
echo "<a href=\"#NETSTAT\">Network Route Information</a><br>" >> /tmp/$LOGFILE.html
echo "<a href=\"#USER\">User ID Information</a><br>" >> /tmp/$LOGFILE.html
echo "<a href=\"#HOSTS\">Hosts Information(/etc/hosts)</a><br>" >> /tmp/$LOGFILE.html
echo "<a href=\"#SERVICES\">Ports Services Information(/etc/services)</a><br>" >> /tmp/$LOGFILE.html
echo "<a href=\"#FSTAB\">fstab Information(/etc/fstab)</a><br>" >> /tmp/$LOGFILE.html
echo "<a href=\"#Ver\">Version Information</a><br>" >> /tmp/$LOGFILE.html
echo "<a href=\"#Disk\">Filesystem Allocation Information</a><br>" >> /tmp/$LOGFILE.html


echo "<a href=\"#SYSTEM1\">Kernel Parameters (/etc/system)</a><br>" >> /tmp/$LOGFILE.html

if [ `grep JNIC146x $RPMINFO | wc -l` -ne 0 ]
then
	echo "<a href=\"#SYSTEM2\">JNI Driver Parameters</a><br>" >> /tmp/$LOGFILE.html
	echo "<a href=\"#SYSTEM4\">sd Driver Parameters</a><br>" >> /tmp/$LOGFILE.html
fi
if [ `grep QLA2300 $RPMINFO | wc -l` -ne 0 ]
then
	echo "<a href=\"#SYSTEM5\">QLogic Driver Parameters</a><br>" >> /tmp/$LOGFILE.html
	if [ `grep JNIC146x $RPMINFO | wc -l` -eq 0 ]
	then
		echo "<a href=\"#SYSTEM6\">sd Driver Parameters</a><br>" >> /tmp/$LOGFILE.html
	fi
fi

echo "<a href=\"#CKSUM\">Checksum Information</a><br>" >> /tmp/$LOGFILE.html


echo "<p><a name=\"Host\"></a><strong>Host Information</strong></p>" >> /tmp/$LOGFILE.html
echo "<div align=\"center\"><center>" >> /tmp/$LOGFILE.html
echo "<table border=\"1\" width=\"100%\" bordercolor=\"#000000\">" >> /tmp/$LOGFILE.html
echo "<tr><td>Hostname&nbsp;</td><td>$HOSTNAME&nbsp;</td></tr>" >> /tmp/$LOGFILE.html
echo "<tr><td>Product Name&nbsp;</td><td>$PNAME&nbsp;</td></tr>" >> /tmp/$LOGFILE.html
echo "<tr><td>HostID&nbsp;</td><td>$HOSTID&nbsp;</td></tr>" >> /tmp/$LOGFILE.html
echo "<tr><td>Serial No.&nbsp;</td><td>$SERIALNO&nbsp;</td></tr>" >> /tmp/$LOGFILE.html
echo "<tr><td>Arch / Processor / Platform / Model&nbsp;</td><td>$ARCH / $PROCESSORTYPE / $PLATFORM / $MODEL&nbsp;</td></tr>" >> /tmp/$LOGFILE.html
echo "<tr><td>Memory&nbsp;</td><td>$MEMORY&nbsp;</td></tr>" >> /tmp/$LOGFILE.html
echo "<tr><td>CPU Physical/Logical&nbsp;</td><td>$PHYMEMORY/$LOGMEMORY&nbsp;</td></tr>" >> /tmp/$LOGFILE.html
echo "<tr><td>Timezone&nbsp;</td><td>$TIMEZONE&nbsp;</td></tr>" >> /tmp/$LOGFILE.html
if [ "$HBAWWPN" != "" ]
then
	echo "<tr><td>HBA installed&nbsp;</td><td>$HBAWWPN&nbsp;</td></tr>" >> /tmp/$LOGFILE.html
fi
echo "</table >" >> /tmp/$LOGFILE.html
echo "</center></div>" >> /tmp/$LOGFILE.html
echo "<br>" >> /tmp/$LOGFILE.html

echo "<p><a name=\"NW\"></a><strong>Network Interface Information</strong></p>" >> /tmp/$LOGFILE.html
echo "<div align=\"center\"><center>" >> /tmp/$LOGFILE.html
echo "<table border=\"1\" width=\"100%\" bordercolor=\"#000000\">" >> /tmp/$LOGFILE.html
echo "<tr><td>Interface&nbsp;</td><td>IP Address&nbsp;</td><td>Netmask&nbsp;</td><td>Hardware Address&nbsp;</td></tr>" >> /tmp/$LOGFILE.html
for i in `/sbin/ifconfig -a | egrep -v "ethers|lo0|127.0.0.1" | grep "Link encap" | awk '{print $1}'`
do
        netmask=`/sbin/ifconfig $i | grep Mask | awk -F: '{print $4}'`
		hwaddr=`/sbin/ifconfig $i | grep HWaddr | awk '{print $5}'`
		if [ -f /etc/sysconfig/network-scripts/ifcfg-$i ]; then
			hwaddr=`cat /etc/sysconfig/network-scripts/ifcfg-$i | grep HWADDR | awk -F= '{print $2}'`
				if [ `echo $i | grep bond | wc -l` -gt 0 ]; then
					hwaddr=`/sbin/ifconfig $i | grep HWaddr | awk '{print $5}'`
				fi	
		fi
		ipaddr=`/sbin/ifconfig $i | grep addr: | head -1 | awk -F: '{print $2}' | awk '{print $1}'`
		
        echo "<tr><td>$i&nbsp;</td><td>$ipaddr&nbsp;</td><td>$netmask&nbsp;</td><td>$hwaddr&nbsp;</td></tr>" >> /tmp/$LOGFILE.html
done
echo "</table>" >> /tmp/$LOGFILE.html
echo "</center></div>" >> /tmp/$LOGFILE.html
echo "<br>" >> /tmp/$LOGFILE.html

echo "<p><a name=\"NETSTAT\"></a><strong>Network Route Information</strong></p>" >> /tmp/$LOGFILE.html
echo "<div align=\"center\"><center>" >> /tmp/$LOGFILE.html
echo "<table border=\"1\" width=\"100%\" bordercolor=\"#000000\">" >> /tmp/$LOGFILE.html
netstat -nr| sed '/^127.0.0.1/d;/^224.0.0.0/d;/^Routing/d;/^-/d;/^$/d' | tail +2 | awk '{print "<tr><td>"$1,"&nbsp;</td><td>"$2,"&nbsp;</td><td>"$8"&nbsp;</td></tr>"}' >> /tmp/$LOGFILE.html
echo "</table>" >> /tmp/$LOGFILE.html
echo "</center></div>" >> /tmp/$LOGFILE.html
echo "<br>" >> /tmp/$LOGFILE.html

echo "<p><a name=\"USER\"></a><strong>User ID Information</strong></p>" >> /tmp/$LOGFILE.html
echo "<div align=\"center\"><center>" >> /tmp/$LOGFILE.html
echo "<table border=\"1\" width=\"100%\" bordercolor=\"#000000\">" >> /tmp/$LOGFILE.html
echo "<tr><td>Username&nbsp;</td><td>User ID&nbsp;</td><td>Home dir.&nbsp;</td><td>Login Shell&nbsp;</td><td>Comments&nbsp;</td></tr>" >> /tmp/$LOGFILE.html
cat /etc/passwd | awk -F: '{print "<tr><td>"$1,"&nbsp;</td><td>"$3,"&nbsp;</td><td>"$6,"&nbsp;</td><td>"$7,"&nbsp;</td><td>"$5"&nbsp;</td></tr>"}' >> /tmp/$LOGFILE.html
echo "</table>" >> /tmp/$LOGFILE.html
echo "</center></div>" >> /tmp/$LOGFILE.html
echo "<br>" >> /tmp/$LOGFILE.html

echo "<p><a name=\"HOSTS\"></a><strong>Hosts Information(/etc/hosts)</strong></p>" >> /tmp/$LOGFILE.html
echo "<div align=\"center\"><center>" >> /tmp/$LOGFILE.html
echo "<table border=\"1\" width=\"100%\"><tr><td width=\"100%\" bordercolor=\"#000000\">" >> /tmp/$LOGFILE.html
sed '/^#/d;/^$/d;s/$/<br>/' /etc/hosts >> /tmp/$LOGFILE.html
echo "</table>" >> /tmp/$LOGFILE.html
echo "</center></div>" >> /tmp/$LOGFILE.html
echo "<br>" >> /tmp/$LOGFILE.html

if [ -f /etc/netmasks ]; then
	echo "<p><a name=\"NETMASK\"></a><strong>Netmask Information(/etc/netmasks)</strong></p>" >> /tmp/$LOGFILE.html
	echo "<div align=\"center\"><center>" >> /tmp/$LOGFILE.html
	echo "<table border=\"1\" width=\"100%\"><tr><td width=\"100%\" bordercolor=\"#000000\">" >> /tmp/$LOGFILE.html
	sed '/^#/d;/^$/d;s/$/<br>/' /etc/netmasks >> /tmp/$LOGFILE.html
	echo "</table>" >> /tmp/$LOGFILE.html
	echo "</center></div>" >> /tmp/$LOGFILE.html
	echo "<br>" >> /tmp/$LOGFILE.html
fi

if [ -f /etc/defaultrouter ]; then
	echo "<p><a name=\"ROUTER\"></a><strong>DefaultRouter Information(/etc/defaultrouter)</strong></p>" >> /tmp/$LOGFILE.html
	echo "<div align=\"center\"><center>" >> /tmp/$LOGFILE.html
	echo "<table border=\"1\" width=\"100%\"><tr><td width=\"100%\" bordercolor=\"#000000\">" >> /tmp/$LOGFILE.html
	sed '/^#/d;/^$/d;s/$/<br>/' /etc/defaultrouter >> /tmp/$LOGFILE.html
	echo "</table>" >> /tmp/$LOGFILE.html
	echo "</center></div>" >> /tmp/$LOGFILE.html
	echo "<br>" >> /tmp/$LOGFILE.html
fi

echo "<p><a name=\"FSTAB\"></a><strong>fstab Information(/etc/fstab)</strong></p>" >> /tmp/$LOGFILE.html
echo "<div align=\"center\"><center>" >> /tmp/$LOGFILE.html
echo "<table border=\"1\" width=\"100%\"><tr><td width=\"100%\" bordercolor=\"#000000\">" >> /tmp/$LOGFILE.html
sed '/^#/d;/^$/d;s/$/<br>/' /etc/fstab >> /tmp/$LOGFILE.html
echo "</table>" >> /tmp/$LOGFILE.html
echo "</center></div>" >> /tmp/$LOGFILE.html
echo "<br>" >> /tmp/$LOGFILE.html

echo "<p><a name=\"Ver\"></a><strong>Version Information</strong></p>" >> /tmp/$LOGFILE.html
echo "<div align=\"center\"><center>" >> /tmp/$LOGFILE.html
echo "<table border=\"1\" width=\"100%\" bordercolor=\"#000000\">" >> /tmp/$LOGFILE.html
echo "<tr> <td>OperatingSystem&nbsp;</td> <td>$OSVERSION&nbsp;</td></tr>" >> /tmp/$LOGFILE.html
echo "<tr> <td>OperatingSystemRelease&nbsp;</td> <td>$OSREAL&nbsp;</td></tr>" >> /tmp/$LOGFILE.html
echo "<tr> <td>KernelPatchVersion&nbsp;</td> <td>$OSPATCH&nbsp;</td></tr>" >> /tmp/$LOGFILE.html

if [ `grep EMCpower $RPMINFO | wc -l` -ne 0 ]
then
	echo "<tr><td>EMC PowerPath&nbsp;</td><td>$EMCPOWERPATH&nbsp;</td></tr>" >> /tmp/$LOGFILE.html
fi
if [ `grep -i QLA $RPMINFO | wc -l` -ne 0 ]
then
	echo "<tr><td>QLAHBADriverVersion&nbsp;</td><td>$QLAHBA&nbsp;</td></tr>" >> /tmp/$LOGFILE.html
fi
if [ `grep -i JNIC146x $RPMINFO | wc -l` -ne 0 ]
then
	echo "<tr><td>ArraySupportedLibraryVersion&nbsp;</td><td>$ASL&nbsp;</td></tr>" >> /tmp/$LOGFILE.html
	echo "<tr><td>JNIHBADriverVersion&nbsp;</td><td>$JNIHBA&nbsp;</td></tr>" >> /tmp/$LOGFILE.html
	echo "<tr><td>SNIADriverVersion&nbsp;</td><td>$SNIA&nbsp;</td></tr>" >> /tmp/$LOGFILE.html
	echo "<tr><td>XPinfoVersion&nbsp;</td><td>$XPINFO&nbsp;</td></tr>" >> /tmp/$LOGFILE.html
	echo "<tr><td>RAID Manager XP&nbsp;</td><td>$RAIDMGRXP&nbsp;</td></tr>" >> /tmp/$LOGFILE.html
fi

if [ `grep -i LGTOaama $RPMINFO | wc -l` -ne 0 ]
then
	echo "<tr><td>Legato AAM&nbsp;</td> <td>$LAAM&nbsp;</td></tr>" >> /tmp/$LOGFILE.html
fi
if [ `grep -i HPmwa $RPMINFO | wc -l` -ne 0 ]
then
	echo "<tr><td>HPOV Measureware Agent&nbsp;</td><td>$HPMWA&nbsp;</td></tr>" >> /tmp/$LOGFILE.html
fi

if [ `grep -i HPOvCtrl $RPMINFO | wc -l` -ne 0 ]
then
	echo "<tr><td>HPOV Control Agent&nbsp;</td><td>$HPOVCTRL&nbsp;</td></tr>" >> /tmp/$LOGFILE.html
fi

if [ `grep -i OPC $RPMINFO | wc -l` -ne 0 ]
then
	echo "<tr><td>HPOV IT/Operations Agent&nbsp;</td><td>$OPC&nbsp;</td></tr>" >> /tmp/$LOGFILE.html
fi
if [ `grep -i CISscan $RPMINFO | wc -l` -ne 0 ]
then
	echo "<tr><td>Host-based Scanning Tool&nbsp;</td><td>$CIS&nbsp;</td></tr>" >> /tmp/$LOGFILE.html
fi

echo "<tr><td>JAVA Version&nbsp;</td><td>$JAVA&nbsp;</td></tr>" >> /tmp/$LOGFILE.html
echo "</table>" >> /tmp/$LOGFILE.html
echo "</center></div>" >> /tmp/$LOGFILE.html
echo "<br>" >> /tmp/$LOGFILE.html

echo "<p><a name=\"Disk\"></a><strong>Filesystem Allocation Information</strong></p>" >> /tmp/$LOGFILE.html
echo "<div align=\"center\"><center>" >> /tmp/$LOGFILE.html
echo "<table border=\"1\" width=\"100%\" bordercolor=\"#000000\">" >> /tmp/$LOGFILE.html
echo "<tr><td>FileSystem&nbsp;</td><td>Capacity (GB)&nbsp;</td><td>Free Space (GB)&nbsp;</td><td>Percentage Free&nbsp;</td><td>Mounted On&nbsp;</td></tr>" >> /tmp/$LOGFILE.html
df -Pk | egrep -v "^fd|^Filesystem|proc|mnttab|^swap|cdrom" | awk '{print "<tr><td>"$1"&nbsp;</td><td>"$2/1024/1024"&nbsp;</td><td>"$4/1024/1024"&nbsp;</td><td>"$5"&nbsp;</td><td>"$6"&nbsp;</td></tr>"}' >> /tmp/$LOGFILE.html
echo "</table>" >> /tmp/$LOGFILE.html
echo "</center></div>" >> /tmp/$LOGFILE.html
echo "<br>" >> /tmp/$LOGFILE.html


if [ 1 -ne 0 ]
then
	echo "<p><a name=\"EDisk\"></a><strong>External Physical Disk Allocation</strong></p>" >> /tmp/$LOGFILE.html
	echo "<div align=\"center\"><center>" >> /tmp/$LOGFILE.html
	echo "<table border=\"1\" width=\"100%\" bordercolor=\"#000000\">" >> /tmp/$LOGFILE.html
	echo "<tr><td>Device File&nbsp;</td><td>Target ID&nbsp;</td><td>LUN ID&nbsp;</td><td>Port ID&nbsp;</td><td>CU:LDev&nbsp;</td><td>Device Size(GB)&nbsp;</td><td>Serial #&nbsp;</td><td>BC Vol&nbsp;</td><td>RAID Level&nbsp;</td></tr>" >> /tmp/$LOGFILE.html
	echo "<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td><strong>Total</strong>&nbsp;</td><td><strong>$T</strong>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>" >> /tmp/$LOGFILE.html
	echo "</table>" >> /tmp/$LOGFILE.html
	echo "</center></div>" >> /tmp/$LOGFILE.html
	echo "<br>" >> /tmp/$LOGFILE.html
fi

echo "<p><a name=\"SYSTEM1\"></a><strong>Kernel Parameters (/etc/sysctl.conf)</strong></p>" >> /tmp/$LOGFILE.html
echo "<div align=\"center\"><center>" >> /tmp/$LOGFILE.html
echo "<table border=\"1\" width=\"100%\"><tr><td width=\"100%\" bordercolor=\"#000000\">" >> /tmp/$LOGFILE.html
sed '/^*/d;/^$/d;s/$/<br>/' /etc/sysctl.conf >> /tmp/$LOGFILE.html
echo "</table>" >> /tmp/$LOGFILE.html
echo "</center></div>" >> /tmp/$LOGFILE.html
echo "<br>" >> /tmp/$LOGFILE.html


echo "<p><a name=\"CKSUM\"></a><strong>Checksum Information</strong></p>" >> /tmp/$LOGFILE.html
echo "<div align=\"center\"><center>" >> /tmp/$LOGFILE.html
echo "<table border=\"1\" width=\"100%\" bordercolor=\"#000000\">" >> /tmp/$LOGFILE.html
echo "<tr><td>Checksum&nbsp;</td><td># of Octets&nbsp;</td><td>FileName&nbsp;</td></tr>" >> /tmp/$LOGFILE.html
for CKSUM in /etc/hosts /etc/netmasks /etc/defaultrouter /etc/system /etc/services /etc/fstab /kernel/drv/sd.conf /kernel/drv/jnic146x.conf /kernel/drv/qla2300.conf /kernel/drv/vxdmp.conf
do
	if [ -f $CKSUM ]
	then
		cksum $CKSUM | awk '{print "<tr><td>"$1,"&nbsp;</td><td>"$2,"&nbsp;</td><td>"$3"&nbsp;</td></tr>"}' >> /tmp/$LOGFILE.html
	fi
done
echo "</table>" >> /tmp/$LOGFILE.html
echo "</center></div>" >> /tmp/$LOGFILE.html
echo "<br>" >> /tmp/$LOGFILE.html

echo "<p><a name=\"SERVICES\"></a><strong>Ports Services Information(/etc/services)</strong></p>" >> /tmp/$LOGFILE.html
echo "<div align=\"center\"><center>" >> /tmp/$LOGFILE.html
echo "<table border=\"1\" width=\"100%\"><tr><td width=\"100%\" bordercolor=\"#000000\">" >> /tmp/$LOGFILE.html
sed '/^#/d;/^$/d;s/$/<br>/' /etc/services >> /tmp/$LOGFILE.html
echo "</table>" >> /tmp/$LOGFILE.html
echo "</center></div>" >> /tmp/$LOGFILE.html
echo "<br>" >> /tmp/$LOGFILE.html


echo "<hr>" >> /tmp/$LOGFILE.html
echo "</font>" >> /tmp/$LOGFILE.html
echo "<DIV id=\"divFooter\">" >> /tmp/$LOGFILE.html
echo "<P id=\"creator\">This information is only for internal purposes. Maintained by <A href=\"mailto:Server_team@clsa.com\" target=\"_blank\"><STRONG>Server Team</STRONG></A>.</P>" >> /tmp/$LOGFILE.html
echo "</DIV> " >> /tmp/$LOGFILE.html
echo "</body>" >> /tmp/$LOGFILE.html
echo "</html>" >> /tmp/$LOGFILE.html