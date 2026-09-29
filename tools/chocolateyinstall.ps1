# Rendered by scripts/update-choco.sh at release time.
$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# The release ships x64 and ARM64 zips; Chocolatey has one 64-bit slot, so pick
# by the machine's architecture. Each zip holds a single agentdfir.exe, which
# Chocolatey shims onto PATH from the tools directory.
$arch = $env:PROCESSOR_ARCHITEW6432
if (-not $arch) { $arch = $env:PROCESSOR_ARCHITECTURE }
if ($arch -eq 'ARM64') {
  $url = 'https://github.com/efij/AgentDFIR/releases/download/v3.1.1/agentdfir-v3.1.1-windows-arm64.zip'
  $sha = '3a3ee0dbd800aaa21b3dc17435adc8fee98976aa31c6f8583c2c806d5e1e2d64'
} else {
  $url = 'https://github.com/efij/AgentDFIR/releases/download/v3.1.1/agentdfir-v3.1.1-windows-amd64.zip'
  $sha = 'f733342b568aa156f30845db6b91b0168c94b381f9cbf25e4ed78139f8463b9e'
}

$packageArgs = @{
  packageName    = 'agentdfir'
  unzipLocation  = $toolsDir
  url64bit       = $url
  checksum64     = $sha
  checksumType64 = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs
