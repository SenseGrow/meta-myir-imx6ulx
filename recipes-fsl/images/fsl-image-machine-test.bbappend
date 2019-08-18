IMAGE_FEATURES_remove = "${@oe.utils.conditional('DISTRO_FEATURES', 'wayland', 'x11-base', '', d)}"

CORE_IMAGE_EXTRA_INSTALL += "${@oe.utils.conditional('DISTRO_FEATURES', 'x11 wayland', \
                                              'weston-xwayland weston-init xterm', '', d)}"
