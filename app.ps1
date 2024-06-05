
param(
     [Parameter()]
     [string]$APP_NAME,

     [Parameter()]
     [string]$STATUS
 )
$APP_NAME = $APP_NAME.ToLower()
$STATUS = $STATUS.ToLower()
Write-Host "Service Name is : " $APP_NAME
Write-Host "Monitoring will be : " $STATUS

$APP_LIST = "Test.csv"
$CURRNET_STATUS = Select-String -Pattern "$APP_NAME" -Path "$APP_LIST"
$CURRNET_STATUS = $CURRNET_STATUS -split ":"
$CURRNET_STATUS1 = $CURRNET_STATUS[-1]
$CURRNET_APP2 = $CURRNET_STATUS[-2]

Write-Host "current Status $CURRNET_STATUS1 "
Write-Host "current APP Name $CURRNET_APP2 "

if ( ($CURRNET_STATUS1 -eq $STATUS) ){
    Write-Host "Currently App $APP_NAME is already $STATUS"
} elseif ( ($STATUS -eq 'disable') ) {
	Write-Host "Current App $APP_NAME is disable, you have selected to enable it"
    Invoke-WebRequest -Uri www.google.com | Select-Object StatusCode
    (Get-Content $APP_LIST) -replace "${CURRNET_APP2}:${CURRNET_STATUS1}", "${CURRNET_APP2}:disable" | Set-Content $APP_LIST
} elseif ( ($STATUS -eq 'enable') ) {
    Write-Host "Current App $APP_NAME is enable. you have selected to disable it"
    Invoke-WebRequest -Uri www.gmail.com | Select-Object StatusCode
    (Get-Content $APP_LIST) -replace "${CURRNET_APP2}:${CURRNET_STATUS1}", "${CURRNET_APP2}:enable" | Set-Content $APP_LIST
} else {
    Write-Host "Invalid selection please provide app_name followed by enable or disable"}
