{config, pkgs, ...}:
{
  imports = [ 
    ./hardware-configuration.nix
  ];

  boot = {
    initrd.kernelModules = ["amdgpu"];
    tmp.cleanOnBoot = true;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        editor = false;
        configurationLimit = 5;
      };
    };
  };

  time.timeZone = "America/Los_Angeles";
  zramSwap.enable = true;
  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        rocm-opencl-icd
        rocm-opencl-runtime
        libva
        vaapiVdpau
      ];
    };
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };
  environment.systemPackages = with pkgs; [
    polkit_gnome
  ];

  users.users.ivan = {
      isNormalUser = true;
      description = "Ivan";
      extraGroups = ["wheel" "input" "audio"];
  };

  nix = {
    extraOptions = ''experimental-features = nix-command flakes'';
    settings = {
      auto-optimise-store = true;
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  nixpkgs.config.allowUnfree = true;
   
  programs = {
    steam = {
      enable = true;
    };
  };

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
      extraConfig.pipewire."92-low-latency" = {
        "context.properties" = {
          "default.clock.rate" = 48000;
          "default.clock.quantum" = 32;
          "default.clock.min-quantum" = 32;
          "default.clock.max-quantum" = 32;
         };
      };
    };
  };

  networking = {
    hostName = "forest";
    firewall = {
      enable = false;
    };
  };

  system.stateVersion = "23.05";
}
