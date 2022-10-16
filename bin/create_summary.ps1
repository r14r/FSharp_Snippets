Param (
    [Parameter(Position=0)] [string]$inp = "src",
	[Parameter(Position=1)] [string]$out = "."
)


if ($out -ne "-") {

	$outfile="${out}.md"
	
	if (Test-Path $outfile) {
		Remove-Item $outfile
	}
	New-Item $outfile

	Get-ChildItem -Recurse *.fs* -Path $inp		| `
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
