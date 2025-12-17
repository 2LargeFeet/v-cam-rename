# Use 'Connect-Verkada -org_id 'verkada org id' -userName "verkada user" -Password' before running this script
# You can find the org id in Admin > API & Integrations
# The user you use will need site admin rights in the site with the cameras
#
# This script relies ont the verkada powershell module. Install it with 'Install-Module -Name verkadaModule'
#
# Once this command is run you can then run the renameCameras.ps1 script with the following command.
# ./renameCameras.ps1 -org_id "<Your Verkada Org ID>"

param (
    [string]$org_id
)

Import-Module verkadaModule

Import-Csv "cameraInfo.csv" | ForEach-Object {
    Set-VerkadaCameraName -camera_id $_.camera_id -camera_name $_.camera_name -org_id $org_id
}