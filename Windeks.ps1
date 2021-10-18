#This is a windows cleanup tool that can update windows, run a system scan, do dism, run memory diagnostics, check the hard drive for errors and run a performance check. Just select the option you want and hit "a" or "y" when it the prompt asks!
#V 1.4.0



function Show-Menu
{
     param (
           [string]$Title = 'Windeks v 1.4.0'
     )
     cls
     Write-Host "================ $Title ================"
    
     Write-Host "1: Press '1' to update, do system scan, and DISM."
     Write-Host "2: Press '2' to check the hard drive for errors and run memory diagnostics."
     Write-Host "3: Press '3' to run a performance check."
     Write-Host "4: Press '4' to view chkdsk and memtest logs."
     Write-Host "Q: Press 'Q' to quit."
}
do
{
     Show-Menu
     $input = Read-Host "Please make a selection"
     switch ($input)
     {
           '1' {
                cls


                #This will install the updater module
                    Install-module PSWindowsUpdate

                    Import-Module PSWindowsUpdate



                #This will install the windows update service in case you don't have it
                    Add-WUServiceManager -ServiceID 7971f918-a847-4430-9279-4a52d1efe18d



                #This will install the windows update
                    Get-WindowsUpdate

                    Download-WindowsUpdate

                    Install-WindowsUpdate



                #This is DISM, which checks the current windows version against the online DISM server
                    cd C:\WINDOWS\system32

                    DISM /Online /Cleanup-Image /CheckHealth

           } '2' {
                cls
                #This is check disk, which will check your hard drive for errors
                    chkdsk C: /f /r /x


                #This will run the windows memory diagnostics tool
                    cd C:\Windows\System32

                    ./mdsched.exe

           } '3' {
                cls
                #This will run a performance check to see how your system is currently doing
                    perfmon /report
                    
           } '4' {
                cls
                #This will open the logs for chkdsk and memtest
                
                    get-winevent -FilterHashTable @{logname=”Application”; id=”1001"}| ?{$_.providername –match "wininit”}
                    
                    get-winevent -FilterHashTable @{logname='System'; id='1101'}^|?{$_.providername -match 'MemoryDiagnostics-Results'}
                    
                    get-winevent -FilterHashTable @{logname='System'; id='1201'}^|?{$_.providername -match 'MemoryDiagnostics-Results'}
                    
           } 'q' {
                return
           }
     }
     pause
}
until ($input -eq 'q')





