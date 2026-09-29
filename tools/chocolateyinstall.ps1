# Rendered by scripts/update-choco.sh at release time.
$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# The release ships x64 and ARM64 zips; Chocolatey has one 64-bit slot, so pick
# by the machine's architecture. Each zip holds a single agentdfir.exe, which
# Chocolatey shims onto PATH from the tools directory.
$arch = $env:PROCESSOR_ARCHITEW6432
if (-not $arch) { $arch = $env:PROCESSOR_ARCHITECTURE }
if ($arch -eq 'ARM64') {
  $url = 'https://github.com/efij/AgentDFIR/releases/download/v3.1.2/agentdfir-v3.1.2-windows-arm64.zip'
  $sha = '68e637b7be4a98c46c0ce8cd56ebc215ea9939a64ebc6f9d834759302023fa3e'
} else {
  $url = 'https://github.com/efij/AgentDFIR/releases/download/v3.1.2/agentdfir-v3.1.2-windows-amd64.zip'
  $sha = 'a4f00e9ee89c8783020da1cc944f481882ff492d44ba0e9f86416dbc4c0aec91'
}

$packageArgs = @{
  packageName    = 'agentdfir'
  unzipLocation  = $toolsDir
  url64bit       = $url
  checksum64     = $sha
  checksumType64 = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs
