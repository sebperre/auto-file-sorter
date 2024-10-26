# Auto File Sorter

## Overview

Auto File Sorter is a Bash script that automates the process of sorting your files based on file type.

## Features

- **Easy Folder Input and Output**: Easily choose which files you want to sort and where you want to put these sorted folders.
- **Copy or Move**: You have the choice of moving the files from their location or copying them.
- **Overwrite Safety**: There is overwrite safety in case there are files with the same name. You can bypass this safety with the -f flag.
- **Verbose Mode**: Get updates of how far along the sorting process is.

## Requirements

- Bash

## Usage

```bash
./auto_sorter.sh (-v) (-c) (-f) [Path to folder to sort] [Path to store the output]
```

*Note: The order of the commands matter (flags then parameters)*

### Options

- `-v`: Verbose Mode, output information about how the transfer is going
- `-c`: Copy Mode, copy the files instead of moving them
- `-f`: Force Mode, say yes to all file overwrites

### Aliasing
To add the command as an alias,

```bash
cd ~
vim .bashrc
```

At the bottom of the file, add
```bash
alias sort_files="<absolute path of the directory where the script is stored>/auto_sorter.sh -v . ."
```

Now, you can sort files in your current folder.

## Example

```bash
./auto_sorter.sh -vcf /mnt/c/Users/sebpe/Downloads .
```

This example sorts and transfers my files from my downloads folder to my current directory. Put it in verbose mode to view how the transfer is going, put in copy mode to copy the files and not move them and finally say yes to all overwrites.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
