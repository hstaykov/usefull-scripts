#You must run this as super user 
#
#Here are some good web sites
#that can make you configure your
#fedora installation
#http://fedoraguide.info/
#http://www.mjmwired.net/resources/mjm-fedora-f11.html#yum
#http://dnmouse.org/
#http://www.fedorafaq.org/
#http://www.fedorasolved.org/
#http://fedoraforum.org/

result_file=result_file

function print_info {
	echo "----------------------------------------"
	echo "----------------------------------------" >> $result_file
	echo $1
	echo $1 >> $result_file
	echo "----------------------------------------"
	echo "----------------------------------------" >> $result_file
}

function check_for_errors {
	if [ $? -eq 0 ]
	then
		echo "Installation finished successfully!!"
		echo "Installation finished successfully!!" >> $result_file
	else
		echo "Installation FAILED!! Code = $?"
		echo "Installation FAILED!! Code = $?" >> $result_file
	fi
	echo "########################################"
	echo "########################################" >> $result_file
}

function add_sudoer {
	user=$USER
	if [ "$user" == root ] 
	then 
		echo "Enter user:"
        	read user
	fi
	print_info "Adding user $user to sudoers file... "
        su -c "echo '$user ALL=(ALL) ALL' >> /etc/sudoers"
	check_for_errors
}

function generate_google_repo {
	sudo echo "[google]
name=Google - x86_64
baseurl=http://dl.google.com/linux/rpm/stable/x86_64
enabled=1
gpgcheck=1
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub" > google.repo
}

#Add free and nonfree repositories
function add_free_and_nonfree_repos {
	print_info "Adding rpmfusion-free-release-stable... "
	sudo rpm -ivh http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-stable.noarch.rpm
	check_for_errors

	print_info "Adding rpmfusion-nonfree-release-stable... "
	sudo rpm -ivh http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-stable.noarch.rpm
	check_for_errors
}

#Generate and add google repository
function add_google_repo {
	print_info "Adding Google repository... "
	generate_google_repo
	sudo mv google.repo /etc/yum.repos.d/google.repo
	check_for_errors
}

#Add flash repository
function add_flash_repo {
	print_info "Adding Flash player repository... "
	sudo rpm -ivh http://linuxdownload.adobe.com/adobe-release/adobe-release-i386-1.0-1.noarch.rpm
	sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux
	check_for_errors
}

#Install skype chat messanger
function install_skype {
	print_info "Installing skype... "
	sudo yum -y --skip-broken install qt4-x11 libsane* libesd* libXv libQtGui.so.4 libQtDBus.so.4 libXss.so.1 libXv.so.1 lsb
	sudo rpm -ivh http://download.skype.com/linux/skype-2.2.0.35-fedora.i586.rpm
	check_for_errors
}

function install_java {
    print_info "Installing Java... "
    sudo rpm -ivh http://download.oracle.com/otn-pub/java/jdk/7u1-b08/jdk-7u1-linux-x64.rpm
    check_for_errors
}

function install_groovy {
    print_info "Installing Groovy... "
    wget http://dist.groovy.codehaus.org/distributions/groovy-binary-1.8.4.zip -O groovy.zip
    unzip ./groovy.zip 
    check_for_errors
}

function install_flash_to_chrome {
	sudo mkdir /opt/google/chrome/plugins
	sudo cp /usr/lib64/mozilla/plugins-wrapped/nswrapper_32_64.libflashplayer.so  /opt/google/chrome/plugins
}

function install_media_utilities {
	add_flash_repo
	print_info "Installing media utilities... "
	sudo yum -y --skip-broken install nspluginwrapper.{i686,x86_64} 
	#alsa-plugins-pulseaudio.i686
	sudo yum -y --skip-broken install vlc* flash-plugin libflashsupport easytag pavucontrol ncmpcpp mpd mpc mpdscribble sonata paprefs pulseaudio-equalizer
	check_for_errors
}

function install_development_utilities {
	print_info "Installing C/C++ development... "
	sudo yum -y --skip-broken install gcc gcc-c++ gdb make
	check_for_errors

	print_info "Installing Python development... "
	sudo yum -y --skip-broken install python
	check_for_errors
}

function install_communication_utilities {
	install_skype
	check_for_errors
}

function install_download_utilities {
	print_info "Install download utilities... "
	sudo yum -y --skip-broken install linuxdcpp wget rtorrent curl xchat
	check_for_errors
}

function install_browsing_utilities {
	print_info "Install browsing utilities... "
	sudo yum -y --skip-broken install links 
	install_flash_to_chrome
	check_for_errors
}

function install_games {
	print_info "Install games... "
	sudo yum -y --skip-broken install supertux openarena extremetuxracer pingus warzone*
	check_for_errors
}

function install_educational_utilities {
	print_info "Install educational utilities... "
	sudo yum -y --skip-broken install gimp* octave qtoctave
	check_for_errors
}

function install_desktop_extras {
	print_info "Install additional themes... "
	sudo yum -y --skip-broken install gnome-themes-extras gnome-shell-extension* gnome-shell-theme*
    sudo yum -y --skip-broken install https://dl.dropbox.com/u/49862637/Mate-desktop/fedora_17/mate-desktop-fedora-updates/noarch/mate-desktop-release-17-2.fc17.noarch.rpm
    sudo yum -y --skip-broken groupinstall MATE-Desktop
    sudo yum -y --skip-broken install –enablerepo=mate-desktop-fedora-new-application-testing compiz compiz-mate fusion-icon-gtk compiz-plugins-main compiz-plugins-extra compiz-plugins-extra-mate compiz-plugins-main-mate compiz-plugins-unsupported compiz-plugins-unsupported-mate mate-utils
	check_for_errors
}

function install_office_tools {
	print_info "Install office... "
	sudo yum -y --skip-broken groupinstall "Office/Productivity"
	check_for_errors

	print_info "Install fonts... "
	sudo yum -y --skip-broken install freetype-freeworld
	check_for_errors

	print_info "Install other office tools... "
	sudo yum -y --skip-broken install gnochm
	check_for_errors

	print_info "Install documentation... "
        sudo yum -y --skip-broken groupinstall "Books and Guides"
        check_for_errors
}

function install_mpd_now_playing {
	print_info "Installing mpd now playing... "
	sudo cp mpd-nowplaying/mpd-nowplaying.py /usr/bin/now-playing
	sudo chmod 755 /usr/bin/now-playing
	sudo cp mpd-nowplaying/mpd_logo.png /usr/share/pixmaps/mpd_logo.png
	sudo chmod 644 /usr/share/pixmaps/mpd_logo.png
	check_for_errors
}

function install_system_tools {
	print_info "Installing system tools... "
	sudo yum -y --skip-broken install unrar wine system-config-* vim nmap yum-plugin-fastestmirror policycoreutils-gui ntfs-3g ntfs-config procinfo gconf-editor bash-completion telnet lm_sensors hddtemp acpi* htop alacarte p7zip p7zip-plugins gftp gnome-tweak-tool rpm-build unetbootin firewalld firewall-plugin powertop bchunk xinput dconf-editor gnome-device-manager conky ftp filezilla
    sudo  yum install @development-tools
	check_for_errors
}

function configure_user_and_groups {
	print_info "Configure users and groups... "
	sudo usermod -a -G pulse-access mpd
	sudo usermod -a -G pulse-access flyingbear
	check_for_errors
}

function update {
	print_info "Update installed packages... "
	sudo yum -y --skip-broken update
	check_for_errors
}

function configure_hosts_deny {
	print_info "Configure host.deny... "
	sudo echo "ALL:ALL" >> /etc/hosts.deny
	check_for_errors
}

#Main
add_sudoer
update
add_free_and_nonfree_repos
add_google_repo
install_media_utilities
install_development_utilities
install_communication_utilities
install_download_utilities
install_browsing_utilities
install_games
install_educational_utilities
install_desktop_extras
install_system_tools
install_office_tools
install_mpd_now_playing
configure_user_and_groups
configure_hosts
configure_hosts_allow
configure_hosts_deny
