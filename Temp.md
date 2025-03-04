### Only for temporary usage

```
{ config, lib, pkgs, ... }:

let
  cfg = config.services.sdcPowerManager;
  slaveOptions = {
    options = {
      user = lib.mkOption { type = lib.types.str; };
      host = lib.mkOption { type = lib.types.str; };
    };
  };
  systemctl = pkgs.systemd + "/bin/systemctl";
  stopScriptName = "sdc-power-manager-exec-stop";
  stopScript = slaves: pkgs.writeTextFile {
    name = stopScriptName;
    executable = true;
    destination = "/bin/${stopScriptName}";
    text = ''
      #!${pkgs.python3.interpreter}

      import re
      import subprocess

      SYSTEMCTL = "${systemctl}"
      SLAVES = [
        ${lib.strings.concatMapStringsSep ", "
          ({ user, host }: ''
            { "user": "${user}", "host": "${host}" }
          '') slaves}
      ]

      def main():
        units = subprocess.run(
          [SYSTEMCTL, "list-units", "--type", "target"],
          stdout=subprocess.PIPE,
          check=True).stdout.decode("utf-8")
        if is_shutting_down(units):
          command = "reboot" if is_rebooting(units) else "poweroff"
          for slave in SLAVES:
            user = slave["user"]
            host = slave["host"]
            print(f"Sending '{command}' to {user}@{host}")
            ssh(user, host, f"sudo {command}")

      def is_shutting_down(units):
        return re.search(r"shutdown\.target", units) is not None

      def is_rebooting(units):
        return re.search(r"reboot\.target", units) is not None

      def ssh(user, host, command):
        subprocess.run([
          "ssh",
            "-o", "StrictHostKeyChecking=no",
            "-o", "IdentityFile=/home/d300/.ssh/id_rsa",
            "-o", "ConnectTimeout=10",
            f"{user}@{host}",
            command])

      if __name__ == "__main__":
        main()
    '';
  } + "/bin/${stopScriptName}";
in {
  options = {
    services.sdcPowerManager = {
      master = {
        enable = lib.mkEnableOption "sdc-power-manager master";
        slaves = lib.mkOption {
          type = lib.types.listOf (lib.types.submodule slaveOptions);
        };
      };
      slave = {
        enable = lib.mkEnableOption "sdc-power-manager slave";
      };
    };
  };

  config = {
    systemd.services.sdc-power-manager = lib.mkIf cfg.master.enable {
      description = "Managing power of remote computers";
      wantedBy = [ "multi-user.target" ];
      after = [
        "multi-user.target"
        "network.target"
        "network-online.target"
      ];
      before = [
        "shutdown.target"
        "reboot.target"
      ];
      path = [ pkgs.openssh ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = "yes";
        ExecStop = stopScript cfg.master.slaves;
        TimeoutSec = 30;
      };
    };
    security.sudo.extraConfig = lib.mkIf cfg.slave.enable ''
      d300 ALL=(ALL) NOPASSWD: /run/current-system/sw/bin/poweroff, /run/current-system/sw/bin/reboot
    '';
  };
}
```