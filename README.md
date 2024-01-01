### Installation

Just run `setup.sh`

### macOS and Linux

1. Open the Terminal application.
2. Change the directory to where your `setup.sh` script is located using the `cd` command. For example: `cd path/to/directory`
3. Before running the script, you might need to give it executable permissions. You can do this with the `chmod` command: `chmod +x setup.sh`
4. Run the script with the following command: `./setup.sh`
   The `./` is used to execute a script in the current directory.
   
   Or just use:
   `source setup.sh`

### Windows

Windows uses a different type of shell by default, and `.sh` scripts are typically for Unix-like environments like macOS and Linux. To run `.sh` scripts on Windows, you can:

#### Use Git Bash (comes with Git for Windows)

1. Right-click on the folder containing `setup.sh` and select "Git Bash Here" to open a Git Bash terminal.
2. Run the script with: `./setup.sh`

#### Use Windows Subsystem for Linux (WSL)

If you have WSL installed:

1. Open your WSL terminal.
2. Navigate to the directory containing your `setup.sh` file.
3. Make sure the file is executable (`chmod +x setup.sh`).
4. Run the script (`./setup.sh`).

#### Use Cygwin

1. Open the Cygwin terminal.
2. Navigate to the directory containing your `setup.sh` file.
3. Make sure the file is executable (`chmod +x setup.sh`).
4. Run the script (`./setup.sh`).
