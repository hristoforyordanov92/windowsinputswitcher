# Windows Keyboard Layout Input Switcher

An AHK script for Windows 10 (potentially supports more Windows versions) for quickly switching to a specific keyboard layout input language.

# Why?

I currently have 4 input languages installed on my computer:
English, Bulgarian, Japanese and German.
Switching between them using Alt + Shift is extremely annoying, especially when working mostly with the first two.
Yes, there is an option provided by Microsoft to switch to a specific language using a special hotkey (Alt + Shift + NUMBER) but it only works for English and Japanese for some reason...

So I wanted to make my own way of switching language that ACTUALLY works.

# Problems with the script

The script is not user-friendly at all! I HATE this fact, but I'm too lazy to fix it at this point, as I'm the only person using this script.
Currently you'll have to know a little bit of AHK, or at least be motivated enough to open the script with notepad and modify it to your needs.

The possible languages that the script can switch to must be changed manually and their IDs must be discovered manually using a special hotkey (you have to enable it by uncommenting the code of the hotkey)

Then you also have to make sure that your hotkey works for switching languages. It's currently using the hotkey combination of that keyboard button that simulates a right mouse click + a number, in order to switch to the specific language.

Switching between the languages is done by simulating the press of Alt + Shift key combination, which may not work on your computer, because of your current language switching settings. So you'll need to change these keys yourself or change the keybinds you use to switch languages.

Also, if you have more or less languages than me, you'll have to add the new hotkeys yourself (which is easy enough, but still not user friendly).

There might be additional problems with the script that I haven't accounted for, but I have no userbase, so no way to fix those potential bugs.

Maybe I will make this more user-friendly, if at least 1 more person wants to use this script. Otherwise, I won't bother.

# How to use it?

1. Go to https://www.autohotkey.com/ and download the latest version of AHK.
2. Download the script from this repository and double-click it. The script will be loaded and you'll be able to use it (assuming you've figured a way to work around all the issues from the topic above!)
3. Place the script in your Startup folder in order to have it automatically load with Windows. (use Google to find out how to put a program in Startup for your Windows)
4. You can change the script's icon by placing an icon of your choice next to the script. The icon must be of .ico type and named "icon". So: "icon.ico" :)
5. After spending 1 hour of trying to run the script, see that it doesn't work and [open an issue](https://github.com/hristoforyordanov92/windowsinputswitcher/issues/new) in this repository. I will try to help :)

# Why simulate Alt + Shift instead of using DLL calls to change languages?

I tried using lots of different DLL calls taken from pinvoke, even using C# language, but I lost my patience, as nothing was working as good as I expected it to.
This is why I reverted back to the primitive ways of simulating Alt + Shift to get the job done.

# Contribute?

If you want to contribute, just make a merge request and I'll review it. I doubt anyone will ever find this script, but I never know :D
