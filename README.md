# chocolatey-agentdfir

Chocolatey package source for [AgentDFIR](https://github.com/efij/AgentDFIR).

Do not edit by hand. The AgentDFIR release workflow renders `agentdfir.nuspec`
and `tools/chocolateyinstall.ps1` from `scripts/chocolatey/` in the main
repository for every release, pushes the package to the community feed, and
commits the rendered source here so the published package is auditable.

```powershell
choco install agentdfir
```

The install script downloads the signed release zip from the GitHub release
and verifies its SHA-256 against the value rendered at release time.
