#!/bin/bash

set -e

cd ${DOTFILES_ROOT}

source ${DOTFILES_ROOT}/environment
source ${DOTFILES_ROOT}/lib/run

e_header "Setting preferences for MacOS system"
e_warning "==> this may require sudo rights for some parts"

## System

# Set computer name
e_info "==> set computer name to $(tput bold)mekboek$(tput sgr0)"
if [[ $(scutil --get ComputerName) != "mekboek" ]]; then sudo scutil --set ComputerName "mekboek"; fi
if [[ $(scutil --get LocalHostName) != "mekboek" ]]; then sudo scutil --set LocalHostName "mekboek"; fi



## Keyboard
e_info "==> keyboard settings"

# Set a blazingly fast repeat rate
defaults write -g KeyRepeat -int 2

# Set a shorter delay until key repeat
defaults write -g InitialKeyRepeat -int 15

# Disable press-and-hold for keys in favor of key repeat
defaults write -g ApplePressAndHoldEnabled -bool false



## Text, locale & i18n
e_info "==> locale/i18n settings"

# Set language and text formats
defaults write -g AppleLanguages -array "en-NL" "nl-NL"
defaults write -g AppleLocale -string "en_NL"

# Units
defaults write -g AppleMeasurementUnits -string "Centimeters"
defaults write -g AppleMetricUnits -bool true

# Disable auto-correct
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false

# Disable smart quotes as they're annoying when typing code
defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable smart dashes as they're annoying when typing code
defaults write -g NSAutomaticDashSubstitutionEnabled -bool false



## Mouse
e_info "==> mouse settings"

# Disable smart zoom (double-tap with one finger)
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseOneFingerDoubleTapGesture -int 0

# Enable secondary click (click on right side)
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode -string "TwoButton"

# Double-tap with two fingers for Mission Control
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseTwoFingerDoubleTapGesture -int 3

# Swipe between full-screen apps with two fingers
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseTwoFingerHorizSwipeGesture -int 2



## Trackpad
e_info "==> trackpad settings"

# Enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

# Enable secondary click with two fingers
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true

# Drag with three fingers
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true



## Menu bar
e_info "==> menu bar settings"

defaults write com.apple.menuextra.clock DateFormat -string "EEE d MMM  HH:mm"
defaults write com.apple.menuextra.clock IsAnalog -bool false
defaults write com.apple.menuextra.clock FlashDateSeparators -bool true

# Hide text input menu
menus=$(echo $(defaults read com.apple.systemuiserver menuExtras | sed 's/"\/System\/Library\/CoreServices\/Menu\ Extras\/TextInput\.menu"\,*//'))
defaults write com.apple.systemuiserver menuExtras "$menus"



## Dock
e_info "==> dock settings"

# Use the suck effect for window minimizing
defaults write com.apple.dock mineffect suck

# Don't minimize windows into application icon
defaults write com.apple.dock minimize-to-application -bool false

# Make icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Don’t animate opening applications
defaults write com.apple.dock launchanim -bool false

# Make tiles 45px
defaults write com.apple.dock tilesize -int 45

# Don't magnify tiles
defaults write com.apple.dock magnification -boolean false

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0



## Mission Control & Hot Corners
e_info "==> mission control/hot corner settings"

# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center

# Top left → Mission Control
defaults write com.apple.dock wvous-tl-corner -int 2
defaults write com.apple.dock wvous-tl-modifier -int 0

# Top right → Show desktop
defaults write com.apple.dock wvous-tr-corner -int 4
defaults write com.apple.dock wvous-tr-modifier -int 0

# Bottom left → Show application windows
defaults write com.apple.dock wvous-bl-corner -int 3
defaults write com.apple.dock wvous-bl-modifier -int 0

# Bottom right → Start screen saver
defaults write com.apple.dock wvous-br-corner -int 5
defaults write com.apple.dock wvous-br-modifier -int 0


# Speed up animations
defaults write com.apple.dock expose-animation-duration -float 0.1

# Group windows by application
defaults write com.apple.dock expose-group-apps -bool true



## Finder
e_info "==> Finder settings"

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Show all filename extensions
defaults write -g AppleShowAllExtensions -bool true

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Disable window and Get Info animations
# defaults write com.apple.finder DisableAllAnimations -bool true

# Allow quitting via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool true

# Display full POSIX path as window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
#defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Use current folder for search scope
#defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Adjust icon view settings for desktop, and other views
#for setting in 'DesktopViewSettings' 'FK_StandardViewSettings' 'StandardViewSettings'; do
#  # Enable snap-to-grid for icons and in other icon views
#  /usr/libexec/PlistBuddy -c "Set :$setting:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
#  # Show item info near icons and in other icon views
#  /usr/libexec/PlistBuddy -c "Set :$setting:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
#  # Increase grid spacing for icons on the desktop and in other icon views
#  /usr/libexec/PlistBuddy -c "Set :$setting:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
#  # Increase the size of icons on the desktop and in other icon views
#  /usr/libexec/PlistBuddy -c "Set :$setting:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
#done

# Show item info to the right of the icons
#/usr/libexec/PlistBuddy -c "Set DesktopViewSettings:IconViewSettings:labelOnBottom false" ~/Library/Preferences/com.apple.finder.plist



## Panels
e_info "==> panels settings"

# Expand save panel by default
defaults write -g NSNavPanelExpandedStateForSaveMode -bool true

# Disable the “Are you sure you want to open this application?” dialog
#defaults write com.apple.LaunchServices LSQuarantine -bool false

# Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)
defaults write -g AppleKeyboardUIMode -int 2



## Safari
e_info "==> Safari settings"

# Enable debug menu
#defaults write com.apple.Safari IncludeDevelopMenu -bool true

# Show status bar
#defaults write com.apple.Safari ShowOverlayStatusBar -bool true

# Disable automatic spelling correction
#defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false

# Send "Do-Not-Track" header
#defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

# User stylesheet
#defaults write com.apple.Safari UserStyleSheetEnabled -bool true
#defaults write com.apple.Safari UserStyleSheetLocationURLString "${DOTFILES_ROOT}/macos/res/safari.css"



## Terminal
e_info "==> terminal settings"

# Use our own profile
TERM_PROFILE='appsignal-dark';
CURRENT_PROFILE="$(defaults read com.apple.Terminal 'Default Window Settings')";
if [ "${CURRENT_PROFILE}" != "${TERM_PROFILE}" ]; then
  open "${DOTFILES_ROOT}/macos/terminal/${TERM_PROFILE}.terminal";
  sleep 1; # Wait a bit to make sure the theme is loaded
  defaults write com.apple.Terminal 'Default Window Settings' -string "${TERM_PROFILE}";
  defaults write com.apple.Terminal 'Startup Window Settings' -string "${TERM_PROFILE}";
fi;

# New tabs reflect default settings rather than current
defaults write com.apple.Terminal NewTabSettingsBehavior -bool true
defaults write com.apple.Terminal NewTabWorkingDirectoryBehavior -bool true



## TextEdit
e_info "==> textedit settings"

# Use plain text mode for new documents
#defaults write com.apple.TextEdit RichText -int 0

# Open and save files as UTF-8
#defaults write com.apple.TextEdit PlainTextEncoding -int 4
#defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4
