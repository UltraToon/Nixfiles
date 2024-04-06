{config, libs, pkgs, inputs, ...}: {
  home = {
    stateVersion = "23.05";
    username = "ivan";
    homeDirectory = "/home/ivan";
    packages = with pkgs; [
      gamemode
      ffmpeg
      mpv
      btop
      rofi
      prismlauncher
    ];
 };
 programs.home-manager.enable = true;
 imports = [
   ./programs/hypr
   ./programs/foot
   ./programs/fonts
   ./programs/firefox
   ./programs/mako
   ./programs/git
   ./programs/nvim
 ];
}
