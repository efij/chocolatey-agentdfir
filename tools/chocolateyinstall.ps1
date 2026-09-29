# Rendered by scripts/update-choco.sh at release time.
$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# The release ships x64 and ARM64 zips; Chocolatey has one 64-bit slot, so pick
# by the machine's architecture. Each zip holds a single agentdfir.exe, which
# Chocolatey shims onto PATH from the tools directory.
$arch = $env:PROCESSOR_ARCHITEW6432
if (-not $arch) { $arch = $env:PROCESSOR_ARCHITECTURE }
if ($arch -eq 'ARM64') {
  $url = 'https://github.com/efij/AgentDFIR/releases/download/v3.1.0/agentdfir-v3.1.0-windows-arm64.zip'
  $sha = '3bfd719ac4932836bf0bf9213bb3fef1d7198c9df99b52d695cdaead311e9b16'
} else {
  $url = 'https://github.com/efij/AgentDFIR/releases/download/v3.1.0/agentdfir-v3.1.0-windows-amd64.zip'
  $sha = '897a395f3d6b4789a82aa5673a9be39b92731656422009116e4ae5671c098c5d'
}

$packageArgs = @{
  packageName    = 'agentdfir'
  unzipLocation  = $toolsDir
  url64bit       = $url
  checksum64     = $sha
  checksumType64 = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs
