#!/bin/sh

PRTCONF=/tmp/PRTCONF
PRTDIAG=/tmp/PRTDIAG
PSRINFO=/tmp/PSRINFO
PKGINFO=/tmp/PKGINFO

/usr/sbin/prtconf > $PRTCONF
/usr/platform/`uname -m`/sbin/prtdiag > $PRTDIAG
/usr/sbin/psrinfo -v > $PSRINFO
/usr/bin/pkginfo > $PKGINFO

HOSTNAME=`uname -n | awk -F. '{print $1}'`
PROCESSORTYPE=`uname -p`
HOSTID=`hostid`
LOGFILE="$HOSTNAME-webinfo"
OSVERSION=`uname -sr`
OSREAL=`cat /etc/release | head -1`
OSPATCH=`uname -v`
PLATFORM=`uname -i`
ARCH=`uname -m`
BOOTPROM=`prtconf -V`
MODEL=`grep "^System Configuration" $PRTDIAG | awk '{print $8}'`
MEMORY=`grep Memory $PRTCONF | awk '{print $3/1024"GB"}'`
MEMORYCONFIG=`grep "MB" $PRTDIAG | egrep -v "CPU|MHz" | awk '{print $6}' | sort -n | uniq -c | awk '{print $1*2,"x "$2}'`
CPUON=`grep MHz $PSRINFO | awk '{print $6}' | sort -n | uniq -c | awk '{print $1,"x "$2"MHz"}'`
CPUOFF=`psrinfo | grep off-line | wc -l`
TIMEZONE=`date | cut -c21-24`


if [ -f /etc/opt/SUNWexplo/default/explorer ]
then
	SERIALNO=`cat -s /etc/opt/SUNWexplo/default/explorer | grep "^EXP_SERIAL_" | awk -F"=" '{print $2}' | sed -e 's/"//g'`
fi

case `cat -s /var/sadm/system/admin/CLUSTER | awk -F"=" '{print $2}'` in
	SUNWCXall) 	METACLUSTER="Entire Distribution + OEM Support" ;; 
	SUNCall)	METACLUSTER="Entire Distribution" ;;
	SUNWCprog) 	METACLUSTER="Developer System Support" ;;
	SUNWCuser) 	METACLUSTER="End User system Support" ;;
	SUNWCreq) 	METACLUSTER="Core" ;;
	*)		METACLUSTER="Unknown" ;;
esac

if [ `grep JNIC146x $PKGINFO | wc -l` -ne 0 ]
then
	JNIHBA=`pkginfo -l JNIC146x | grep VERSION | cut -c14-`
	SNIA=`pkginfo -l JNIsnia | grep VERSION | cut -c14-`
	RAIDMGRXP=`raidscan -h | grep "^Ver" | awk '{print $2}'`
	HBAWWPN=`grep WWPN /var/adm/messages | tail -2 | awk -F: '{print $4,$7}' | cut -c26-`
fi

if [ `grep QLA2300 $PKGINFO | wc -l` -ne 0 ]
then
	QLAHBA=`pkginfo -l QLA2300 | grep VERSION | cut -c14-`
fi

if [ `grep LGTOaama $PKGINFO | wc -l` -ne 0 ]
then
	LAAM=`pkginfo -l LGTOaama | grep VERSION | cut -c14-`
fi
if [ `grep HPmwa $PKGINFO | wc -l` -ne 0 ]
then
	HPMWA=`pkginfo -l HPmwa | grep VERSION | cut -c14-`
fi
if [ `grep OPC $PKGINFO | wc -l` -ne 0 ]
then
	OPC=`pkginfo -l OPC | grep VERSION | cut -c14-`
fi
if [ `grep HPOVSAMAP $PKGINFO | wc -l` -ne 0 ]
then
	HPOVSAM=`pkginfo -l HPOVSAMAP | grep VERSION | cut -c14-`
fi
if [ `grep SMCossld $PKGINFO | wc -l` -ne 0 ]
then
	SSL=`pkginfo -l SMCossld | grep VERSION | cut -c14-`
fi
if [ `grep SUNWjass $PKGINFO | wc -l` -ne 0 ]
then
	JASS=`pkginfo -l SUNWjass | grep VERSION | cut -c14-`
