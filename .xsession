# Menu tools use this value to decide which applications
# are approriate for the current session.
if [ -z $XDG_CURRENT_DESKTOP ]; then
    export XDG_CURRENT_DESKTOP="GNOME-Flashback:GNOME"
fi

# map escape and flip mouse wheel
xmodmap ~/.xswapcapsesc

# disable trackpad
xinput | grep Touchpad | awk '{ print $6 }' | cut -d= -f 2 | xargs xinput --disable

# set bg
xsetroot -solid "#002244"

# Run gnome-session and tell it to use our i3 session.
exec gnome-session --session=gnome-plus-i3 --disable-acceleration-check
