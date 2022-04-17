#!/usr/bin/env pwsh

param(
    [String] $runtime
)

$runtimeId = "games.cm.cme.runtime.$runtime"
$dotnetVersion = "6.0.101"
$nodejsVersion = "16.13.2"
$cdkVersion = "2.8.0"

$projectRoot = $(resolve-path "$PSScriptRoot/..")
$scriptsRoot = "$projectRoot/scripts"
$runtimesRoot = "$projectRoot/runtimes"
$runtimeRoot = "$runtimesRoot/$runtimeId"

function Zip-Runtime
{
    Push-Location $runtimesRoot

    try
    {
        zip -9 -r -q "$runtimeId.zip" $runtimeId
        (Get-FileHash "$runtimeId.zip" -Algorithm SHA256).Hash > "$runtimeId.sha256"
    }
    finally
    {
        Pop-Location
    }
}

function Install-Osx-Runtime
{
    Write-Output "Installing .NET runtime for OSX..."
    & $scriptsRoot/dotnet-install.sh -v $dotnetVersion -i "$runtimeRoot/dotnet" --arch x64 --os osx --no-path

    Write-Output "Installing Node.js runtime for OSX..."
    mkdir -p "$runtimeRoot/node"
    & $scriptsRoot/install-node.sh --version=$nodejsVersion --platform=darwin --prefix="$runtimeRoot/node" --arch=x64 -f
}

function Install-Win-Runtime
{
    Write-Output "Installing .NET runtime for Windows..."
    & $scriptsRoot/dotnet-install.ps1 -Version $dotnetVersion -InstallDir "$runtimeRoot/dotnet" -Architecture x64 -NoPath

    Write-Output "Installing Node.js runtime for Windows..."
    curl "https://nodejs.org/download/release/v$nodejsVersion/node-v$nodejsVersion-win-x64.zip" --output "node-v$nodejsVersion-win-x64.zip"
    unzip "node-v$nodejsVersion-win-x64.zip" -d "$runtimeRoot"

    mv "$runtimeRoot/node-v$nodejsVersion-win-x64" "$runtimeRoot/node"
}

function Install-Cdk
{
    Write-Output "Installing CDK module..."
    npm install --no-save --prefix "$runtimeRoot/node" "aws-cdk@$cdkVersion"
}

if ($runtime -eq "osx")
{
    Install-Osx-Runtime
}

if ($runtime -eq "win")
{
    Install-Win-Runtime
}

Install-Cdk

Zip-Runtime
