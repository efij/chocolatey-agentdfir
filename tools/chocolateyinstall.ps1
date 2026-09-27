# Rendered by scripts/update-choco.sh at release time.
$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# The release ships x64 and ARM64 zips; Chocolatey has one 64-bit slot, so pick
# by the machine's architecture. Each zip holds a single agentdfir.exe, which
# Chocolatey shims onto PATH from the tools directory.
$arch = $env:PROCESSOR_ARCHITEW6432
if (-not $arch) { $arch = $env:PROCESSOR_ARCHITECTURE }
if ($arch -eq 'ARM64') {
  $url = 'https://github.com/efij/AgentDFIR/releases/download/v2.6.0/agentdfir-v2.6.0-windows-arm64.zip'
  $sha = '6cafafb05dc8f3848df65e810a16f26772206d069adf72cf57514c42614f7771'
} else {
  $url = 'https://github.com/efij/AgentDFIR/releases/download/v2.6.0/agentdfir-v2.6.0-windows-amd64.zip'
  $sha = 'd10a461746c70bfec428d9ef4b9cac619da793f22418c7731b8c26d495adb75f'
}

$packageArgs = @{
  packageName    = 'agentdfir'
  unzipLocation  = $toolsDir
  url64bit       = $url
  checksum64     = $sha
  checksumType64 = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs
