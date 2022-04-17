#!/usr/bin/env pwsh

param(
    [String] $runtime
)

if ($runtime -eq "osx")
{
    sudo apt-get install -y npm zip curl
}

if ($runtime -eq "win")
{
    choco install -y nodejs zip curl
}
