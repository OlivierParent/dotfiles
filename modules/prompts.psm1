class Prompt {
    static Colours() {
        [enum]::GetValues([System.ConsoleColor]) | ForEach-Object { Write-Host $_ -ForegroundColor $_ }
    }

    static Git() {
        if (Test-Path -Path '.git') {
            $Branch = (git status | Select-Object -First 1) -replace 'On branch|\s'
            $HasChanged = (git status --branch --short | Measure-Object).Count -gt 1
            $Prompt = if ($HasChanged) { "`u{2716}" } else { "`u{2714}" }
            Write-Host "${Prompt} (" -NoNewline
            Write-Host $Branch -NoNewline -ForegroundColor $(if ($HasChanged) { 'Red' } else { 'Green' })
            Write-Host ') ' -NoNewline
        }
    }
}

function Show-DF_Prompt {
    $([Prompt]::Git()) + "$($ExecutionContext.SessionState.Path.CurrentLocation)$('>' * (${NestedPromptLevel} + 1)) "
}
