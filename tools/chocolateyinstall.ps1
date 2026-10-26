# Rendered by scripts/update-choco.sh at release time.
$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# The release ships x64 and ARM64 zips; Chocolatey has one 64-bit slot, so pick
# by the machine's architecture. Each zip holds a single agentdfir.exe, which
# Chocolatey shims onto PATH from the tools directory.
$arch = $env:PROCESSOR_ARCHITEW6432
if (-not $arch) { $arch = $env:PROCESSOR_ARCHITECTURE }
if ($arch -eq 'ARM64') {
  $url = 'https://github.com/efij/AgentDFIR/releases/download/v5.0.0/agentdfir-v5.0.0-windows-arm64.zip'
  $sha = '32b733cfed3608a903e7333905dea1b120217542080471b37ba2170341059a70'
} else {
  $url = 'https://github.com/efij/AgentDFIR/releases/download/v5.0.0/agentdfir-v5.0.0-windows-amd64.zip'
  $sha = 'ed8ef7c8aece5ad60207f827c48790114713c2c92be84124a38d1a5e02ce3aa4'
}

$packageArgs = @{
  packageName    = 'agentdfir'
  unzipLocation  = $toolsDir
  url64bit       = $url
  checksum64     = $sha
  checksumType64 = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs
