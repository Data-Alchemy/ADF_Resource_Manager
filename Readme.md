
# ADF Resource Manager

## Solution Diagrams

![deployment-diagram]

## Tool Usage

### Setup Instructions
1. Clone repo (`git clone`)
2. Create your feature branch (`git checkout -b feature/fooBar`)
3. Add your id.json file to the credentials folder if deploying from your local machine (its part of the gitignore so if you commit back to repo should be excluded)

    example:
    ```
    {
        "service_pricipal":"",
        "client_secret":"",
        "tenant":""
    }
    ```

4. Add file to your git environment (`git add *`) 
5. Commit your changes (`git commit -am 'What i am planning to execute and why'`)
6. Push to the branch (`git push origin feature/fooBar`)
7. Create a new Pull Request


### Az cli Overview

The Azure command-line interface (Azure CLI) is a set of commands used to create and manage Azure resources. The Azure CLI is available across Azure services and is designed to get you working quickly with Azure, with an emphasis on automation.

`az cli` comes with several built-in commands. 
More information can be found about this tool on the following [Microsoft documentation link](https://learn.microsoft.com/en-us/cli/azure/resource?view=azure-cli-latest#az-resource-create)

### Basic Syntax 
az cli
```
az resource create
Create a resource.

az resource delete
Delete a resource.

az resource invoke-action
Invoke an action on the resource.

az resource link
Manage links between resources.

az resource link create
Create a new link between resources.

az resource link delete
Delete a link between resources.

az resource link list
List resource links.

az resource link show
Gets a resource link with the specified ID.

az resource link update
Update link between resources.

az resource list
List resources.

az resource lock
Manage Azure resource level locks.

az resource lock create
Create a resource-level lock.

az resource lock delete
Delete a resource-level lock.

az resource lock list
List lock information in the resource-level.

az resource lock show
Show the details of a resource-level lock.

az resource lock update
Update a resource-level lock.

az resource move
Moves resources from one resource group to another(can be under different subscription).

az resource show
Get the details of a resource.

az resource tag
Tag a resource.

az resource update
Update a resource.

az resource wait
Place the CLI in a waiting state until a condition of a resources is met.
   ```

[deployment-diagram]: https://lucid.app/publicSegments/view/2d06c63f-a0ef-445f-a0e7-f9cde79ccfcb/image.png




authors = ["sebastian hansen <sebastian.hansen@dataalchemy.dev>"]