class Prompt {
    static Colours() {
        [enum]::GetValues([System.ConsoleColor]) | ForEach-Object { Write-Host $_ -ForegroundColor $_ }
    }

    static Git() {
        if (Test-Path -Path '.git') {
            $Status = git status --branch --short
            $Branch = [regex]::Match($Status, '(?<=[#][#]).*?(?=[...]).*?').Value.Trim()
            $HasChanged = ($Status | Measure-Object).Count -gt 1
            $Prompt = if ($HasChanged) { "`u{2716}" } else { "`u{2714}" }
            Write-Host "${Prompt} (" -NoNewline
            Write-Host $Branch -NoNewline -ForegroundColor $(if ($HasChanged) { 'Red' } else { 'Green' })
            Write-Host ') ' -NoNewline
        }
    }
}

function Show-DF_Prompt {
    Param(
        [Switch]
        $OhMyPosh
    )
    if ($OhMyPosh -and (Test-DF_Command -Name 'oh-my-posh')) {
        oh-my-posh init pwsh | Invoke-Expression
    }
    else {
        $([Prompt]::Git()) + "$($ExecutionContext.SessionState.Path.CurrentLocation)$('>' * (${NestedPromptLevel} + 1)) "
    }
}
