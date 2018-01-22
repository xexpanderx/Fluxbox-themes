Desktop theme for Fluxbox containing:
* GTK2
* Fluxbox theme
* Fluxbox init
* Icons by pobtott: http://pobtott.deviantart.com/art/Any-Color-You-Like-175624910.
* Geany colorscheme
* Xdefaults
* Dircolors
* ls++.conf
* bashrc
* Wallpaper by Momez: http://momez.deviantart.com/art/Storm-339270850.

<b>Basic installation</b>

How to install GTK2,  Icons, Fluxbox theme and config. For the other config files you are on your own.

<b>1.</b>

Put <i>DaftP</i>-folder from <i>Fluxbox-theme</i>-folder to your <i>~/.fluxbox/styles/</i>.

<b>2.</b>

Put <i>DaftP</i>-folder from <i>GTK2</i>-folder to your <i>~/.themes/</i>.

<b>3.</b>

Unzip and extract <i>DaftP.zip</i> from <i>Icons</i>-folder to your <i>~/.icons/</i>.


<b>4.</b>

Put <i>init</i> from <i>Fluxbox-configs</i>-folder to your <i>~/.fluxbox/</i> and overwrite the existing one (make sure to make a backup first).

<b>5.</b>

Edit that <i>init</i>-file and then lookup and change the <b>bolded</b> in following lines so it matches your username:

<i>session.screen0.windowMenu: /home/<b>alexsson</b>/.fluxbox/windowmenu</i>

<i>session.slitlistFile: /home/<b>alexsson</b>/.fluxbox/slitlist</i>

<i>session.styleFile: /home/<b>alexsson</b>/.fluxbox/styles/DaftP</i>

<i>session.appsFile: /home/<b>alexsson</b>/.fluxbox/apps</i>

<i>/home/<b>alexsson</b>/.fluxbox/overlay</i>

<b>6. (OPTIONAL)</b>

If you want to have only border around the windows like in the screenshot above make sure to use the Fluxbox theme <i>DaftP (with border)</i> and change following line in <i>init</i>-file:

<i>session.screen0.defaultDeco: <b>NORMAL</b></i>

to

<i>session.screen0.defaultDeco: <b>BORDER</b></i>

<b>7.</b>

Restart Fluxbox.
