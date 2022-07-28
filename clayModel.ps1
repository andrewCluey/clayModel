$request = Get-Content request.JSON | ConvertFrom-Json

# expand source Compartment IP
$srcCompartment = $request.sourceCompartment

$srcJSON = Get-Content "$srcCompartment.json" | ConvertFrom-Json
$srcList = $srcJSON.sourceIP

# expand destination compartment IP
$dstCompartment = $request.destinationCompartment

$dstJSON = Get-Content "$srcCompartment.json" | ConvertFrom-Json
$dstList = $srcJSON.sourceIP

#Get requested Ports
$reqPort = $request.port

# build rule to apply
$obj = New-Object -TypeName psobject
$obj | Add-Member -MemberType NoteProperty -Name type "ruleToApply"
$obj | Add-Member -MemberType NoteProperty -Name source -Value $srcList
$obj | Add-Member -MemberType NoteProperty -Name destination -Value $dstList
$obj | Add-Member -MemberType NoteProperty -Name port -Value $reqPort
$obj


$obj | ConvertTo-Json | out-file ./ruleToApply.json
