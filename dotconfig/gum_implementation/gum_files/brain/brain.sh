#!/bin/bash
# check if gum is installed
if ! which "gum" &> /dev/null
then
    echo "gum is not installed "
    read -rp "Would you like to install it ? [y/n] " chose1
    if [[ $chose1 == "y" || $chose1 == "Y" ]]
    then
        echo "Installing ... "
        foot -e sudo pacman -S gum
    else
        echo "Without gum this script will not run "
        gum spin --spinner meter --title "Exiting..." -- sleep 3
        exit 1
    fi
fi
############ Main code ###################
# a loop to prevent mishappening of anything
clear
while true
do
cat <<"EOF"
  ____       _   _                  _                 _
 / ___|     | | | |_   _ _ __  _ __| | __ _ _ __   __| |
| |  _ _____| |_| | | | | '_ \| '__| |/ _` | '_ \ / _` |
| |_| |_____|  _  | |_| | |_) | |  | | (_| | | | | (_| |
 \____|     |_| |_|\__, | .__/|_|  |_|\__,_|_| |_|\__,_|
                   |___/|_|
EOF
echo "Press :'Enter' to confirm"
echo
opt1=$(gum choose --height=17 "monitor" "waybar " "blur" "corners" "layouts" "animations" "shadows" "borders" "window gaps" "backgrounds" "eye protection" "manual settings" "default apps" "exit")
clear
if [[ $opt1 == "exit" ]]
then
    break
elif [[ $opt1 == "monitor" ]]
then
    clear
    cat <<"EOL"
 __  __             _ _
|  \/  | ___  _ __ (_) |_ ___  _ __
| |\/| |/ _ \| '_ \| | __/ _ \| '__|
| |  | | (_) | | | | | || (_) | |
|_|  |_|\___/|_| |_|_|\__\___/|_|

EOL
    echo "Press :'Enter' to confirm , 'Esc' to return back"
    echo
    opt2=$(gum file --height=6 ~/.config/hypr/brain/config/monitor/)
    cp "$opt2" "$HOME/.config/hypr/settings/monitor.conf"
elif [[ $opt1 == "waybar " ]]
then
    clear
    cat <<"EOL"
__        __          _
\ \      / /_ _ _   _| |__   __ _ _ __
 \ \ /\ / / _` | | | | '_ \ / _` | '__|
  \ V  V / (_| | |_| | |_) | (_| | |
   \_/\_/ \__,_|\__, |_.__/ \__,_|_|
                |___/
EOL
    echo "Press :'Enter' to confirm , 'Esc' to return back"
    echo
    choice1=$(gum choose --height=4 "Theme" "Blur")
    clear
    if [[ "$choice1" == "Theme" ]]
    then
        cat <<"EOF"
 _____ _
|_   _| |__   ___ _ __ ___   ___
  | | | '_ \ / _ \ '_ ` _ \ / _ \
  | | | | | |  __/ | | | | |  __/
  |_| |_| |_|\___|_| |_| |_|\___|

EOF
        echo "Press :'Enter' to confirm , 'Esc' to return back"
        echo
        lis1=$(ls "$HOME/.config/hypr/brain/config/waybar_themes/")
        opt2=$(gum choose --height=10 $lis1)
        if [[ "$opt2" ]]
        then
            echo "$opt2 applying "
            cp -r "$HOME/.config/hypr/brain/config/waybar_themes/$opt2/"* "$HOME/.config/waybar/"
            if [[ "$opt2" == "default"  ]]
            then
                sed -i "s/USER/$USER/" .config/waybar/style.css
            fi
            clear
        cat <<"EOF"
 ____           _ _   _
|  _ \ ___  ___(_) |_(_) ___  _ __
| |_) / _ \/ __| | __| |/ _ \| '_ \
|  __/ (_) \__ \ | |_| | (_) | | | |
|_|   \___/|___/_|\__|_|\___/|_| |_|
EOF
            echo "Press :'Enter' to confirm , 'Esc' to return back"
            echo
            echo "Choose the position of waybar"
            opt3=$(gum choose --height=20 "top" "bottom")
            if [[ $opt3 == "bottom" ]]
            then
                sed -i '/"position"/ s/top/bottom/' .config/waybar/config
                # there is no need to define else, as it is preset to top
            fi
            gum spin --spinner meter --title "Press Mod+w to reload the new theme " -- sleep 5
        fi
        elif [[ "$choice1" == "Blur" ]]
        then
        cat <<"EOF"
 ____  _
| __ )| |_   _ _ __
|  _ \| | | | | '__|
| |_) | | |_| | |
|____/|_|\__,_|_|
EOF
        echo "Press :'Enter' to confirm , 'Esc' to return back"
        echo
        opt2=$(gum file --height=3 "$HOME/.config/hypr/brain/config/status_bar/")
        cp  "$opt2" "$HOME/.config/hypr/settings/status_bar.conf"
    fi
    elif [[ $opt1 == "blur" ]]
    then
        clear
        cat <<"EOF"
 _     _
| |__ | |_   _ _ __
| '_ \| | | | | '__|
| |_) | | |_| | |
|_.__/|_|\__,_|_|

EOF
        echo "Press :'Enter' to confirm , 'Esc' to return back"
        echo
        opt2=$(gum file --height=20 "$HOME/.config/hypr/brain/config/blur_system/")
        cp "$opt2" "$HOME/.config/hypr/settings/blur_system.conf"
    elif [[ $opt1 == "eye protection" ]]
    then
        clear
        cat <<"EOF"
                                   _            _   _
  ___ _   _  ___   _ __  _ __ ___ | |_ ___  ___| |_(_) ___  _ __
 / _ \ | | |/ _ \ | '_ \| '__/ _ \| __/ _ \/ __| __| |/ _ \| '_ \
|  __/ |_| |  __/ | |_) | | | (_) | ||  __/ (__| |_| | (_) | | | |
 \___|\__, |\___| | .__/|_|  \___/ \__\___|\___|\__|_|\___/|_| |_|
      |___/       |_|
EOF
        echo "Press :'Enter' to confirm , 'Esc' to return back"
        echo
        opt2=$(gum file --height=5 ~/.config/hypr/brain/config/eye_protection/)
        if [[ "$opt2" ]]
        then
            cp "$opt2" "$HOME/.config/hypr/settings/eye_protection.conf"
            echo
            gum spin --spinner meter --title "The new setting will be applied after restart" -- sleep 2
        fi
    elif [[ $opt1 == "corners" ]]
    then
        clear
        cat <<"EOF"

  ___ ___  _ __ _ __   ___ _ __ ___
 / __/ _ \| '__| '_ \ / _ \ '__/ __|
| (_| (_) | |  | | | |  __/ |  \__ \
 \___\___/|_|  |_| |_|\___|_|  |___/

EOF
        echo "Press :'Enter' to confirm , 'Esc' to return back"
        echo
        opt2=$(gum file --height=3 ~/.config/hypr/brain/config/corners/)
        if [[ "$opt2" ]]
        then
            cp "$opt2" "$HOME/.config/hypr/settings/corners.conf"
        fi
    elif [[ $opt1 == "window gaps" ]]
    then
        clear
        cat <<"EOF"
          _           _
__      _(_)_ __   __| | _____      __   __ _  __ _ _ __  ___
\ \ /\ / / | '_ \ / _` |/ _ \ \ /\ / /  / _` |/ _` | '_ \/ __|
 \ V  V /| | | | | (_| | (_) \ V  V /  | (_| | (_| | |_) \__ \
  \_/\_/ |_|_| |_|\__,_|\___/ \_/\_/    \__, |\__,_| .__/|___/
                                        |___/      |_|
EOF
        echo "Press :'Enter' to confirm , 'Esc' to return back"
        echo
        opt2=$(gum file --height=7 ~/.config/hypr/brain/config/window_gaps/)
        if [[ "$opt2" ]]
        then
            cp "$opt2" "$HOME/.config/hypr/settings/window_gaps.conf"
        fi
    elif [[ $opt1 == "backgrounds" ]]
    then
        clear
        cat <<"EOF"
 ____             _                                   _
| __ )  __ _  ___| | ____ _ _ __ ___  _   _ _ __   __| |___
|  _ \ / _` |/ __| |/ / _` | '__/ _ \| | | | '_ \ / _` / __|
| |_) | (_| | (__|   < (_| | | | (_) | |_| | | | | (_| \__ \
|____/ \__,_|\___|_|\_\__, |_|  \___/ \__,_|_| |_|\__,_|___/
                      |___/
EOF
        echo "Press :'Enter' to confirm , 'Esc' to return back"
        echo
        opt2=$(gum choose --height=5 "wallpaper path" "add wallpaper" "wallpaper type")
        if [[ $opt2 == "wallpaper path" ]]
        then
            clear
            cat <<"EOF"
               _ _                   _   _
__      ____ _| | |      _ __   __ _| |_| |__
\ \ /\ / / _` | | |_____| '_ \ / _` | __| '_ \
 \ V  V / (_| | | |_____| |_) | (_| | |_| | | |
  \_/\_/ \__,_|_|_|     | .__/ \__,_|\__|_| |_|
                        |_|
EOF

            echo "Press :'Enter' to confirm , 'Esc' to return back"
            echo
            opt3=$(gum choose --height=4 "custom wallpaper" "garuda wallpaper")
            if [[ $opt3 == "garuda wallpaper" ]]
            then
                echo "Do you want to use garuda wallpapers instead of custom ? "
                gum confirm && opt4="y" || opt4="n"
                if [[ $opt4 == "y" ]]
                then
                    cp "$HOME/.config/hypr/brain/config/background/scripts/slideshow_garuda.conf" "$HOME/.config/wpaperd/config.toml"
                    cp "$HOME/.config/hypr/brain/config/background/slideshow.conf" "$HOME/.config/hypr/settings/background.conf"
                    read -rp "Enter time interval in minutes : " opt5
                    echo "duration = '$opt5 m'" >> "$HOME/.config/wpaperd/config.toml"
                    echo "Wallpaper path changed to garuda with interval $opt5 min"
                    gum spin --spinner meter --title "Press Mod+Shift+c to see the changes" -- sleep 3
                    echo "garuda" > "$HOME/.config/hypr/brain/scripts/wall_condition.txt"
                else
                    gum spin --spinner meter --title "No changes applied" -- sleep 3
                fi
            elif [[ $opt3 == "custom wallpaper" ]]
            then
                echo "Do you want to use custom wallpapers instead of garuda "
                gum confirm && opt4="y" || opt4="n"
                if [[ $opt4 == "y" ]]
                then
                    if [[ ! -d "$HOME/custom_wallpapers/" ]]
                    then
                        mkdir "$HOME/custom_wallpapers/"
                        mkdir "$HOME/custom_wallpapers/photos"
                        mkdir "$HOME/custom_wallpapers/animated"
                        cp "/usr/share/wallpapers/garuda-wallpapers/"* "$HOME/custom_wallpapers/photos"
                    fi
                    if [[ ! -d "$HOME/custom_wallpapers/photos" ]]
                    then
                        mkdir "$HOME/custom_wallpapers/photos"
                        cp "/usr/share/wallpapers/garuda-wallpapers/"* "$HOME/custom_wallpapers/photos"
                    fi
                    cp "$HOME/.config/hypr/brain/config/background/scripts/slideshow_custom.conf" "$HOME/.config/wpaperd/config.toml"
                    cp "$HOME/.config/hypr/brain/config/background/slideshow.conf" "$HOME/.config/hypr/settings/background.conf"
                    read -rp "Enter time interval in minutes : " opt5
                    echo "duration = '$opt5 m'" >> "$HOME/.config/wpaperd/config.toml"
                    echo "Wallpaper path changed to custom with interval $opt5 min"
                    echo "Now you can put all your wallpapers in $HOME/custom_wallpapers/photos"
                    gum spin --spinner meter --title "Press Mod+Shift+c to see the changes" -- sleep 5
                    echo "custom" > "$HOME/.config/hypr/brain/scripts/wall_condition.txt"
                else
                    gum spin --spinner meter --title "No changes applied" -- sleep 3
                fi
            fi
        elif [[ $opt2 == "add wallpaper" ]]
        then
            clear
            cat <<"EOF"
    _       _     _                    _ _
   / \   __| | __| |    __      ____ _| | |
  / _ \ / _` |/ _` |____\ \ /\ / / _` | | |
 / ___ \ (_| | (_| |_____\ V  V / (_| | | |
/_/   \_\__,_|\__,_|      \_/\_/ \__,_|_|_|

EOF
            echo "Press :'Enter' to confirm , 'Esc' to return back"
            echo
            cond1=$(cat "$HOME/.config/hypr/brain/scripts/wall_condition.txt")
            if [[ $cond1 == "garuda" ]]
            then
                gum spin --spinner meter --title "Your current path is set to garuda" -- sleep 3
                gum spin --spinner meter --title "please change it to custom from 'background path' options" -- sleep 4
            fi
            opt4=$(gum choose --height=4 "add photos" "add animated")
            if [[ ! -d "$HOME/custom_wallpapers/" ]]
            then
                mkdir "$HOME/custom_wallpapers/"
                mkdir "$HOME/custom_wallpapers/photos"
                mkdir "$HOME/custom_wallpapers/animated"
            fi
            if [[ ! -d "$HOME/custom_wallpapers/photos" ]]
            then
                mkdir "$HOME/custom_wallpapers/photos"
            fi
            if [[ ! -d "$HOME/custom_wallpapers/animated" ]]
            then
                mkdir "$HOME/custom_wallpapers/animated"
            fi
            if [[ $opt4 == "add photos" ]]
            then
                echo "Navigate to the photo : "
                opt5=$(gum file --height=20 "$HOME")
                cp "$opt5" "$HOME/custom_wallpapers/photos/"
            elif [[ $opt4 == "add animated" ]]
            then
                echo "Navigate to the video/gif : "
                opt5=$(gum file --height=20 "$HOME")
                var1=$(basename "$opt5")
                var2=$(echo "$var1" | cut -d'.' -f2 )
                var3=$(echo "$var1" | cut -d'.' -f1 )
                if [[ ! "$var2" == "gif" ]]
                then
                    gum spin --spinner meter --title "This file is not in gif, converint now..." -- sleep 2
                    foot -e ffmpeg -i "$opt5" -f gif "$HOME/custom_wallpapers/animated/$var3".gif &> /dev/null
                    gum spin --spinner meter --title "Saved to the target" -- sleep 2
                else
                    cp "opt5" "$HOME/custom_wallpapers/animated/"
                fi
            fi
        elif [[ $opt2 == "wallpaper type" ]]
        then
            clear
            cat <<"EOF"
               _ _       _
__      ____ _| | |     | |_ _   _ _ __   ___
\ \ /\ / / _` | | |_____| __| | | | '_ \ / _ \
 \ V  V / (_| | | |_____| |_| |_| | |_) |  __/
  \_/\_/ \__,_|_|_|      \__|\__, | .__/ \___|
                             |___/|_|
EOF
            echo "Press :'Enter' to confirm , 'Esc' to return back"
            echo
            cond1=$(cat "$HOME/.config/hypr/brain/scripts/wall_condition.txt")
            if [[ $cond1 == "garuda" ]]
            then
                gum spin --spinner meter --title "Your current path is set to garuda" -- sleep 3
                gum spin --spinner meter --title "please change it to custom from 'background path' options" -- sleep 4
            fi
            opt3=$(gum choose --height=5 "session static" "slideshow" "animated" )
            if [[ "$opt3" == "slideshow" ]]
            then
            cond1=$(cat "$HOME/.config/hypr/brain/scripts/wall_condition.txt")
                if [[ $cond1 == "garuda" ]]
                then
                    cp "$HOME/.config/hypr/brain/config/background/scripts/slideshow_garuda.conf" "$HOME/.config/wpaperd/config.toml"
                    cp "$HOME/.config/hypr/brain/config/background/slideshow.conf" "$HOME/.config/hypr/settings/background.conf"
                    read -rp "Enter time interval in minutes : " opt5
                    echo "duration = '$opt5 m'" >> "$HOME/.config/wpaperd/config.toml"
                    gum spin --spinner meter --title "Please restart your system" -- sleep 2
                    gum spin --spinner meter --title "Press Mod+Shift+c to change wallpapers" -- sleep 3
                elif [[ $cond1 == "custom" ]]
                then
                    cp "$HOME/.config/hypr/brain/config/background/scripts/slideshow_custom.conf" "$HOME/.config/wpaperd/config.toml"
                    cp "$HOME/.config/hypr/brain/config/background/slideshow.conf" "$HOME/.config/hypr/settings/background.conf"
                    read -rp "Enter time interval in minutes : " opt5
                    echo "duration = '$opt5 m'" >> "$HOME/.config/wpaperd/config.toml"
                    gum spin --spinner meter --title "Please restart your system" -- sleep 2
                    gum spin --spinner meter --title "Press Mod+Shift+c to change wallpapers" -- sleep 3
                fi
            elif [[ "$opt3" == "session static" ]]
            then
            cond1=$(cat "$HOME/.config/hypr/brain/scripts/wall_condition.txt")
                if [[ $cond1 == "garuda" ]]
                then
                    cp "$HOME/.config/hypr/brain/config/background/static_garuda.conf" "$HOME/.config/hypr/settings/background.conf"
                    gum spin --spinner meter --title "Press Mod+Shift+c to see the changes" -- sleep 3
                elif [[ $cond1 == "custom" ]]
                then
                    cp "$HOME/.config/hypr/brain/config/background/static_custom.conf" "$HOME/.config/hypr/settings/background.conf"
                    gum spin --spinner meter --title "Please restart your system" -- sleep 2
                    gum spin --spinner meter --title "Press Mod+Shift+c to change wallpapers" -- sleep 3
                fi
            elif [[ "$opt3" == "animated" ]]
            then
                var1=$(ls "$HOME/custom_wallpapers/animated/" | wc -l ) &> /dev/null
                if [[ -d "$HOME/custom_wallpapers/animated/" &&  "$var1" -ne 0 ]]
                then
                    cp "$HOME/.config/hypr/brain/config/background/animated.conf" "$HOME/.config/hypr/settings/background.conf"
                    gum spin --spinner meter --title "Please restart your system" -- sleep 2
                    gum spin --spinner meter --title "Press Mod+Shift+c to change wallpapers" -- sleep 3
                else
                    gum spin --spinner meter --title "please add an animated stuff through 'add wallpaper' option" -- sleep 5
                fi
            fi
        fi
    elif [[ $opt1 == "manual settings" ]]
    then
        clear
        cat <<"EOF"
 __  __                            _   _   _
|  \/  | __ _ _ __        ___  ___| |_| |_(_)_ __   __ _ ___
| |\/| |/ _` | '_ \ _____/ __|/ _ \ __| __| | '_ \ / _` / __|
| |  | | (_| | | | |_____\__ \  __/ |_| |_| | | | | (_| \__ \
|_|  |_|\__,_|_| |_|     |___/\___|\__|\__|_|_| |_|\__, |___/
                                                   |___/
EOF
        echo "Press :'Enter' to confirm , 'Esc' to return back"
        echo
        echo "Choose your favourite text editor to opten with "
        opt3=$(gum choose --height=10 "nvim" "vim" "micro" "emacs" "nano" "none" )
        if [[ "$opt3" != "none" ]]
        then
            gum spin --spinner meter --title "Opening in $opt3 " -- sleep 2
            foot -e "$opt3" "$HOME/.config/hypr/settings/manual_settings.conf" &> /dev/null
        else
            gum spin --spinner meter --title "Opening with default text editor" -- sleep 2
            xdg-open "$HOME/.config/hypr/settings/manual_settings.conf" &> /dev/null
        fi
        gum spin --spinner meter --title "File path : ~/.config/hypr/settings/manual_settings.conf" -- sleep 3
    elif [[ $opt1 == "default apps" ]]
    then
        clear
        cat <<"EOF"
 __  __                            _   _   _
|  \/  | __ _ _ __        ___  ___| |_| |_(_)_ __   __ _ ___
| |\/| |/ _` | '_ \ _____/ __|/ _ \ __| __| | '_ \ / _` / __|
| |  | | (_| | | | |_____\__ \  __/ |_| |_| | | | | (_| \__ \
|_|  |_|\__,_|_| |_|     |___/\___|\__|\__|_|_| |_|\__, |___/
                                                   |___/
EOF
        echo "Press :'Enter' to confirm , 'Esc' to return back"
        echo
        echo "Choose your favourite text editor to opten with "
        opt3=$(gum choose --height=10 "nvim" "vim" "micro" "emacs" "nano" "none" )
        if [[ "$opt3" != "none" ]]
        then
            gum spin --spinner meter --title "Opening in $opt3 " -- sleep 2
            foot -e "$opt3" "$HOME/.config/hypr/hyprstart" &> /dev/null
        else
            read -rp "Enter the name of your text editor : " opt4
            gum spin --spinner meter --title "Opening with $opt4 text editor" -- sleep 2
            $opt4 "$HOME/.config/hypr/hyprstart" # &> /dev/null
        fi
        gum spin --spinner meter --title "File path : ~/.config/hypr/hyprstart" -- sleep 3
    elif [[ $opt1 == "animations" ]]
    then
        clear
        cat <<"EOF"
    _          _                 _   _
   / \   _ __ (_)_ __ ___   __ _| |_(_) ___  _ __  ___
  / _ \ | '_ \| | '_ ` _ \ / _` | __| |/ _ \| '_ \/ __|
 / ___ \| | | | | | | | | | (_| | |_| | (_) | | | \__ \
/_/   \_\_| |_|_|_| |_| |_|\__,_|\__|_|\___/|_| |_|___/
EOF
        echo "Press :'Enter' to confirm , 'Esc' to return back"
        echo
        opt2=$(gum file --height=4 ~/.config/hypr/brain/config/animations/)
        if [[ "$opt2" ]]
        then
            cp "$opt2" "$HOME/.config/hypr/settings/animations.conf"
        fi
    elif [[ $opt1 == "shadows" ]]
    then
        clear
        cat <<"EOF"
 ____  _               _
/ ___|| |__   __ _  __| | _____      _____
\___ \| '_ \ / _` |/ _` |/ _ \ \ /\ / / __|
 ___) | | | | (_| | (_| | (_) \ V  V /\__ \
|____/|_| |_|\__,_|\__,_|\___/ \_/\_/ |___/
EOF
        echo "Press :'Enter' to confirm , 'Esc' to return back"
        echo
        opt2=$(gum choose --height=5 "shadow color" "shadow range")
        if [[ $opt2 == "shadow color" ]]
        then
            clear
            cat <<"EOF"
     _               _                           _
 ___| |__   __ _  __| | _____      __   ___ ___ | | ___  _ __
/ __| '_ \ / _` |/ _` |/ _ \ \ /\ / /  / __/ _ \| |/ _ \| '__|
\__ \ | | | (_| | (_| | (_) \ V  V /  | (_| (_) | | (_) | |
|___/_| |_|\__,_|\__,_|\___/ \_/\_/    \___\___/|_|\___/|_|
EOF

            echo "Press :'Enter' to confirm , 'Esc' to return back"
            echo
            opt2=$(gum file --height=6 ~/.config/hypr/brain/config/shadow/color/)
            cp "$opt2" "$HOME/.config/hypr/settings/shadow_color.conf"
        elif [[ $opt2 == "shadow range" ]]
        then
            clear
            cat <<"EOF"
     _               _
 ___| |__   __ _  __| | _____      __  _ __ __ _ _ __   __ _  ___
/ __| '_ \ / _` |/ _` |/ _ \ \ /\ / / | '__/ _` | '_ \ / _` |/ _ \
\__ \ | | | (_| | (_| | (_) \ V  V /  | | | (_| | | | | (_| |  __/
|___/_| |_|\__,_|\__,_|\___/ \_/\_/   |_|  \__,_|_| |_|\__, |\___|
                                                       |___/
EOF

            echo "Press :'Enter' to confirm , 'Esc' to return back"
            echo
            opt2=$(gum file --height=6 ~/.config/hypr/brain/config/shadow/range/)
            cp "$opt2" "$HOME/.config/hypr/settings/shadow_range.conf"

            # shadow color code to be written here
        fi
    elif [[ $opt1 == "borders" ]]
    then
        clear
        cat <<"EOF"
 ____                _
| __ )  ___  _ __ __| | ___ _ __ ___
|  _ \ / _ \| '__/ _` |/ _ \ '__/ __|
| |_) | (_) | | | (_| |  __/ |  \__ \
|____/ \___/|_|  \__,_|\___|_|  |___/
EOF
        echo "Press :'Enter' to confirm , 'Esc' to return back"
        echo
        opt2=$(gum choose --height=5 "border color" "border size")
        if [[ $opt2 == "border color" ]]
        then
            clear
            cat <<"EOF"
 _                   _                       _
| |__   ___  _ __ __| | ___ _ __    ___ ___ | | ___  _ __ ___
| '_ \ / _ \| '__/ _` |/ _ \ '__|  / __/ _ \| |/ _ \| '__/ __|
| |_) | (_) | | | (_| |  __/ |    | (_| (_) | | (_) | |  \__ \
|_.__/ \___/|_|  \__,_|\___|_|     \___\___/|_|\___/|_|  |___/
EOF

            echo "Press :'Enter' to confirm , 'Esc' to return back"
            echo
            opt3=$(gum choose --height=5 "Active border" "Inactive border")
            if [[ $opt3 == "Active border" ]]
            then
                clear
                cat <<"EOF"
    _        _   _                       _
   / \   ___| |_(_)_   _____    ___ ___ | | ___  _ __
  / _ \ / __| __| \ \ / / _ \  / __/ _ \| |/ _ \| '__|
 / ___ \ (__| |_| |\ V /  __/ | (_| (_) | | (_) | |
/_/   \_\___|\__|_| \_/ \___|  \___\___/|_|\___/|_|
EOF
            echo "Press :'Enter' to confirm , 'Esc' to return back"
            echo
            opt4=$(gum file --height=12 ~/.config/hypr/brain/config/borders/colors/active/)
            cp "$opt4" "$HOME/.config/hypr/settings/border_color_active.conf"
            elif [[ $opt3 == "Inactive border" ]]
            then
                clear
                cat <<"EOF"
 ___                  _   _                       _
|_ _|_ __   __ _  ___| |_(_)_   _____    ___ ___ | | ___  _ __
 | || '_ \ / _` |/ __| __| \ \ / / _ \  / __/ _ \| |/ _ \| '__|
 | || | | | (_| | (__| |_| |\ V /  __/ | (_| (_) | | (_) | |
|___|_| |_|\__,_|\___|\__|_| \_/ \___|  \___\___/|_|\___/|_|
EOF
            echo "Press :'Enter' to confirm , 'Esc' to return back"
            echo
            opt4=$(gum file --height=12 ~/.config/hypr/brain/config/borders/colors/inactive/)
            cp "$opt4" "$HOME/.config/hypr/settings/border_color_inactive.conf"
            fi
        elif [[ $opt2 == "border size" ]]
        then
                clear
                cat <<"EOF"
 _                   _                 _
| |__   ___  _ __ __| | ___ _ __   ___(_)_______
| '_ \ / _ \| '__/ _` |/ _ \ '__| / __| |_  / _ \
| |_) | (_) | | | (_| |  __/ |    \__ \ |/ /  __/
|_.__/ \___/|_|  \__,_|\___|_|    |___/_/___\___|
EOF
        echo
        read -rp "Enter time interval in minutes : " opt3
            echo  " general { " > "$HOME/.config/hypr/settings/border_size.conf"
            echo  "    border_size = $opt3" >> "$HOME/.config/hypr/settings/border_size.conf"
            echo  "}" >> "$HOME/.config/hypr/settings/border_size.conf"
        fi
    elif [[ $opt1 == "layouts" ]]
    then
        clear
        cat <<"EOF"
 _                            _
| |    __ _ _   _  ___  _   _| |_ ___
| |   / _` | | | |/ _ \| | | | __/ __|
| |__| (_| | |_| | (_) | |_| | |_\__ \
|_____\__,_|\__, |\___/ \__,_|\__|___/
            |___/
EOF
        echo "Press :'Enter' to confirm , 'Esc' to return back"
        echo
        opt2=$(gum file --height=3 ~/.config/hypr/brain/config/layouts/)
        cp "$opt2" "$HOME/.config/hypr/settings/layouts.conf"
fi
clear
done
