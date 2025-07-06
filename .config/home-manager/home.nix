{ config, pkgs, ... }:

{
  home.username = "percy";
  home.homeDirectory = "/home/percy";
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    hello
    (python3.withPackages (ps: with ps; [
    pygobject3
    ]))
  ];

  home.stateVersion = "25.05";  # Change this to your NixOS version (e.g., 24.05)

  # home.sessionVariables = {
  #   XCURSOR_THEME = "Bibata-Modern-Ice";  # <- replace with the actual folder name
  # };

  gtk = {
    enable = true;
    iconTheme = {
      name = "papirus-icon-theme";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "bibata-cursors";
      package = pkgs.bibata-cursors;
    };
    theme = {
      name = "Awesthetic-dark";
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };

  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "lock";
        action = "hyprlock";
        text = "Lock";
        keybind = "l";
      }
      {
        label = "logout";
        action = "hyprctl dispatch exit";
        text = "Logout";
        keybind = "e";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot";
        keybind = "r";
      }      
    ];

    style = ''
      * {
        background-image: none;
        box-shadow: none;
      }

      window {
        background-color: rgba(12, 12, 12, 0.6);
      }

      button {
        border-radius: 0;
        border-color: black;
        text-decoration-color: #FFFFFF;
        color: #FFFFFF;
        background-color: #141414;
        border-style: solid;
        border-width: 1px;
        background-repeat: no-repeat;
        background-position: center;
        background-size: 25%;
      }

      button:focus, button:active, button:hover {
        outline-style: none;
        background-color: #282828;
      }

      #lock {
        background-image: image(url("/home/percy/.config/wlogout/assets/lock.svg")); 
      }

      #logout {
        background-image: image(url("/home/percy/.config/wlogout/assets/logout.svg"));
      }

      #shutdown {
        background-image: image(url("/home/percy/.config/wlogout/assets/shutdown.svg"));
      }

      #reboot {
        background-image: image(url("/home/percy/.config/wlogout/assets/reboot.svg"));
      }      
    '';

  };
}

