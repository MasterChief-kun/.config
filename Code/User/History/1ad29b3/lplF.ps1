parameter(
    # Number of containers to start
    [Int32]$containers,

    #Port to start mapping ports from
    [Int32]$startPort = 55555
    )

$Command = Get-Content -Path ./DockerCommand.txt -TotalCount 1

if(!$Command) {
    $Command = Read-Host "Enter command to use for starting docker container(s)[%n for container number, %p for container port]: "
    $Command | Out-File -FilePath ./DockerCommand.txt
}


