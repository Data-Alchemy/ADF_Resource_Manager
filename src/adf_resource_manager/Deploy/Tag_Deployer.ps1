
#########################################################

#Initialization

#######################################

# Pass parameter or use default value #
param($Resource_Name,$Tags)

$Default_Resource_Name = "vdwsemantictest"
$Default_Tags = "Owner=Data_Engineering Cost_Center="

#######################################

If ($Resource_Name -eq $null){$Resource_Name = $Default_Resource_Name}

If ($Tags -eq $null){

	$Tag_file = (Get-Content .\src\adf_resource_manager\Build\tags\tag.json | ConvertFrom-Json)
	$tag_iterator =foreach ($info in $Tag_file.PSObject.Properties){$info.Name+'='+$info.Value}
	$tag_data = [String]::Join(" ",($var))

	If (
		$Tag_file.Count -eq 0) {$Tags = $Default_Tags} else {$Tags = $tag_data}
	}

$Split_Tags = $($Tags -split " ")

# Get Credentials #
$client_id =  (Get-Content src\adf_resource_manager\Build\credentials\id.json | ConvertFrom-Json).service_principal 
$secret = (Get-Content src\adf_resource_manager\Build\credentials\id.json | ConvertFrom-Json).client_secret #| ConvertTo-SecureString -AsPlainText -Force
$tenant = (Get-Content src\adf_resource_manager\Build\credentials\id.json | ConvertFrom-Json).tenant

# login #

az login --service-principal -u $client_id -p $secret --tenant $tenant
az config set extension.use_dynamic_install=yes_without_prompt

#########################################################

# deploy tags #

$Resource_Result_Set = (az resource list --query "[?name=='$Resource_Name']" | ConvertFrom-Json)

if($Resource_Result_Set.Count -eq 0)
	{echo "Resource Does Not exist"} else {echo "Resource $Resource_Name exists starting tag update"}
$Resource_Result_Set | foreach{az resource tag --tags $Split_Tags --ids $_.Id}