fi
if [ `grep CISscan $PKGINFO | wc -l` -ne 0 ]
then
	CIS=`pkginfo -l CISscan | grep VERSION | cut -c14-`
fi
if [ `grep SUNWmdu $PKGINFO | wc -l` -ne 0 ]
then
	SDS=`pkginfo -l SUNWmdu | grep VERSION | cut -c14-`
fi
if [ `grep SUNWexplo $PKGINFO | wc -l` -ne 0 ]
then
	SUNEXPLO=`pkginfo -l SUNWexplo | grep VERSION | cut -c14-`
fi
if [ `grep VRTSspt $PKGINFO | wc -l` -ne 0 ]
then
	VRTSEXPLO=`pkginfo -l VRTSspt | grep VERSION | cut -c14-`
fi
if [ `grep EMCpower $PKGINFO | wc -l` -ne 0 ]
then
	EMCPOWERPATH=`pkginfo -l EMCpower | grep VERSION | cut -c14-`
fi

JAVA=`java -version 2>&1 | grep version | sed -e 's/"//g' | awk '{print $3}'`
QFE=`grep "SUNW,qfe," $PRTCONF | wc -l | awk '{print $1/4 " "}'`
SWIFT=`grep "SUNW,isptwo," $PRTCONF | wc -l | awk '{print $1 " "}'`
GE=`grep "SUNW,pci-ce" $PRTDIAG | wc -l | awk '{print $1 " "}'`
JNI=`grep "JNI,FCR," $PRTCONF | wc -l | awk '{print $1 " "}'`
QLA=`grep "QLGC,qla," $PRTCONF | wc -l | awk '{print $1 " "}'`
DFCAL=`grep 'SUNW,qlc-pci1077,2200.1077.4083.+' $PRTDIAG | wc -l | awk '{print $1/2}'`
SFCAL=`grep 'SUNW,qlc-pci1077,2200.1077.4082.+' $PRTDIAG | wc -l | awk '{print $1}'`
SESCSI=`grep "Symbios,53C875" $PRTDIAG | wc -l | awk '{print $1/2}'`
DSCSI=`grep 'scsi-pci1000,f.1000.1000.14/disk+' $PRTDIAG | wc -l | awk '{print $1/2}'`
GRAPHICS=`grep 'SUNW,370-4362' $PRTDIAG | wc -l | awk '{print $1}'`
OTHERS=`grep 'pci12b6,3220-pci1011,46.12b6.322+' $PRTDIAG | wc -l | awk '{print $1}'`

echo "<html>" > /tmp/$LOGFILE.html
echo "<head>" >> /tmp/$LOGFILE.html
echo "<meta http-equiv=\"Content-Type\"" >> /tmp/$LOGFILE.html
echo "content=\"text/html; charset=iso-8859-1\">" >> /tmp/$LOGFILE.html
echo "<title>$HOSTNAME - Server Information</title>" >> /tmp/$LOGFILE.html
echo "</head>" >> /tmp/$LOGFILE.html
echo "<body bgcolor=\"#FFFFFF\">" >> /tmp/$LOGFILE.html
echo "<font face=\"Arial\">" >> /tmp/$LOGFILE.html

