#!/usr/bin/env python

__author__="flyingbear"
__date__ ="$Jun 6, 2010 6:54:13 PM$"

import os
import pynotify
import gtk


def get_current_song():
	if mpd_is_running() == 0:
		song = os.popen("mpc current").readline()
	else:
		song = ""
	return song
	
def get_volume():
	if mpd_is_running() == 0:
		volume = os.popen("mpc volume").readline()
	else:
		volune = ""
	return volume
	
def get_mpd_version():
	if mpd_is_running() == 0:
		version = os.popen("mpc version").readline()
	else:
		version = ""
	return version

def mpd_is_running():
	"""Check if mpd is running."""
	
	if "mpd" in os.popen("ps -A|grep mpd").readline():
		return 0
	else:
		return -1

if __name__ == "__main__":
	song = get_current_song()
	volume = get_volume()
	version = get_mpd_version()
	skype_greeting = "/me greets with " + song + " (music)"
	
	clipboard = gtk.clipboard_get()
	clipboard.set_text(skype_greeting)
	clipboard.store()
	
	pynotify.init("mpd")
	notification = pynotify.Notification("Now playing", "\n\"" + song.strip() + "\"\n " + volume.strip() + "\n" + version.strip(), "/usr/share/pixmaps/mpd_logo.png")
	notification.show()
