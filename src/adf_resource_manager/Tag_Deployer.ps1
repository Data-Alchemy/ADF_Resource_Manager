
#########################################################

#Initialization

# Pass parameter or use default value #
param($Resource_Name,$Tags)
If ($Resource_Name -eq $null){$Resource_Name = 'vdwsemantictest'}
If ($Tags -eq $null){$Tags = "Owner=Data_Engineering Cost_Center="}
$Split_Tags = $($Tags -split " ")

# Get Credentials #
$client_id =  (Get-Content src\credentials\id.json | ConvertFrom-Json).service_principal 
$secret = (Get-Content src\credentials\id.json | ConvertFrom-Json).client_secret #| ConvertTo-SecureString -AsPlainText -Force
$tenant = (Get-Content src\credentials\id.json | ConvertFrom-Json).tenant

# login #

az login --service-principal -u $client_id -p $secret --tenant $tenant
az config set extension.use_dynamic_install=yes_without_prompt

#########################################################

# deploy tags #

$Resource_Result_Set = (az resource list --query "[?name=='$Resource_Name']" | ConvertFrom-Json)

if($Resource_Result_Set.Count -eq 0)
	{echo "Resource Does Not exist"} else {echo "Resource $Resource_Name exists starting tag update"}
$Resource_Result_Set | foreach{az resource tag --tags $Split_Tags --ids $_.Id}