echo "<p align=\"center\"><strong>$HOSTNAME Server Information</strong></p>" >> /tmp/$LOGFILE.html
echo "<p><a href=\"#Host\">Host Information</a><br>" >> /tmp/$LOGFILE.html
#echo "<a href=\"#HW\">Hardware Interface Information</a><br>" >> /tmp/$LOGFILE.html
echo "<a href=\"#NW\">Network Interface Information</a><br>" >> /tmp/$LOGFILE.html
echo "<a href=\"#NETSTAT\">Network Route Information</a><br>" >> /tmp/$LOGFILE.html
#echo "<a href=\"#ADDROUTE\">Additional Network Route Information (/etc/rc2.d/S99routeadd)</a><br>" >> /tmp/$LOGFILE.html
echo "<a href=\"#USER\">User ID Information</a><br>" >> /tmp/$LOGFILE.html
echo "<a href=\"#HOSTS\">Hosts Information(/etc/hosts)</a><br>" >> /tmp/$LOGFILE.html
echo "<a href=\"#NETMASK\">Netmask Information(/etc/netmasks)</a><br>" >> /tmp/$LOGFILE.html
echo "<a href=\"#ROUTER\">DefaultRouter Information(/etc/defaultrouter)</a><br>" >> /tmp/$LOGFILE.html
echo "<a href=\"#SERVICES\">Ports Services Information(/etc/services)</a><br>" >> /tmp/$LOGFILE.html
echo "<a href=\"#VFSTAB\">vfstab Information(/etc/vfstab)</a><br>" >> /tmp/$LOGFILE.html
echo "<a href=\"#Ver\">Version Information</a><br>" >> /tmp/$LOGFILE.html
echo "<a href=\"#Disk\">Filesystem Allocation Information</a><br>" >> /tmp/$LOGFILE.html

echo "<a href=\"#SYSTEM1\">Kernel Parameters (/etc/system)</a><br>" >> /tmp/$LOGFILE.html
if [ `grep JNIC146x $PKGINFO | wc -l` -ne 0 ]
then
	echo "<a href=\"#SYSTEM2\">JNI Driver Parameters (/kernel/drv/jnic146x.conf)</a><br>" >> /tmp/$LOGFILE.html
	echo "<a href=\"#SYSTEM4\">sd Driver Parameters (/kernel/drv/sd.conf)</a><br>" >> /tmp/$LOGFILE.html
fi
if [ `grep QLA2300 $PKGINFO | wc -l` -ne 0 ]
then
	echo "<a href=\"#SYSTEM5\">QLogic Driver Parameters (/kernel/drv/qla2300.conf)</a><br>" >> /tmp/$LOGFILE.html
	if [ `grep JNIC146x $PKGINFO | wc -l` -eq 0 ]
	then
		echo "<a href=\"#SYSTEM6\">sd Driver Parameters (/kernel/drv/sd.conf)</a><br>" >> /tmp/$LOGFILE.html
	fi
fi

echo "<a href=\"#CKSUM\">Checksum Information</a><br>" >> /tmp/$LOGFILE.html
echo "<p><a name=\"Host\"></a><strong>Host Information</strong></p>" >> /tmp/$LOGFILE.html
echo "<div align=\"center\"><center>" >> /tmp/$LOGFILE.html
echo "<table border=\"1\" width=\"100%\" bordercolor=\"#000000\">" >> /tmp/$LOGFILE.html
echo "<tr><td>Hostname</td><td>$HOSTNAME</td></tr>" >> /tmp/$LOGFILE.html
echo "<tr><td>HostID</td><td>$HOSTID</td></tr>" >> /tmp/$LOGFILE.html
echo "<tr><td>Serial No.</td><td>$SERIALNO</td></tr>" >> /tmp/$LOGFILE.html
echo "<tr><td>BootPROM</td><td>$BOOTPROM</td></tr>" >> /tmp/$LOGFILE.html
echo "<tr><td>Arch / Processor / Platform / Model</td><td>$ARCH / $PROCESSORTYPE / $PLATFORM / $MODEL</td></tr>" >> /tmp/$LOGFILE.html
echo "<tr><td>Memory</td><td>$MEMORY ($MEMORYCONFIG)</td></tr>" >> /tmp/$LOGFILE.html
echo "<tr><td>CPU Online/Offline</td><td>$CPUON / $CPUOFF</td></tr>" >> /tmp/$LOGFILE.html
echo "<tr><td>Timezone</td><td>$TIMEZONE</td></tr>" >> /tmp/$LOGFILE.html
echo "<tr><td>OS Meta Cluster installed</td><td>$METACLUSTER</td></tr>" >> /tmp/$LOGFILE.html
if [ "$HBAWWPN" != "" ]
then
	echo "<tr><td>HBA installed</td><td>$HBAWWPN</td></tr>" >> /tmp/$LOGFILE.html
fi
echo "</table>" >> /tmp/$LOGFILE.html
echo "</center></div>" >> /tmp/$LOGFILE.html
echo "<br>" >> /tmp/$LOGFILE.html

# echo "</table>" >> /tmp/$LOGFILE.html
# echo "</center></div>" >> /tmp/$LOGFILE.html
# echo "<br>" >> /tmp/$LOGFILE.html
# echo "<p><a name=\"HW\"></a><strong>Hardware Interface Information</strong></p>" >> /tmp/$LOGFILE.html
# echo "<div align=\"center\"><center>" >> /tmp/$LOGFILE.html
# echo "<table border=\"1\" width=\"100%\" bordercolor=\"#000000\">" >> /tmp/$LOGFILE.html
# echo "<tr><td>Quad Fast Ethernet</td><td>$QFE</td></tr>" >> /tmp/$LOGFILE.html
# echo "<tr><td>Swift(Ethernet + SCSI)</td><td>$SWIFT</td></tr>" >> /tmp/$LOGFILE.html
# echo "<tr><td>Gigabit Ethernet</td><td>$GE</td></tr>" >> /tmp/$LOGFILE.html
# if [ `grep JNIC146x $PKGINFO | wc -l` -ne 0 ]
# then
	# echo "<tr><td>JNI HBA</td><td>$JNI</td></tr>" >> /tmp/$LOGFILE.html
# fi
# if [ `grep QLA2300 $PKGINFO | wc -l` -ne 0 ]
# then
	# echo "<tr><td>QLogic HBA</td><td>$QLA</td></tr>" >> /tmp/$LOGFILE.html
# fi
# echo "<tr><td>Dual Channel FCAL</td><td>$DFCAL</td></tr>" >> /tmp/$LOGFILE.html
# echo "<tr><td>Single Channel FCAL</td><td>$SFCAL</td></tr>" >> /tmp/$LOGFILE.html
# echo "<tr><td>Dual Channel SE SCSI</td><td>$SESCSI</td></tr>" >> /tmp/$LOGFILE.html
# echo "<tr><td>Dual Channel Diff SCSI</td><td>$DSCSI</td></tr>" >> /tmp/$LOGFILE.html
# echo "<tr><td>PGX64 Graphics</td><td>$GRAPHICS</td></tr>" >> /tmp/$LOGFILE.html
# echo "<tr><td>Others</td><td>$OTHERS</td></tr>" >> /tmp/$LOGFILE.html
# echo "</table>" >> /tmp/$LOGFILE.html
# echo "</center></div>" >> /tmp/$LOGFILE.html
# echo "<br>" >> /tmp/$LOGFILE.html

echo "<p><a name=\"NW\"></a><strong>Network Interface Information</strong></p>" >> /tmp/$LOGFILE.html
echo "<div align=\"center\"><center>" >> /tmp/$LOGFILE.html
echo "<table border=\"1\" width=\"100%\" bordercolor=\"#000000\">" >> /tmp/$LOGFILE.html
echo "<tr><td>Interface</td><td>IP Address</td><td>Netmask</td></tr>" >> /tmp/$LOGFILE.html
for i in `/usr/sbin/ifconfig -a | egrep -v "ethers|lo0|127.0.0.1" | grep flags | awk '{print $1}' | sed -e "s/:$//"`
do
        netmask=`/usr/sbin/ifconfig $i | grep inet | awk '{print $4}'`
        NETMASK=`echo $netmask | tr '[a-f]' '[A-F]'`
        hfirst=`echo $NETMASK | cut -c1-2`
        hsecond=`echo $NETMASK | cut -c3-4`
        hthird=`echo $NETMASK | cut -c5-6`
        hfourth=`echo $NETMASK | cut -c7-8`
        dfirst=`echo "ibase=16; $hfirst" | bc`
        dsecond=`echo "ibase=16; $hsecond" | bc`
        dthird=`echo "ibase=16; $hthird" | bc`
        dfourth=`echo "ibase=16; $hfourth" | bc`
        echo "<tr><td>$i</td><td>`/usr/sbin/ifconfig $i | grep inet | awk '{print $2}'`</td><td>${dfirst}.${dsecond}.${dthird}.${dfourth}</td></tr>" >> /tmp/$LOGFILE.html
done
echo "</table>" >> /tmp/$LOGFILE.html
echo "</center></div>" >> /tmp/$LOGFILE.html
echo "<br>" >> /tmp/$LOGFILE.html

echo "<p><a name=\"NETSTAT\"></a><strong>Network Route Information</strong></p>" >> /tmp/$LOGFILE.html
echo "<div align=\"center\"><center>" >> /tmp/$LOGFILE.html
echo "<table border=\"1\" width=\"100%\" bordercolor=\"#000000\">" >> /tmp/$LOGFILE.html
netstat -nr| sed '/^127.0.0.1/d;/^224.0.0.0/d;/^Routing/d;/^-/d;/^$/d' | awk '{print "<tr><td>"$1,"</td><td>"$2,"</td><td>"$6"</td></tr>"}' >> /tmp/$LOGFILE.html
echo "</table>" >> /tmp/$LOGFILE.html
echo "</center></div>" >> /tmp/$LOGFILE.html
echo "<br>" >> /tmp/$LOGFILE.html

echo "<p><a name=\"USER\"></a><strong>User ID Information</strong></p>" >> /tmp/$LOGFILE.html
echo "<div align=\"center\"><center>" >> /tmp/$LOGFILE.html
echo "<table border=\"1\" width=\"100%\" bordercolor=\"#000000\">" >> /tmp/$LOGFILE.html
echo "<tr><td>Username</td><td>User ID</td><td>Home dir.</td><td>Login Shell</td><td>Comments</td></tr>" >> /tmp/$LOGFILE.html
cat /etc/passwd | awk -F: '{print "<tr><td>"$1,"</td><td>"$3,"</td><td>"$6,"</td><td>"$7,"</td><td>"$5"</td></tr>"}' >> /tmp/$LOGFILE.html
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

echo "<p><a name=\"NETMASK\"></a><strong>Netmask Information(/etc/netmasks)</strong></p>" >> /tmp/$LOGFILE.html
echo "<div align=\"center\"><center>" >> /tmp/$LOGFILE.html
echo "<table border=\"1\" width=\"100%\"><tr><td width=\"100%\" bordercolor=\"#000000\">" >> /tmp/$LOGFILE.html
sed '/^#/d;/^$/d;s/$/<br>/' /etc/netmasks >> /tmp/$LOGFILE.html
echo "</table>" >> /tmp/$LOGFILE.html
echo "</center></div>" >> /tmp/$LOGFILE.html
echo "<br>" >> /tmp/$LOGFILE.html

echo "<p><a name=\"ROUTER\"></a><strong>DefaultRouter Information(/etc/defaultrouter)</strong></p>" >> /tmp/$LOGFILE.html
echo "<div align=\"center\"><center>" >> /tmp/$LOGFILE.html
echo "<table border=\"1\" width=\"100%\"><tr><td width=\"100%\" bordercolor=\"#000000\">" >> /tmp/$LOGFILE.html
sed '/^#/d;/^$/d;s/$/<br>/' /etc/defaultrouter >> /tmp/$LOGFILE.html
echo "</table>" >> /tmp/$LOGFILE.html
echo "</center></div>" >> /tmp/$LOGFILE.html
echo "<br>" >> /tmp/$LOGFILE.html

echo "<p><a name=\"VFSTAB\"></a><strong>vfstab Information(/etc/vfstab)</strong></p>" >> /tmp/$LOGFILE.html
echo "<div align=\"center\"><center>" >> /tmp/$LOGFILE.html
echo "<table border=\"1\" width=\"100%\"><tr><td width=\"100%\" bordercolor=\"#000000\">" >> /tmp/$LOGFILE.html
sed '/^#/d;/^$/d;s/$/<br>/' /etc/vfstab >> /tmp/$LOGFILE.html
echo "</table>" >> /tmp/$LOGFILE.html
echo "</center></div>" >> /tmp/$LOGFILE.html
echo "<br>" >> /tmp/$LOGFILE.html

echo "<p><a name=\"Ver\"></a><strong>Version Information</strong></p>" >> /tmp/$LOGFILE.html
echo "<div align=\"center\"><center>" >> /tmp/$LOGFILE.html
echo "<table border=\"1\" width=\"100%\" bordercolor=\"#000000\">" >> /tmp/$LOGFILE.html
echo "<tr> <td>OperatingSystem</td> <td>$OSVERSION</td></tr>" >> /tmp/$LOGFILE.html
echo "<tr> <td>OperatingSystemRelease</td> <td>$OSREAL</td></tr>" >> /tmp/$LOGFILE.html
echo "<tr> <td>KernelPatchVersion</td> <td>$OSPATCH</td></tr>" >> /tmp/$LOGFILE.html

if [ `grep EMCpower $PKGINFO | wc -l` -ne 0 ]
then
	echo "<tr><td>EMC PowerPath</td><td>$EMCPOWERPATH</td></tr>" >> /tmp/$LOGFILE.html
fi
if [ `grep QLA2300 $PKGINFO | wc -l` -ne 0 ]
then
	echo "<tr><td>QLAHBADriverVersion</td><td>$QLAHBA</td></tr>" >> /tmp/$LOGFILE.html
fi
if [ `grep JNIC146x $PKGINFO | wc -l` -ne 0 ]
then
	echo "<tr><td>ArraySupportedLibraryVersion</td><td>$ASL</td></tr>" >> /tmp/$LOGFILE.html
	echo "<tr><td>JNIHBADriverVersion</td><td>$JNIHBA</td></tr>" >> /tmp/$LOGFILE.html
	echo "<tr><td>SNIADriverVersion</td><td>$SNIA</td></tr>" >> /tmp/$LOGFILE.html
	echo "<tr><td>XPinfoVersion</td><td>$XPINFO</td></tr>" >> /tmp/$LOGFILE.html
	echo "<tr><td>RAID Manager XP</td><td>$RAIDMGRXP</td></tr>" >> /tmp/$LOGFILE.html
fi

if [ `grep LGTOaama $PKGINFO | wc -l` -ne 0 ]
then
	echo "<tr><td>Legato AAM</td> <td>$LAAM</td></tr>" >> /tmp/$LOGFILE.html
fi
if [ `grep HPmwa $PKGINFO | wc -l` -ne 0 ]
then
	echo "<tr><td>HPOV Measureware Agent</td><td>$HPMWA</td></tr>" >> /tmp/$LOGFILE.html
fi
if [ `grep OPC $PKGINFO | wc -l` -ne 0 ]
then
	echo "<tr><td>HPOV IT/Operations Agent</td><td>$OPC</td></tr>" >> /tmp/$LOGFILE.html
fi
if [ `grep HPOVSAMAP $PKGINFO | wc -l` -ne 0 ]
then
	echo "<tr><td>HPOV Storage Area Mgr</td><td>$HPOVSAM</td></tr>" >> /tmp/$LOGFILE.html
fi
if [ `grep SMCossld $PKGINFO | wc -l` -ne 0 ]
then
	echo "<tr><td>OpenSSL</td><td>$SSL</td></tr>" >> /tmp/$LOGFILE.html
fi
if [ `grep SUNWjass $PKGINFO | wc -l` -ne 0 ]
then
	echo "<tr><td>Solaris Security Toolkit</td><td>$JASS</td></tr>" >> /tmp/$LOGFILE.html
fi
if [ `grep CISscan $PKGINFO | wc -l` -ne 0 ]
then
	echo "<tr><td>Host-based Scanning Tool</td><td>$CIS</td></tr>" >> /tmp/$LOGFILE.html
fi
if [ `grep SUNWmdu $PKGINFO | wc -l` -ne 0 ]
then
	echo "<tr><td>Solstice DiskSuite</td><td>$SDS</td></tr>" >> /tmp/$LOGFILE.html
fi
if [ `grep SUNWexplo $PKGINFO | wc -l` -ne 0 ]
then
	echo "<tr><td>SUN Explorer</td><td>$SUNEXPLO</td></tr>" >> /tmp/$LOGFILE.html
fi
echo "<tr><td>JAVA Version</td><td>$JAVA</td></tr>" >> /tmp/$LOGFILE.html
echo "</table>" >> /tmp/$LOGFILE.html
echo "</center></div>" >> /tmp/$LOGFILE.html
echo "<br>" >> /tmp/$LOGFILE.html

echo "<p><a name=\"Disk\"></a><strong>Filesystem Allocation Information</strong></p>" >> /tmp/$LOGFILE.html
echo "<div align=\"center\"><center>" >> /tmp/$LOGFILE.html
echo "<table border=\"1\" width=\"100%\" bordercolor=\"#000000\">" >> /tmp/$LOGFILE.html
#echo "<tr><td>FileSystem</td><td>Capacity (GB)</td><td>Free Space (GB)</td><td>Percentage Free</td><td>Mounted On</td></tr>" >> /tmp/$LOGFILE.html
echo "<tr><td>FileSystem&nbsp;</td><td>Capacity (GB)&nbsp;</td><td>Free Space (GB)&nbsp;</td><td>Percentage Free&nbsp;</td><td>Mounted On&nbsp;</td></tr>" >> /tmp/$LOGFILE.html
#df -k | egrep -v "^fd|^Filesystem|proc|mnttab|^swap|cdrom" | awk '{print "<tr><td>"$1"</td><td>"$2/1024/1024"</td><td>"$4/1024/1024"</td><td>"$5"</td><td>"$6"</td></tr>"}' >> /tmp/$LOGFILE.html
df -k | egrep -v "^fd|^Filesystem|proc|mnttab|^swap|cdrom" | awk '{print "<tr><td>"$1"&nbsp;</td><td>"$2/1024/1024"&nbsp;</td><td>"$4/1024/1024"&nbsp;</td><td>"$5"&nbsp;</td><td>"$6"&nbsp;</td></tr>"}' >> /tmp/$LOGFILE.html
echo "</table>" >> /tmp/$LOGFILE.html
echo "</center></div>" >> /tmp/$LOGFILE.html
echo "<br>" >> /tmp/$LOGFILE.html

if [ 1 -ne 0 ]
then
	echo "<p><a name=\"EDisk\"></a><strong>External Physical Disk Allocation</strong></p>" >> /tmp/$LOGFILE.html
	echo "<div align=\"center\"><center>" >> /tmp/$LOGFILE.html
	echo "<table border=\"1\" width=\"100%\" bordercolor=\"#000000\">" >> /tmp/$LOGFILE.html
	echo "<tr><td>Device File</td><td>Target ID</td><td>LUN ID</td><td>Port ID</td><td>CU:LDev</td><td>Device Size(GB)</td><td>Serial #</td><td>BC Vol</td><td>RAID Level</td></tr>" >> /tmp/$LOGFILE.html
	T=`#xpinfo -d | grep CL | awk -F, '{print $5,$7}' | sort -n | uniq -c | awk 'BEGIN {s=0} {s+=($3/1024)} END {print s}'`
	echo "<tr><td></td><td></td><td></td><td></td><td><strong>Total</strong></td><td><strong>$T</strong></td><td></td><td></td><td></td></tr>" >> /tmp/$LOGFILE.html
	echo "</table>" >> /tmp/$LOGFILE.html
	echo "</center></div>" >> /tmp/$LOGFILE.html
	echo "<br>" >> /tmp/$LOGFILE.html
fi

echo "<p><a name=\"SYSTEM1\"></a><strong>Kernel Parameters (/etc/system)</strong></p>" >> /tmp/$LOGFILE.html
echo "<div align=\"center\"><center>" >> /tmp/$LOGFILE.html
echo "<table border=\"1\" width=\"100%\"><tr><td width=\"100%\" bordercolor=\"#000000\">" >> /tmp/$LOGFILE.html
sed '/^*/d;/^$/d;s/$/<br>/' /etc/system >> /tmp/$LOGFILE.html
echo "</table>" >> /tmp/$LOGFILE.html
echo "</center></div>" >> /tmp/$LOGFILE.html
echo "<br>" >> /tmp/$LOGFILE.html

if [ `grep JNIC146x $PKGINFO | wc -l` -ne 0 ]
then
	echo "<p><a name=\"SYSTEM2\"></a><strong>JNI Driver Parameters (/kernel/drv/jnic146x.conf)</strong></p>" >> /tmp/$LOGFILE.html
	echo "<div align=\"center\"><center>" >> /tmp/$LOGFILE.html
	echo "<table border=\"1\" width=\"100%\"><tr><td width=\"100%\" bordercolor=\"#000000\">" >> /tmp/$LOGFILE.html
	sed '/^#/d;/^$/d;s/$/<br>/' /kernel/drv/jnic146x.conf >> /tmp/$LOGFILE.html
	echo "</table>" >> /tmp/$LOGFILE.html
	echo "</center></div>" >> /tmp/$LOGFILE.html
	echo "<br>" >> /tmp/$LOGFILE.html

	echo "<p><a name=\"SYSTEM4\"></a><strong>sd Driver Parameters (/kernel/drv/sd.conf)</strong></p>" >> /tmp/$LOGFILE.html
	echo "<div align=\"center\"><center>" >> /tmp/$LOGFILE.html
	echo "<table border=\"1\" width=\"100%\"><tr><td width=\"100%\" bordercolor=\"#000000\">" >> /tmp/$LOGFILE.html
	sed '/^#/d;/^$/d;s/$/<br>/' /kernel/drv/sd.conf >> /tmp/$LOGFILE.html
	echo "</table>" >> /tmp/$LOGFILE.html
	echo "</center></div>" >> /tmp/$LOGFILE.html
	echo "<br>" >> /tmp/$LOGFILE.html

fi

if [ `grep QLA2300 $PKGINFO | wc -l` -ne 0 ]
then
	echo "<p><a name=\"SYSTEM5\"></a><strong>QLogic Driver Parameters (/kernel/drv/qla2300.conf)</strong></p>" >> /tmp/$LOGFILE.html
	echo "<div align=\"center\"><center>" >> /tmp/$LOGFILE.html
	echo "<table border=\"1\" width=\"100%\"><tr><td width=\"100%\" bordercolor=\"#000000\">" >> /tmp/$LOGFILE.html
	sed '/^#/d;/^$/d;s/$/<br>/' /kernel/drv/qla2300.conf >> /tmp/$LOGFILE.html
	echo "</table>" >> /tmp/$LOGFILE.html
	echo "</center></div>" >> /tmp/$LOGFILE.html
	echo "<br>" >> /tmp/$LOGFILE.html

	if [ `grep JNIC146x $PKGINFO | wc -l` -eq 0 ]
	then
		echo "<p><a name=\"SYSTEM6\"></a><strong>sd Driver Parameters (/kernel/drv/sd.conf)</strong></p>" >> /tmp/$LOGFILE.html
		echo "<div align=\"center\"><center>" >> /tmp/$LOGFILE.html
		echo "<table border=\"1\" width=\"100%\"><tr><td width=\"100%\" bordercolor=\"#000000\">" >> /tmp/$LOGFILE.html
		sed '/^#/d;/^$/d;s/$/<br>/' /kernel/drv/sd.conf >> /tmp/$LOGFILE.html
		echo "</table>" >> /tmp/$LOGFILE.html
		echo "</center></div>" >> /tmp/$LOGFILE.html
		echo "<br>" >> /tmp/$LOGFILE.html
	fi
fi

echo "<p><a name=\"CKSUM\"></a><strong>Checksum Information</strong></p>" >> /tmp/$LOGFILE.html
echo "<div align=\"center\"><center>" >> /tmp/$LOGFILE.html
echo "<table border=\"1\" width=\"100%\" bordercolor=\"#000000\">" >> /tmp/$LOGFILE.html
echo "<tr><td>Checksum</td><td># of Octets</td><td>FileName</td></tr>" >> /tmp/$LOGFILE.html
for CKSUM in /etc/hosts /etc/netmasks /etc/defaultrouter /etc/system /etc/services /etc/vfstab /kernel/drv/sd.conf /kernel/drv/jnic146x.conf /kernel/drv/qla2300.conf /kernel/drv/vxdmp.conf
do
	if [ -f $CKSUM ]
	then
		cksum $CKSUM | awk '{print "<tr><td>"$1,"</td><td>"$2,"</td><td>"$3"</td></tr>"}' >> /tmp/$LOGFILE.html
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
