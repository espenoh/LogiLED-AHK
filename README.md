# LogiLED-AHK
Simple Logitech LED SDK wrapper for AutoHotKey. The sample code dims all keys to user set level, and then shows the status of the lock-keys (Caps/Num/Scroll) by lighting up the keys. If you set the initial intesity to `0` not even the status indicator lights on the keyboard will light up.

**Note this script was made for a G610 which does *not* have RGB lightning. As such the values are set using only the red color channel, as that will control the intesity on single-color keyboards. To use this on a RGB board some tweaking of the values to make sane colors are probably needed.**

## How to run
* Be sure [AutoHotKey](https://www.google.com) is installed.
* Have both the `LogiLED.ahk` and `LogitechLedEnginesWrapper.dll` file in the same folder
* Double click `.ahk` file

## DLL file
The DLL is taken directly from the Logitech SDK. I used the one targeting external game engines, as the the other ones (static `.lib` version and the JNI version for Java) did not seem to work properly with AHK. Note if you need a newer version, or just want the official version directly, the DLL can be downloaded from the [Logitech G Developer Lab](http://gaming.logitech.com/en-us/developers)
