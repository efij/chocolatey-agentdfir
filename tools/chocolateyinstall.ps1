# Rendered by scripts/update-choco.sh at release time.
$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# The release ships x64 and ARM64 zips; Chocolatey has one 64-bit slot, so pick
# by the machine's architecture. Each zip holds a single agentdfir.exe, which
# Chocolatey shims onto PATH from the tools directory.
$arch = $env:PROCESSOR_ARCHITEW6432
if (-not $arch) { $arch = $env:PROCESSOR_ARCHITECTURE }
if ($arch -eq 'ARM64') {
  $url = 'https://github.com/efij/AgentDFIR/releases/download/v2.5.2/agentdfir-v2.5.2-windows-arm64.zip'
  $sha = 'c56b10c8e19c55e24e11e0f2bdde45cbf704186ad38045f7a0ab0f68de1d22a9'
} else {
  $url = 'https://github.com/efij/AgentDFIR/releases/download/v2.5.2/agentdfir-v2.5.2-windows-amd64.zip'
  $sha = '44c5782e698291f53e0bf3a39f4f0d420b3f8eb5dc795a11574d94582ef9bed4'
}

$packageArgs = @{
  packageName    = 'agentdfir'
  unzipLocation  = $toolsDir
  url64bit       = $url
  checksum64     = $sha
  checksumType64 = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs
