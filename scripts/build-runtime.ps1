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
    }
    finally
    {
        Pop-Location
    }
}

function Install-Osx-Runtime
{
    Write-Output "Installing .NET runtime..."
    & $scriptsRoot/dotnet-install.sh -v $dotnetVersion -i "$runtimeRoot/dotnet" --arch x64 --os osx --no-path

    Write-Output "Installing Node.js runtime..."
    mkdir -p "$runtimeRoot/node"
    & $scriptsRoot/install-node.sh --version=$nodejsVersion --platform=darwin --prefix="$runtimeRoot/node" --arch=x64 -f
}

function Install-Cdk
{
    Write-Output "Installing CDK module..."
    npm install --no-save --prefix "$runtimeRoot/node" "aws-cdk@$cdkVersion"
}

if ($runtime = "osx")
{
    Install-Osx-Runtime
}

Install-Cdk

Zip-Runtime
