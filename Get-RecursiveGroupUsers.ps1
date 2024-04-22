connect-mggraph

function Get-RecursiveGroupUsers {
    param (
        [Parameter(Mandatory = $true)]
        [string]$GroupID,
        [Parameter(Mandatory = $true)]
        [string]$CSVFilePath
    )
    $UsersinGroup = Get-MgGroupTransitiveMember -GroupId "$groupID" -All -ErrorAction Stop | Where-Object { $_.AdditionalProperties.'@odata.type' -eq '#microsoft.graph.user' }
    Foreach ($user in $UsersinGroup)
    {
        get-mguser -UserId $user.id | Export-Csv -path "$CSVFilePath" -Append
    }   
}
#Examples of calling the function, GroupID is the Object ID of the group you want to recursively get the users from.
Get-RecursiveGroupUsers -GroupID "11111111-gggg-5555-asdf-455662234456" -CSVFilePath "C:\Temp\Group1.csv"
Get-RecursiveGroupUsers -GroupID "11111111-gggg-7777-asdf-455662234456" -CSVFilePath "C:\Temp\Group2.csv"
Get-RecursiveGroupUsers -GroupID "11111111-gggg-8888-asdf-455662234456" -CSVFilePath "C:\Temp\Group3.csv"
