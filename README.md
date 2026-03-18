Thebonkening

Thebonkening is a shell script that prints messages, and closes the terminal with a bonk

Features

Random glitch messages

Occasional terminal errors/messages appear while typing commands.
Messages are drawn from a list containing fake system errors.
Command limit with final “bonk”

Counts commands in the shell.
After a random number of commands (3-6 by default), prints bonk, waits 3 seconds, and closes the terminal.
Automatic persistence

Adds itself to your ~/.bashrc automatically (if not already present).
Ensures all new terminal sessions will run thebonkening.
Compact and efficient

The script is minimal and designed to run without noticeable lag.
How It Works

Variables

THEBONKENING_ACTIVE – Environment variable used to prevent the script from running multiple times in the same session.
CMD – Counts the number of commands executed in the current shell session.
MAX – Randomly chosen limit of commands (3-6) before the shell prints bonk and closes.
MESSAGES – Array of occasional “glitchy” messages displayed randomly.
Functions

limit()

Hooked into PROMPT_COMMAND, so it runs after every command.
Increments CMD.
Occasionally prints a random message.
If CMD >= MAX, prints bonk, waits 3 seconds, and terminates the shell.
DEBUG trap

Hooked on every command (trap ... DEBUG) as an extra mechanism to occasionally print random messages.
Prevents recursion when running _cmd_counter.
Auto-Hook Into Terminals

The script appends a check to ~/.bashrc: [[ -f "$HOME/.thebonkening.sh" && -z "$THEBONKENING_ACTIVE" ]] && source "$HOME/.thebonkening.sh"
This ensures that all new shells automatically run thebonkening without manually sourcing it.
Usage

Save the script as ~/.thebonkening.sh.
Make it executable: chmod +x ~/.thebonkening.sh
Open a new terminal or source it manually for testing: source ~/.thebonkening.sh
Random messages appear as you type commands.
After a random number of commands, bonk is printed, and the terminal closes after 5 seconds.
Safety Notes


To remove the script, delete the file and the flag: rm ~/.thebonkening.sh ~/.thebonkening_active sed -i '/thebonkening.sh/d' ~/.bashrc
Customization

if you git clone this make sure to change the source to "/thebonkening/.thebonkening.sh" or whatever your directory is

Messages: Edit the MESSAGES array to add your own fun or spooky messages.
Command limit: Change MAX=$((RANDOM%4+3)) to set the min/max number of commands before the terminal closes.
Bonk delay: Adjust the sleep 3 in limit() to change how long the terminal waits before closing.

Installation:
curl -o ~/.thebonkening.sh https://raw.githubusercontent.com/Visco-22/thebonkening/main/.thebonkening.sh
chmod +x ~/.thebonkening.sh
source ~/.thebonkening.sh
