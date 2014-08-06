First run seems successful.

Of course, you'll want to test this on your own.

** If you installed from ports, you can use this updater. **

curl is needed.  (pkg install curl)

How to use:
SSH to the FreeNAS box.
run jls and get the ID of the Plex Media Server
jexec <ID> csh
sh plexupdate.sh


If all goes well, the install will be successful.

Good Luck!
