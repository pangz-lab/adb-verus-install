# adb-verus-install
## Table of contents<a name='toc'></a>
- ❓ [What's this for?](#what-for)
- 🙈 [Who can use this?](#what-use)
- 📋 [Requirements](#requirements)
- ⚙️ [Setting](#setting)
    - 📱 [Phone](#setup-phone)
    - 💻 [PC](#setup-pc)
    - 💲 [Script](#setup-script)
- 👨‍💻 [Miner Installation](#miner-installation)
- ⚠️ [Diclaimer](#disclaimer)
# ❓What's this for?<a name='what-for'></a>[🔗](#toc)
* Running a verus miner in mobile phone ( used for [Luckpool.net](https://luckpool.net/verus/connect.html) for now )
* Seemless and smoooth miner installation
* Designed for multiple and continuous phone mining setup

# 🙈Who can use this?<a name='what-use'></a>[🔗](#toc)
* Anyone with spare android mobile phone to play with and nothing to lose - [ see the requirements ](#requirements)
* Anyone who wants to
    - explore and try verus phone mining
    - maximize the hash power of their phone miner
    - build phone mining hub without the hassle of repetitive and tedious setup

# 📋Requirements<a name='requirements'></a>[🔗](#toc)
* [x] 🔑Verus public key/address
* [x] 💻Computer
* [x] [ADB Installation](https://developer.android.com/studio/releases/platform-tools)
* [x] [Git and git-bash](https://git-scm.com/downloads) (other terminals can be used as well)
* [x] 📱Android phone
  - `version`: Android 7.x+ to 10.x ( 11.x might have some issues for some brands )
  - `architecture`: 64 bit 
  - `processor`: octa-core (can also be run in quad-core for some brands)
* [x] USB data cable
> 📌NOTE:
> This is mostly tested in `android one`, `hauwei`, `samsung`, `sharp` and `fujitsu` phones


# ⚙️Setting<a name='setting'></a>[🔗](#toc)
`PC` and `SCRIPT` setup should be done once. It might take a while at first but once set, your next setup should take less than 15 minutes.

## [ 📱 Phone ]<a name='setup-phone'></a>[🔗](#toc)
 1. [Enable developer mode in the target device](https://duckduckgo.com/?q=how+to+enable+developer+mode+android&t=newext&atb=v286-1&ia=web)
 2. Enable `USB Debugging`
    - ![usb debugging](https://github.com/pangz-lab/adb-verus-install/blob/main/scripts/readme_assets/usbdebug.png?raw=true)
    - This is the minimun setting but other phone brand might require additional setting to allow the communication with ADB.
 3. Connect the phone to your PC with the data cable.
 4. In the first run, a message will popup asking to `Allow USB Debugging?`.
    - Check `Always allow from this computer` so popup won't require confirmation the next time you connect.
    - Click `OK`
    - ![allow debugging message](https://www.howtogeek.com/wp-content/uploads/2016/04/Screenshot_20160419-094818.png)
> 📌NOTE:
> If you plan to use your phone solely for mining, uninstall and disable unnecessary apps and services to maximize your resources.
## [ 💻 PC ]<a name='setup-pc'></a>[🔗](#toc)
 1. Open `git-bash` terminal
 2. [Check ADB installation.](https://duckduckgo.com/?q=how+to+install+ADB&t=newext&atb=v286-1&ia=web)
    ```bash
    adb --help
    ```
    - It should give version and other details
    - ![adb connection](https://github.com/pangz-lab/adb-verus-install/blob/main/scripts/readme_assets/adb2.png?raw=true)
 3. Check the device connection.<a name="Adb-connected-device"></a>
    ```bash
    adb devices
    ```
    - When phone is properly set, it should appear from the `List of devices attached`
    - The left side is the device ID. 📌Take note. <a name="Adb-device-id"></a>
    - ![adb connection](https://github.com/pangz-lab/adb-verus-install/blob/main/scripts/readme_assets/adb1.png?raw=true)
## [ 💲 Script ]<a name='setup-script'></a>[🔗](#toc)
 1. [Clone this repository](https://github.com/pangz-lab/adb-verus-install/tree/main)
    ```bash
    git clone git@github.com:pangz-lab/adb-verus-install.git
    ```
 2. Go to the `scripts` folder
    ```bash
    cd [download_directory]\adb-verus-install\scripts\
    ```
 3. Open `\config\default.sh` - this is the default configuration file
 4. Update the configuration with the following keys
    - `MINER_PUB_KEY` : Verus public key/address
    - `MINER_PREFIX` : miner prefix name. Any alphanumeric character. <a name="conf-key-miner-prefix"></a>
    - `MINER_STRAT` : mining pool server. This is optional. You can leave it for now.
> ⛔️ Don't use public address from any trading platform. `Not your keys, not your coins`

 # 👨‍💻Miner Installation<a name='miner-installation'></a>[🔗](#toc)
 1. Open `git-bash` terminal
 2. [Make sure the device is connected](#Adb-connected-device)
 3. [Get the device serial no.](#Adb-device-id)
 4. Go to the `scripts` folder
    ```bash
    cd [download_directory]\adb-verus-install\scripts\
    ```
 5. Download the resource files from following links(`Default Apps` and `Environment`) and extract the content in each specific folder.
    - [Default Apps](https://drive.google.com/file/d/1aD-foW03mh0YINDl7_P6AcCv3oj4wDu6/view?usp=sharing)
        - i.e. `\scripts\APKs\default\appname.apk` - `appname` is the extracted app
        - These files are app apks that can be installed automatically during the setup. termux and termux-api are included by default.
        - This is configured in `default.sh` under `APK_COLLECTION`.
        - If you need to include other app, put the apk in the same folder and add the name in `APK_COLLECTION` array.
        - ![environment](https://github.com/pangz-lab/adb-verus-install/blob/main/scripts/readme_assets/setup4.png?raw=true)
    - [Environment](https://drive.google.com/file/d/1-09qY8y-91xYO-9crWml-EDefwYAJNzv/view?usp=sharing)
        - i.e. `\scripts\data\termux\termbk.tar.gz` - Linux OS image. No need to extract.
        - ![environment](https://github.com/pangz-lab/adb-verus-install/blob/main/scripts/readme_assets/setup3.png?raw=true)
 6. Run the following command to show the required parameters
    ```bash
    ./setup.sh
    ```
    - Should appear like `./setup.sh <serial no.> <miner name> <mode> <thread>`
    - `serial no.` : [device serial number](#Adb-device-id)
    - `miner name` : any alphanumeric value. This will be appended in the miner prefix from the [configuration](#conf-key-miner-prefix)
    - `mode` : either 'x' or 'HYBRID' - [see luckpool setting](https://luckpool.net/verus/connect.html)
    - `thread` : number of processor to use
 7. Run the following command to start the installation. Don't disconnect or move your phone to avoid interruption.
    ```bash
    # i.e. 
    # The parameter varies per phone especially the device serial no.
    ./setup.sh STP0219425010219 H1M1 HYBRID 8
    ```
    - Wait for the the installation to complete.
    - The device can be disconnected after the installation.
    - ![adb connection](https://github.com/pangz-lab/adb-verus-install/blob/main/scripts/readme_assets/setup1.png?raw=true)
 8. Open the `termux` app from your phone.
 9. Follow the instruction showing in the terminal starting from `[ Open Termux ]` section.
    - The command `pkg install termux-api` might not be completed for some installation. Just proceed to the next step.
    - ![adb connection](https://github.com/pangz-lab/adb-verus-install/blob/main/scripts/readme_assets/setup2.png?raw=true)
    - Termux will automatically close at some point, you need to reopen it.
 10. Setup is complete
 11. To check, change the `[YOUR_PUBLIC_ADDRESS]`
 12. Open [https://luckpool.net/verus/miner.html?[YOUR_PUBLIC_ADDRESS]](https://luckpool.net/verus/miner.html?RUYVdsamoaJ5JwB2YZyPHCAVXeNa87GV5Q)
 - ![done](https://images.techhive.com/images/article/2014/01/sheldon_thats_how_its_done-580-100221962-orig.gif)


# ⚠️Disclaimer<a name='disclaimer'></a>[🔗](#toc)
> This script is intended for educational purpose only. Anyone who uses this or wish to use shall be held liable and fully responsible for any damage or loss in any way involving the usage of these scripts.