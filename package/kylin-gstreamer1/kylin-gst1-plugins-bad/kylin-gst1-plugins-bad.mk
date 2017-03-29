################################################################################
#
# gst1-plugins-bad
#
################################################################################

KYLIN_GST1_PLUGINS_BAD_VERSION = 1.8.3
KYLIN_GST1_PLUGINS_BAD_SOURCE = gst-plugins-bad-$(KYLIN_GST1_PLUGINS_BAD_VERSION).tar.xz
KYLIN_GST1_PLUGINS_BAD_SITE = https://gstreamer.freedesktop.org/src/gst-plugins-bad
KYLIN_GST1_PLUGINS_BAD_INSTALL_STAGING = YES
KYLIN_GST1_PLUGINS_BAD_LICENSE_FILES = COPYING COPYING.LIB
# Unknown and GPL licensed plugins will append to KYLIN_GST1_PLUGINS_BAD_LICENSE if
# enabled.
KYLIN_GST1_PLUGINS_BAD_LICENSE = LGPLv2+ LGPLv2.1+

KYLIN_GST1_PLUGINS_BAD_CONF_OPTS = \
	--disable-examples \
	--disable-valgrind \
	--disable-directsound \
	--disable-direct3d \
	--disable-winks \
	--disable-android_media \
	--disable-apple_media \
	--disable-sdltest \
	--disable-wininet \
	--disable-acm

# Options which require currently unpackaged libraries
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += \
	--disable-avc \
	--disable-opensles \
	--disable-uvch264 \
	--disable-voamrwbenc \
	--disable-bs2b \
	--disable-chromaprint \
	--disable-dc1394 \
	--disable-dts \
	--disable-resindvd \
	--disable-faac \
	--disable-flite \
	--disable-gsm \
	--disable-fluidsynth \
	--disable-kate \
	--disable-ladspa \
	--disable-lv2 \
	--disable-libde265 \
	--disable-srtp \
	--disable-linsys \
	--disable-modplug \
	--disable-mimic \
	--disable-mplex \
	--disable-nas \
	--disable-ofa \
	--disable-openexr \
	--disable-openni2 \
	--disable-pvr \
	--disable-libvisual \
	--disable-timidity \
	--disable-teletextdec \
	--disable-wildmidi \
	--disable-smoothstreaming \
	--disable-soundtouch \
	--disable-spc \
	--disable-gme \
	--disable-xvid \
	--disable-vdpau \
	--disable-schro \
	--disable-zbar \
	--disable-spandsp \
	--disable-sndio \
	--disable-gtk3 \
	--disable-qt

KYLIN_GST1_PLUGINS_BAD_DEPENDENCIES = kylin-gst1-plugins-base kylin-gstreamer1

ifeq ($(BR2_PACKAGE_RPI_USERLAND),y)
# RPI has odd locations for several required headers.
KYLIN_GST1_PLUGINS_BAD_CONF_ENV += \
	CPPFLAGS="$(TARGET_CPPFLAGS) \
	-I$(STAGING_DIR)/usr/include/IL \
	-I$(STAGING_DIR)/usr/include/interface/vcos/pthreads \
	-I$(STAGING_DIR)/usr/include/interface/vmcs_host/linux"
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_LIB_OPENGL_OPENGL),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-opengl
KYLIN_GST1_PLUGINS_BAD_DEPENDENCIES += libgl libglu
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-opengl
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_LIB_OPENGL_GLES2),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-gles2
KYLIN_GST1_PLUGINS_BAD_DEPENDENCIES += libgles
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-gles2
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_LIB_OPENGL_GLX),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-glx
KYLIN_GST1_PLUGINS_BAD_DEPENDENCIES += xproto_glproto xlib_libXrender
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-glx
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_LIB_OPENGL_EGL),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-egl
KYLIN_GST1_PLUGINS_BAD_DEPENDENCIES += libegl
KYLIN_GST1_PLUGINS_BAD_CONF_ENV += \
	CPPFLAGS="$(TARGET_CPPFLAGS) `$(PKG_CONFIG_HOST_BINARY) --cflags egl`" \
	LIBS="`$(PKG_CONFIG_HOST_BINARY) --libs egl`"
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-egl
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_LIB_OPENGL_X11),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-x11
KYLIN_GST1_PLUGINS_BAD_DEPENDENCIES += xlib_libX11 xlib_libXext
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-x11
endif

