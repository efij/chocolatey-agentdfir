# Rendered by scripts/update-choco.sh at release time.
$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# The release ships x64 and ARM64 zips; Chocolatey has one 64-bit slot, so pick
# by the machine's architecture. Each zip holds a single agentdfir.exe, which
# Chocolatey shims onto PATH from the tools directory.
$arch = $env:PROCESSOR_ARCHITEW6432
if (-not $arch) { $arch = $env:PROCESSOR_ARCHITECTURE }
if ($arch -eq 'ARM64') {
  $url = 'https://github.com/efij/AgentDFIR/releases/download/v3.2.0/agentdfir-v3.2.0-windows-arm64.zip'
  $sha = '58d2fb7d07a3ebc2c24d83b6dd366e953af70916d5cdc01c3707d80256a8dff9'
} else {
  $url = 'https://github.com/efij/AgentDFIR/releases/download/v3.2.0/agentdfir-v3.2.0-windows-amd64.zip'
  $sha = '85ec4ce61f57d91bc71f6910c499727975841b78cf5e98db51e06778291d6c01'
}

$packageArgs = @{
  packageName    = 'agentdfir'
  unzipLocation  = $toolsDir
  url64bit       = $url
  checksum64     = $sha
  checksumType64 = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs
