# adb-verus-install
## Table of contents<a name='toc'></a>
- [x] [What's this for?](#what-for)
- [x] [Who can use this?](#what-use)
- [x] [Requirements](#requirements)
- [x] [Setup](#setup)
    - [x] [Phone Setup](#setup-phone)
    - [x] [PC Setup](#setup-pc)
    - [x] [Script Setup](#setup-script)
- [x] [Miner Installation](#instatllation)
- [x] [Diclaimer](#disclaimer)
# ❓What's this for?<a name='what-for'></a>[🔗](#toc)
* Running a verus miner in mobile phone ( for [Luckpool.net](https://luckpool.net/verus/connect.html) for now )
* Seemless and smoooth miner installation
* Designed for multiple and continuous phone mining setup

# 🙈Who can use this?<a name='what-use'></a>[🔗](#toc)
* Anyone who wants to
    - explore and try verus phone mining
    - maximize the hash power of their phone miner
    - build phone mining hub without the hassle of repetitive and tedious setup
* Anyone with spare android mobile phone to play with and nothing to lose - [ see the requirements ]

# 📋Requirements<a name='requirements'></a>[🔗](#toc)
* 💻Computer
* 📱Android phone
  - `version`: Android 7.x+ to 10.x ( 11.x might have some issues for some brands )
  - `architecture`: 64 bit 
  - `processor`: octa-core (can also be run in quad-core for some brands)
  - [Git and git-bash](https://git-scm.com/downloads) (other terminals can be used as well)
* USB data cable
* [ADB Installation](https://developer.android.com/studio/releases/platform-tools)
* 🔑Verus public address
> 📌NOTE:
> This is mostly tested in `android one`, `hauwei`, `samsung`, `sharp` and `fujitsu` phones


# ⚙️Setup<a name='setup'></a>[🔗](#toc)
`PC` and `SCRIPT` setup should be done once. It might take a while at first but once set, your next setup should take less than 15 minutes.

## [ 📱 PHONE ]<a name='setup-phone'></a>[🔗](#toc)
 - [Enable developer mode in the target device](https://duckduckgo.com/?q=how+to+enable+developer+mode+android&t=newext&atb=v286-1&ia=web)
 - Enable `USB Debugging`
    - ![usb debugging](https://github.com/pangz-lab/adb-verus-install/blob/main/scripts/readme_assets/usbdebug.png?raw=true)
    - This is the minimun setting but other phone brand might require additional setting to allow the communication with ADB.
 - Connect the phone to your PC with the data cable
 - In the first run, a message will popup asking to `Allow USB Debugging?`. Click `OK`.
    - Check `Always allow from this computer` so popup won't require confirmation the next time you connect.
    - ![allow debugging message](https://www.howtogeek.com/wp-content/uploads/2016/04/Screenshot_20160419-094818.png)
> 📌NOTE:
> If you plan to use your phone solely for mining, uninstall and disable unnecessary apps and services to maximize your resources.
## [ 💻 PC ]<a name='setup-pc'></a>[🔗](#toc)
 - Open `git-bash` terminal
 - [Check ADB installation.](https://duckduckgo.com/?q=how+to+install+ADB&t=newext&atb=v286-1&ia=web)
    ```bash
    adb --help
    ```
    - It should give version and other details
    - ![adb connection](https://github.com/pangz-lab/adb-verus-install/blob/main/scripts/readme_assets/adb2.png?raw=true)
 - Check the connected device.<a name="Adb-connected-device"></a>
    ```bash
    adb devices
    ```
    - When phone is setup properly, it should appear from the `List of devices attached`
    - The left side is the device ID. 📌Take note. <a name="Adb-device-id"></a>
    - ![adb connection](https://github.com/pangz-lab/adb-verus-install/blob/main/scripts/readme_assets/adb1.png?raw=true)
## [ 💲 SCRIPT ]<a name='setup-script'></a>[🔗](#toc)
 - [Clone this repository](https://github.com/pangz-lab/adb-verus-install/tree/main)
    ```bash
    git clone git@github.com:pangz-lab/adb-verus-install.git
    ```
 - Go to the `scripts` folder
    ```bash
    cd [download directory]\adb-verus-install\scripts\
    ```
 - Open `\config\default.sh` - this is the default configuration file
 - Update the configuration with the following keys
    1. `MINER_PUB_KEY` : public address
    2. `MINER_PREFIX` : miner prefix name. Any alphanumeric character. <a name="conf-key-miner-prefix"></a>
    3. `MINER_STRAT` : mining pool server. This is optional. You can leave it for now.

> ⛔️ Don't use public address from any trading platform. `"Not your keys, not your coins"`

 - Download the following link and extract it inside the `\APKs\default\` folder
    - [Default Apps](https://drive.google.com/file/d/1aD-foW03mh0YINDl7_P6AcCv3oj4wDu6/view?usp=sharing)
    - These files are app apks that can be installed automatically during the setup. termux and termux-api are included by default.
    - This is configured in `default.sh` under `APK_COLLECTION`.
    - If you need to include other app, put the apk in the same folder and add the name in `APK_COLLECTION` array.

 # 👨‍💻Miner Installation<a name='miner-installation'></a>[🔗](#toc)
 - Open `git-bash`
 - [Make sure the device is connected](#Adb-connected-device)
 - [Get the device serial no.](#Adb-device-id)
 - Go to the `scripts` folder
    ```bash
    cd [download directory]\adb-verus-install\scripts\
    ```
 - Run the following command to show the required parameters
    ```bash
    ./setup.sh
    ```
    - Should appear like `./setup.sh <serial no.> <miner name> <mode> <thread>`
    - `serial no.` : [device serial number](#Adb-device-id)
    - `miner name` : any alphanumeric value. This will be appended in the miner suffix from the [configuration](#conf-key-miner-prefix)
    - `mode` : either 'x' or 'HYBRID' - [see luckpool setting](https://luckpool.net/verus/connect.html)
    - `thread` : number of cpu to use
 - Run the following command to install. Don't disconnect or move your phone to avoid interruption
    ```bash
    # i.e. 
    # The parameter varies per phone especially the device serial no.
    ./setup.sh STP0219425010219 H1M1 HYBRID 8
    ```
    - Wait for the the installation to complete
    - The device can be disconnected after the installation.
    - ![adb connection](https://github.com/pangz-lab/adb-verus-install/blob/main/scripts/readme_assets/setup1.png?raw=true)
 - From your phone, open the `termux` app
 - Follow the instruction showing in the terminal starting from `[ Open Termux ]`
    - The command `pkg install termux-api` might not be completed for some installation. Just proceed to the next step.
    - ![adb connection](https://github.com/pangz-lab/adb-verus-install/blob/main/scripts/readme_assets/setup2.png?raw=true)
    - Termux will automatically close at some point, you need to reopen it.
 - Setup is complete
 - Open `termux` - the miner will run automatically
 - To check, change the `YOUR_PUBLIC_ADDRESS` and open [https://luckpool.net/verus/miner.html?[YOUR_PUBLIC_ADDRESS]](https://luckpool.net/verus/miner.html?RTV4siJREZNdk6Y9rrsmXVehLtPa7QTaZN)
- ![done](https://images.techhive.com/images/article/2014/01/sheldon_thats_how_its_done-580-100221962-orig.gif)


# ⚠️Disclaimer<a name='disclaimer'></a>[🔗](#toc)
> This script is intended for educational purpose only. Anyone who uses this shall be held liable and fully responsible for any damage or loss in any way involving the usage of these scripts.