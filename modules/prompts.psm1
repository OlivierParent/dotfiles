function PromptColors {
    [enum]::GetValues([System.ConsoleColor]) | ForEach-Object { Write-Host $_ -ForegroundColor $_ }
}

function PromptGit {
    if (Test-Path -Path '.git') {
        $Branch = (git status | Select-Object -First 1) -replace 'On branch|\s'
        $HasChanged = (git status --branch --short | Measure-Object).Count -gt 1
        $Prompt = if ($HasChanged) { "`u{2716}" } else { "`u{2714}" }
        Write-Host "${Prompt} (" -NoNewline
        Write-Host $Branch -NoNewline -ForegroundColor $(if ($HasChanged) { 'Red' } else { 'Green' })
        Write-Host ') ' -NoNewline
    }
}

function Prompt {
    $(PromptGit) + "$($ExecutionContext.SessionState.Path.CurrentLocation)$('>' * (${NestedPromptLevel} + 1)) "
}
