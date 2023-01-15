<#
    Usage Guide for the monke man

    When the script is ran for the first time, it'll ask for a command this will be the command you normally
    run to start containers except the name should have a "%n" appended to it, to make it unique, And the
    port should be replaced by "%p". Eg:- `docker run --name vdms_%n -p %p:%p vdms:latest`. This command
    will be stored for future use in `DockerCommand.txt`

    Start action

    `./batchDocker.ps1 -action start -containers 10 -startPort 55555`
    Creates 10 containers using the earlier stored command.

    Stop action

    `./batchDocker.ps1 -action stop -name vdms`
    Stops all batch created containers. Only needs to be passed the common string between all of the
    container names.

    Delete action

    `./batchDocker.ps1 -action delete -name vdms`
    Deletes all batch created containers. Only needs to be passed the common string between all of the
    container names.
#>


param(
    # Number of containers to start
    [Int32]$containers = 1,

    #Port to start mapping ports from
    [Int32]$startPort = 55555,

    #Action to execute
    [string]$action = "",

    #Name of the containers (for batch delete and stop),
    [string]$name = "batchContainers"
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

        $tempCommand = $tempCommand.Replace("%n", $containerNumber).Replace("%p", $startPort + $containerNumber)
        #$tempCommand
        Invoke-Expression $tempCommand
        $tempContainers = $tempContainers - 1
    }
}
elseif($action -eq "stop") {
    $tempContainers = $containers

    $stopCommand = 'sudo docker stop $(sudo docker ps -aq --filter="name='+ $name +'*")'

    Invoke-Expression $stopCommand
}
elseif($action -eq "delete") {
    $tempContainers = $containers

    $deleteCommand = 'sudo docker rm $(sudo docker stop $(sudo docker ps -aq --filter="name='+ $name +'*"))'

    Invoke-Expression $deleteCommand
}
