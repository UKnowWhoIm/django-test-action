import os
import re

if __name__ == "__main__":
    env_file = os.environ.get("GITHUB_WORKSPACE") + "/" + os.environ.get("4")
    shell_file = os.environ.get("GITHUB_WORKSPACE") + "/" + os.environ.get("SHELL_FILE_NAME")
    env_commands = []
    valid_cmd = "([A-Za-z_][A-Za-z0-9_]*=[^# ]+)"
    
    with open(env_file, "r") as f:
        for line in f.readlines():
            cmd = re.findall(valid_cmd, line)
            if cmd:
                env_commands.append("export " + cmd[0])
    
    with open(shell_file, "w") as f:
        for cmd in env_commands:
            f.write(cmd)