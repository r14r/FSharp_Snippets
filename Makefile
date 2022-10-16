default:
	type Makefile


create-summaries:
	Get-ChildItem -Attributes Directory -Path src | ForEach-Object { Write-Host bin\create_summary.ps1 ("src\{0}" -f $_.Name) }


