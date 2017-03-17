# Init user unput

param (
    [Parameter(Mandatory=$true)][string]$src,
    [Parameter(Mandatory=$true)][string]$dst,
    [bool]$write=$false
    )

# Output initial parameters

Write-Output ''.'Usage: MediaSync.ps1 -src <source> -dst <destination> -write 0|1'
Write-Output 'Usage: If there is no destination directory, it will be created '
Write-Output 'Usage: but you have to run script one more time to sync files'
Write-Output '','Use " for path variables'
Write-Output '','Source directory: $src'
Write-Output 'Destination directory: $dst'
Write-Output 'Write: $write',''

# Walk directories
ForEach ($dir in ls $src)
{
    # Test if folder exists
    $TestPath = Test-Path "$dst\$dir"
    
    Write-Output "Working on directory $dir"
    
    if ( $TestPath -eq $true){
        
        Write-Output "Directory $dst\$dir exists",''

        # Walk files in folder
        ForEach ($file in ls $src\$dir)
        {
            Write-Output "Working on file $file"

            # Check whether file exists
            $TestPath = Test-Path $dst\$dir\$file
            
            if ( $TestPath -eq $true){
            
                # Do nothing if file exists
                Write-Output "File $dst\$dir\$file already exists"
            
            } else {
                
                # Check for file at destination
                $TestPath = Test-Path $dst\$file
                if ( $TestPath -eq $true){
                    
                    # Move file between destination folders
                    Write-Output "File $dst\$file exists on destination"
                    Write-Output "Moving $file into $dir"
                    
                    if ($write -eq $true){
                        Move-Item $dst\$file $dst\$dir\$file
                    }
                }
            }
        }
        
    } else {
        # Create folder if there is no such one
        
        Write-Output "Creating new directory $dst\$dir"
        if ($write -eq $true){
            New-Item $dst\$dir -type directory
        }
    }


}

Write-Output '','Completed'