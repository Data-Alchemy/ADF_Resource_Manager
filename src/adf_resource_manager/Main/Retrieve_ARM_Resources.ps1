param($Resource_Name,$Tags)
$FormatEnumerationLimit = -1
#########################################################

#Initialization

#######################################

# Pass parameter or use default value #


$Default_Resource_Name = ""
$Default_Tags = "Owner=Data_Engineering Cost_Center="
$Output_Base_Path = ".\src\adf_resource_manager\Retrieve\Existing_Resources"
$Credential_Path = ".\src\adf_resource_manager\Main\credentials\id.json"
#######################################


# Get Credentials #
$client_id =  (Get-Content $Credential_Path | ConvertFrom-Json).service_principal 
$secret = (Get-Content $Credential_Path | ConvertFrom-Json).client_secret 
$tenant = (Get-Content $Credential_Path | ConvertFrom-Json).tenant


# login #

az login --service-principal -u $client_id -p $secret --tenant $tenant
az config set extension.use_dynamic_install=yes_without_prompt

#########################################################


$Resource_Result_Set = (az resource list | ConvertFrom-Json)
$resource_archive_path = ($Resource_Result_Set).type -replace('Microsoft.','') -replace('/','\')| sort -descending | Get-Unique
$resource_archive_path | foreach{
	# check if artifact type exists if not create its folder #
	If(-NOT (Test-Path "$Output_Base_Path\$_")){
		echo "Creating New Artifact Path : Output_Base_Path\$_" 
		mkdir "$Output_Base_Path\$_"}
	}

	$Resource_Result_Set | foreach{
	$Resource_Object_Name = $_.id.split('/')[-1]
	$output_path =  ("$Output_Base_Path\"+$_.type -replace('Microsoft.','') -replace('/','\'))+'\'+$Resource_Object_Name+'.json'
	echo "output to path $output_path"
	az resource show --id $_.id | Out-File -FilePath $output_path
}






