# Rendered by scripts/update-choco.sh at release time.
$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# The release ships x64 and ARM64 zips; Chocolatey has one 64-bit slot, so pick
# by the machine's architecture. Each zip holds a single agentdfir.exe, which
# Chocolatey shims onto PATH from the tools directory.
$arch = $env:PROCESSOR_ARCHITEW6432
if (-not $arch) { $arch = $env:PROCESSOR_ARCHITECTURE }
if ($arch -eq 'ARM64') {
  $url = 'https://github.com/efij/AgentDFIR/releases/download/v3.0.0/agentdfir-v3.0.0-windows-arm64.zip'
  $sha = 'b15a81d3b51ee919f5dfa2ad024e79908299fd1a945ef81b5b15a4d9660c4a47'
} else {
  $url = 'https://github.com/efij/AgentDFIR/releases/download/v3.0.0/agentdfir-v3.0.0-windows-amd64.zip'
  $sha = '362c5f55acbf77ea3133812643567b710f741db035b8aa8beede2e1dd445e13b'
}

$packageArgs = @{
  packageName    = 'agentdfir'
  unzipLocation  = $toolsDir
  url64bit       = $url
  checksum64     = $sha
  checksumType64 = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs
