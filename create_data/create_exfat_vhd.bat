
REM creates a vhd, formats it exfat, and then creates three files in three different timestamps
REM Assumes AEST as final timezone, change as you see fit
REM assumes theres no file in the local dir called vdisk1.vhd, create_vhd.txt, and detach_vhd.txt
REM v0.01

echo create vdisk file="%~dp0vdisk1.vhd" maximum=10 > "%~dp0\create_vhd.txt"
echo select vdisk file="%~dp0vdisk1.vhd" >> "%~dp0\create_vhd.txt"
echo attach vdisk >> "%~dp0\create_vhd.txt"
echo create partition primary >> "%~dp0\create_vhd.txt"
echo format fs=exfat label "win exfat" quick >> "%~dp0\create_vhd.txt"
echo assign letter="z" >> "%~dp0\create_vhd.txt"
echo detatch vdisk >> "%~dp0\create_vhd.txt"
echo exit >> "%~dp0\create_vhd.txt"

diskpart /s "%~dp0\create_vhd.txt"

tzutil /s "AUS Eastern Standard Time"
timeout /t 1 /nobreak
echo "aest" > "Z:\1aest.txt"
timeout /t 30 /nobreak
tzutil /s "Pacific Standard Time"
timeout /t 1 /nobreak
echo "pst" > "Z:\2pst.txt"
timeout /t 30 /nobreak
tzutil /s "Eastern Standard Time"
timeout /t 1 /nobreak
echo "est" > "Z:\3est.txt"
tzutil /s "AUS Eastern Standard Time"

echo select vdisk file="%~dp0vdisk1.vhd" > "%~dp0\detach_vhd.txt"
echo detach vdisk >> "%~dp0\detach_vhd.txt"
diskpart /s "%~dp0\detach_vhd.txt"