ifneq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_LIB_OPENGL_WAYLAND)$(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_WAYLAND),)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-wayland
KYLIN_GST1_PLUGINS_BAD_DEPENDENCIES += wayland
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-wayland
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_LIB_OPENGL_DISPMANX),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-dispmanx
KYLIN_GST1_PLUGINS_BAD_DEPENDENCIES += rpi-userland
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-dispmanx
endif

ifeq ($(BR2_PACKAGE_ORC),y)
KYLIN_GST1_PLUGINS_BAD_DEPENDENCIES += orc
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-orc
endif

ifeq ($(BR2_PACKAGE_BLUEZ_UTILS),y)
KYLIN_GST1_PLUGINS_BAD_DEPENDENCIES += bluez_utils
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-bluez
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-bluez
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_ACCURIP),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-accurip
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-accurip
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_ADPCMDEC),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-adpcmdec
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-adpcmdec
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_ADPCMENC),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-adpcmenc
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-adpcmenc
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_AIFF),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-aiff
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-aiff
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_ASFMUX),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-asfmux
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-asfmux
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_AUDIOFXBAD),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-audiofxbad
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-audiofxbad
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_AUDIOMIXER),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-audiomixer
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-audiomixer
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_COMPOSITOR),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-compositor
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-compositor
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_AUDIOVISUALIZERS),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-audiovisualizers
KYLIN_GST1_PLUGINS_BAD_HAS_GPL_LICENSE = y
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-audiovisualizers
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_AUTOCONVERT),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-autoconvert
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-autoconvert
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_BAYER),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-bayer
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-bayer
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_CAMERABIN2),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-camerabin2
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-camerabin2
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_CDXAPARSE),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-cdxaparse
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-cdxaparse
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_COLOREFFECTS),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-coloreffects
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-coloreffects
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_DATAURISRC),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-dataurisrc
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-dataurisrc
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_DCCP),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-dccp
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-dccp
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_DEBUGUTILS),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-debugutils
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-debugutils
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_DTLS),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-dtls
KYLIN_GST1_PLUGINS_BAD_DEPENDENCIES += openssl
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-dtls
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_DVBSUBOVERLAY),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-dvbsuboverlay
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-dvbsuboverlay
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_DVDSPU),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-dvdspu
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-dvdspu
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_FACEOVERLAY),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-faceoverlay
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-faceoverlay
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_FESTIVAL),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-festival
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-festival
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_FIELDANALYSIS),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-fieldanalysis
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-fieldanalysis
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_FREEVERB),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-freeverb
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-freeverb
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_FREI0R),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-frei0r
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-frei0r
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_GAUDIEFFECTS),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-gaudieffects
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-gaudieffects
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_GEOMETRICTRANSFORM),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-geometrictransform
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-geometrictransform
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_GDP),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-gdp
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-gdp
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_HDVPARSE),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-hdvparse
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-hdvparse
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_ID3TAG),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-id3tag
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-id3tag
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_INTER),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-inter
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-inter
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_INTERLACE),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-interlace
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-interlace
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_IVFPARSE),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-ivfparse
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-ivfparse
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_IVTC),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-ivtc
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-ivtc
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_JP2KDECIMATOR),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-jp2kdecimator
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-jp2kdecimator
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_JPEGFORMAT),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-jpegformat
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-jpegformat
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_LIBRFB),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-librfb
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-librfb
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_MIDI),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-midi
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-midi
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_MPEGDEMUX),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-mpegdemux
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-mpegdemux
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_MPEGTSDEMUX),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-mpegtsdemux
KYLIN_GST1_PLUGINS_BAD_HAS_UNKNOWN_LICENSE = y
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-mpegtsdemux
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_MPEGTSMUX),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-mpegtsmux
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-mpegtsmux
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_MPEGPSMUX),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-mpegpsmux
KYLIN_GST1_PLUGINS_BAD_HAS_UNKNOWN_LICENSE = y
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-mpegpsmux
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_MVE),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-mve
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-mve
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_MXF),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-mxf
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-mxf
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_NETSIM),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-netsim
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-netsim
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_NUVDEMUX),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-nuvdemux
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-nuvdemux
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_ONVIF),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-onvif
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-onvif
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_PATCHDETECT),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-patchdetect
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-patchdetect
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_PCAPPARSE),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-pcapparse
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-pcapparse
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_PNM),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-pnm
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-pnm
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_RAWPARSE),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-rawparse
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-rawparse
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_REMOVESILENCE),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-removesilence
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-removesilence
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_RTMP),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-rtmp
KYLIN_GST1_PLUGINS_BAD_DEPENDENCIES += rtmpdump
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-rtmp
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_SDI),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-sdi
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-sdi
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_SDP),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-sdp
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-sdp
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_SEGMENTCLIP),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-segmentclip
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-segmentclip
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_SIREN),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-siren
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-siren
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_SMOOTH),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-smooth
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-smooth
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_SPEED),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-speed
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-speed
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_SUBENC),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-subenc
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-subenc
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_STEREO),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-stereo
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-stereo
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_TTA),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-tta
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-tta
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_VIDEOFILTERS),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-videofilters
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-videofilters
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_VIDEOFRAME_AUDIOLEVEL),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-videoframe_audiolevel
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-videoframe_audiolevel
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_VIDEOMEASURE),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-videomeasure
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-videomeasure
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_VIDEOPARSERS),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-videoparsers
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-videoparsers
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_VIDEOSIGNAL),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-videosignal
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-videosignal
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_VMNC),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-vmnc
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-vmnc
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_Y4M),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-y4m
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-y4m
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_YADIF),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-yadif
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-yadif
endif

# Plugins with dependencies

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_APEXSINK),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-apexsink
KYLIN_GST1_PLUGINS_BAD_DEPENDENCIES += openssl
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-apexsink
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_ASSRENDER),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-assrender
KYLIN_GST1_PLUGINS_BAD_DEPENDENCIES += libass
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-assrender
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_BZ2),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-bz2
KYLIN_GST1_PLUGINS_BAD_DEPENDENCIES += bzip2
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-bz2
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_CURL),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-curl
KYLIN_GST1_PLUGINS_BAD_DEPENDENCIES += libcurl
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-curl
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_DASH),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-dash
KYLIN_GST1_PLUGINS_BAD_DEPENDENCIES += libxml2
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-dash
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_DECKLINK),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-decklink
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-decklink
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_DIRECTFB),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-directfb
KYLIN_GST1_PLUGINS_BAD_DEPENDENCIES += directfb
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-directfb
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_DVB),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-dvb
KYLIN_GST1_PLUGINS_BAD_DEPENDENCIES += dtv-scan-tables
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-dvb
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_FAAD),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-faad
KYLIN_GST1_PLUGINS_BAD_DEPENDENCIES += faad2
KYLIN_GST1_PLUGINS_BAD_HAS_GPL_LICENSE = y
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-faad
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_FBDEV),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-fbdev
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-fbdev
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_GL),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-gl
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-gl
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_HLS),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-hls

ifeq ($(BR2_PACKAGE_NETTLE),y)
KYLIN_GST1_PLUGINS_BAD_DEPENDENCIES += nettle
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --with-hls-crypto=nettle
else ifeq ($(BR2_PACKAGE_LIBGCRYPT),y)
KYLIN_GST1_PLUGINS_BAD_DEPENDENCIES += libgcrypt
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --with-hls-crypto=libgcrypt \
	--with-libgcrypt-prefix=$(STAGING_DIR)/usr
else
KYLIN_GST1_PLUGINS_BAD_DEPENDENCIES += openssl
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --with-hls-crypto=openssl
endif

else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-hls
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_LIBMMS),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-libmms
KYLIN_GST1_PLUGINS_BAD_DEPENDENCIES += libmms
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-libmms
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_MPEG2ENC),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-mpeg2enc
KYLIN_GST1_PLUGINS_BAD_DEPENDENCIES += libmpeg2
KYLIN_GST1_PLUGINS_BAD_HAS_GPL_LICENSE = y
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-mpeg2enc
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_MUSEPACK),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-musepack
KYLIN_GST1_PLUGINS_BAD_DEPENDENCIES += musepack
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-musepack
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_NEON),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-neon
KYLIN_GST1_PLUGINS_BAD_DEPENDENCIES += neon
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-neon
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_OPENAL),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-openal
KYLIN_GST1_PLUGINS_BAD_DEPENDENCIES += openal
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-openal
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_OPENCV),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-opencv
KYLIN_GST1_PLUGINS_BAD_DEPENDENCIES += opencv
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-opencv
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_OPENH264),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-openh264
KYLIN_GST1_PLUGINS_BAD_DEPENDENCIES += libopenh264
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-openh264
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_OPENJPEG),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-openjpeg
KYLIN_GST1_PLUGINS_BAD_DEPENDENCIES += openjpeg
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-openjpeg
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_OPUS),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-opus
KYLIN_GST1_PLUGINS_BAD_DEPENDENCIES += opus
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-opus
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_RSVG),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-rsvg
KYLIN_GST1_PLUGINS_BAD_DEPENDENCIES += librsvg
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-rsvg
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_SBC),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-sbc
KYLIN_GST1_PLUGINS_BAD_DEPENDENCIES += sbc
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-sbc
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_SDL),y)
KYLIN_GST1_PLUGINS_BAD_CONF_ENV += ac_cv_path_SDL_CONFIG=$(STAGING_DIR)/usr/bin/sdl-config
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-sdl
KYLIN_GST1_PLUGINS_BAD_DEPENDENCIES += sdl
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-sdl
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_SHM),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-shm
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-shm
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_SNDFILE),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-sndfile
KYLIN_GST1_PLUGINS_BAD_DEPENDENCIES += libsndfile
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-sndfile
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_VCD),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-vcd
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-vcd
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_VOAACENC),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-voaacenc
KYLIN_GST1_PLUGINS_BAD_DEPENDENCIES += vo-aacenc
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-voaacenc
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_WEBP),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-webp
KYLIN_GST1_PLUGINS_BAD_DEPENDENCIES += webp
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-webp
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD_PLUGIN_X265),y)
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --enable-x265
KYLIN_GST1_PLUGINS_BAD_DEPENDENCIES += x265
KYLIN_GST1_PLUGINS_BAD_HAS_GPL_LICENSE = y
else
KYLIN_GST1_PLUGINS_BAD_CONF_OPTS += --disable-x265
endif

# Add GPL license if GPL licensed plugins enabled.
ifeq ($(KYLIN_GST1_PLUGINS_BAD_HAS_GPL_LICENSE),y)
KYLIN_GST1_PLUGINS_BAD_LICENSE += GPL
endif

# Add Unknown license if Unknown licensed plugins enabled.
ifeq ($(KYLIN_GST1_PLUGINS_BAD_HAS_UNKNOWN_LICENSE),y)
KYLIN_GST1_PLUGINS_BAD_LICENSE += UNKNOWN
endif

# Use the following command to extract license info for plugins.
# # find . -name 'plugin-*.xml' | xargs grep license

$(eval $(autotools-package))
