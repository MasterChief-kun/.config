$Command = Get-Content -Path ./DockerCommand.txt -TotalCount 1

if(!$Command) {
    $Command = Read-Host "Enter command to use for starting docker container(s)[%n for container number, %p for container port]: "
    
}


