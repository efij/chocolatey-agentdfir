# Rendered by scripts/update-choco.sh at release time.
$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# The release ships x64 and ARM64 zips; Chocolatey has one 64-bit slot, so pick
# by the machine's architecture. Each zip holds a single agentdfir.exe, which
# Chocolatey shims onto PATH from the tools directory.
$arch = $env:PROCESSOR_ARCHITEW6432
if (-not $arch) { $arch = $env:PROCESSOR_ARCHITECTURE }
if ($arch -eq 'ARM64') {
  $url = 'https://github.com/efij/AgentDFIR/releases/download/v4.0.0/agentdfir-v4.0.0-windows-arm64.zip'
  $sha = '9454ecfe787a8557fa9b779a2720ece32f4c5d8d99f7e1fa1e5ae2e90b950117'
} else {
  $url = 'https://github.com/efij/AgentDFIR/releases/download/v4.0.0/agentdfir-v4.0.0-windows-amd64.zip'
  $sha = '3149f3093a1aaae917c96206c7ea1f01321c4be267bf8439216bfd9bc34d4d44'
}

$packageArgs = @{
  packageName    = 'agentdfir'
  unzipLocation  = $toolsDir
  url64bit       = $url
  checksum64     = $sha
  checksumType64 = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs
