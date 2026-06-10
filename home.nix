 { config, pkgs, system, inputs, ... }:
let
   dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
    create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
    configs = {
      qtile = "qtile";
      nvim = "nvim";
      alacritty = "alacritty";
      rofi = "rofi";
    };
in
{
  home.username = "phantasm";
  home.homeDirectory = "/home/phantasm";
  home.stateVersion = "26.05";
  programs.bash = {
    enable = true;
    shellAliases = {
      sanitytest = "Welcome";
    };
 };

  imports = [
    ./home-modules
  ];

  programs.git = {
    enable = true;
    settings = {
      user = {
        name  = "";
        email = "";
      };
      init.defaultBranch = "main";
    };
  };

  services.flameshot = {
    enable = true;
    settings = {
      General = {
        savePath = "/home/phantasm/Screenshots";
        disabledTrayIcon = true;
        showStartupLaunchMessage = false;
        saveAsFileExtension = ".png";
        showDesktopNotification = true;
        showAbortNotification = false;
        showHelp = true;
        showSidePanelButton = true;


        # Color Customization
        uiColor = "#740096";
        contrastUiColor = "#270032";
        drawColor = "#ff0000";

        useGrimAdapter = true;
        disabledGrimWarning = true;
      };
    };
  };


  # xdg.configFile."qtile" = {
  # source = create_symlink "${dotfiles}/qtile/";
  #  recursive = true;
  #};
  #
  #xdg.configFile."nvim" = {
  # source = create_symlink "${dotfiles}/nvim/";
  # recursive = true;
  #};
  #xdg.configFile."alacritty" = {
  # source = create_symlink "${dotfiles}/alacritty/";
  # recursive = true;
  #};
  home.packages = with pkgs; [
    neovim
    ripgrep
    nil
    nixpkgs-fmt
    nodejs
    gcc
    rofi
    vesktop
    steam
    flameshot
    grim
    clementine
    tk
    fastfetch
    zip
    xz
    unzip
    p7zip
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
