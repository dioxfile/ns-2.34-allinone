# ns-2.34-allinone
## WARNING -> Before starting the installation of NS-2, install the following programs via apt-get:
##### ```$ sudo apt-get update && sudo apt-get install build-essential autoconf automake libxmu-dev xorg-dev gcc g++```

# NS-2 bugs-free installation, and with OLSR (UM-OLSR) Protocol Developed by Francisco J. Ros from Murcia University!!!

## 1. Introduction
----------------

Ns-allinone is a package that contains required components and some of
the optional components used in running ns. The package contains an
"install" script to configure, compile, and install these
components automatically. If you haven't installed ns before and want to quickly try
ns out, ns-allinone may be easier than getting all the pieces by hand.
 
Currently, the package contains:
  
- Tcl       Tcl release 8.4.18    (required component)
- Tk        Tk release 8.4.18     (required component)
- Otcl      otcl release 1.13    (required component)
- TclCL     tclcl release 1.19  (required component)
- Ns        ns release 2.33    (required component)
- Nam       Nam release 1.13       (optional component)
- Xgraph    xgraph version 12     (optional component)
- GT-ITM    Georgia Tech Internetwork
            Topology Modeler      (optional component)
- SGB       Stanford GraphBase
            package               (optional component)
- CWEB      CWeb version 1.0 (?)  (optional component)
- ZLib      zlib version 1.2.3    (optional component) 

## 2. FEATURES IN ns-allinone-2.34
-------------------------------

Features in this version include:
 
- Self-containing: All installation will be kept in a directory to help
		   the user manages and uses the package. The execution of ns or nam does not need any other support outside
		   this directory;

- Bugs fixed:      All components inside the package, are the most recent 
                   versions;

- Easy to use:    Only one-line command is needed to build all ns
		   components.

## 3. Installing the package
--------------------------

All you need to do is type "./install" under this directory. The install
script will compile and install the whole package for you. The script also
will tell you the final installation result.


## 4. More information
--------------------

Ns-allinone is available from
<http://sourceforge.net/projects/nsnam>
or
<http://www.isi.edu/nsnam/ns/ns-build.html>

-----------------------------
The nsnam Project
http://www.nsnam.org

=======
# OBS - This NS-2 version was installed in Linux Debian 11 and Linux Mint (20.3 and 21) successfully and without bugs!!!
### Sha256sum ae216aeaf3a95b07cb996f408116b449264d77ee252e5258d3405b48e69fe50e

### Md5 688d8d5905415b911e4e84f8db7f2aa3
#OBS: Download this files to test ns installation: normalEnviroment_CBR.tcl, PM_10n_600xy.tcl, and D_cbrTraf4.tcl.
# For instance: `$ ns normalEnviroment_CBR.tcl`

