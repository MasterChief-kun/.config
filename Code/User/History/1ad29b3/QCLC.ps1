param(
    # Number of containers to start
    [Int32]$containers = 1,

    #Port to start mapping ports from
    [Int32]$startPort = 55555,
    [string]$action = ""
    )

$Command = Get-Content -Path ./DockerCommand.txt -TotalCount 1

if(!$Command) {
    $Command = Read-Host "Enter command to use for starting docker container(s)[%n for container number, %p for container port]: "
    $Command | Out-File -FilePath ./DockerCommand.txt
}

if($action -eq "start") {
    $tempContainers = $containers

    while ($tempContainers -ne 0) {
        $containerNumber = $containers - $tempContainers
        $tempCommand = $Command

        $tempCommand.Replace("%n", $containerNumber)
        $tempCommand.Replace("%p", $startPort + $containerNumber)
        $tempCommand
        #Invoke-Expression $tempCommand
        $tempContainers = $tempContainers - 1
    }
}
