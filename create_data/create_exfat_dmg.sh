# create an exfat dmg with a few files in different timezones
# assumes AEST so change the timezone as required

# usage: sudo create_exfat_dmg.sh 
# assumes that there's nothing mounted as volume name "exfat"
# run "chmod +x create_exfat_dmg.sh" to enable execution

# v0.01

hdiutil create -size 10m -fs exfat -volname "exfat" "exfat.dmg"

hdiutil mount exfat.dmg

sleep 10

/usr/sbin/systemsetup -settimezone Australia/Sydney
echo aest > /Volumes/exfat/aest.txt 

sleep 10

/usr/sbin/systemsetup -settimezone America/Los_Angeles
echo pst > /Volumes/exfat/pst.txt

sleep 10

/usr/sbin/systemsetup -settimezone America/New_York
echo est > /Volumes/exfat/est.txt

hdiutil unmount /Volumes/exfat
