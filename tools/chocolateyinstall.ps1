# Rendered by scripts/update-choco.sh at release time.
$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# The release ships x64 and ARM64 zips; Chocolatey has one 64-bit slot, so pick
# by the machine's architecture. Each zip holds a single agentdfir.exe, which
# Chocolatey shims onto PATH from the tools directory.
$arch = $env:PROCESSOR_ARCHITEW6432
if (-not $arch) { $arch = $env:PROCESSOR_ARCHITECTURE }
if ($arch -eq 'ARM64') {
  $url = 'https://github.com/efij/AgentDFIR/releases/download/v2.7.0/agentdfir-v2.7.0-windows-arm64.zip'
  $sha = '031b6c30ed2940cc6b4c5c177ac10d56a027d957fef8046df3ad27320d29f844'
} else {
  $url = 'https://github.com/efij/AgentDFIR/releases/download/v2.7.0/agentdfir-v2.7.0-windows-amd64.zip'
  $sha = 'f86e8c9dd93d7fcb1bef680c45440b5746f5159cffe488de21ee59434744c594'
}

$packageArgs = @{
  packageName    = 'agentdfir'
  unzipLocation  = $toolsDir
  url64bit       = $url
  checksum64     = $sha
  checksumType64 = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs
