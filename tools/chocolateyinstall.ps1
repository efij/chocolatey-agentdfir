# Rendered by scripts/update-choco.sh at release time.
$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# The release ships x64 and ARM64 zips; Chocolatey has one 64-bit slot, so pick
# by the machine's architecture. Each zip holds a single agentdfir.exe, which
# Chocolatey shims onto PATH from the tools directory.
$arch = $env:PROCESSOR_ARCHITEW6432
if (-not $arch) { $arch = $env:PROCESSOR_ARCHITECTURE }
if ($arch -eq 'ARM64') {
  $url = 'https://github.com/efij/AgentDFIR/releases/download/v4.5.0/agentdfir-v4.5.0-windows-arm64.zip'
  $sha = 'ccbe838afd994998dfea2e4ea7451c24aa98980ad52954967714465967ab9e04'
} else {
  $url = 'https://github.com/efij/AgentDFIR/releases/download/v4.5.0/agentdfir-v4.5.0-windows-amd64.zip'
  $sha = '965f31a29d4ac5cbdd9864b1a91d055c8f3b3df025b5b3d11f2a40febb2238d7'
}

$packageArgs = @{
  packageName    = 'agentdfir'
  unzipLocation  = $toolsDir
  url64bit       = $url
  checksum64     = $sha
  checksumType64 = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs
