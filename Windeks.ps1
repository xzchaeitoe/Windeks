#This is a windows cleanup tool that will update windows, do dism, then run memory diagnostics. Just spam "y" or "a" whenever you get a prompt to do so.
#V 1.3.3


#This sets the execution policy to let the following commands work
    Set-ExecutionPolicy RemoteSigned



function Show-Menu
{
     param (
           [string]$Title = 'Windeks v 1.3.3'
     )
     cls
     Write-Host "================ $Title ================"
    
     Write-Host "1: Press '1' to update, do system scan, and DISM."
     Write-Host "2: Press '2' to check the hard drive for errors and run memory diagnostics."
     Write-Host "3: Press '3' to run a performance check."
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
           } 'q' {
                return
           }
     }
     pause
}
until ($input -eq 'q')





