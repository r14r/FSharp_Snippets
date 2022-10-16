Param (
    [Parameter(Position=0)] [string]$folder = "-"
)


if ($folder -ne "-") {

	$outfile="${folder}.md"
	
    Write-Host "Create Summary for folder $folder in $outfile"

	if (Test-Path $outfile) {
		Remove-Item $outfile
	}
	New-Item $outfile

	Get-ChildItem -Recurse *.fs* -Path $folder		| `
	ForEach-Object {
		$name = $_.Name

        Write-Host $name
		
		Add-Content $outfile "### [$name]($name)"
		Add-Content $outfile "``````"
		Get-Content $_.Fullname | Add-Content $outfile
		Add-Content $outfile "``````"
		Add-Content $outfile ""
	}
}
