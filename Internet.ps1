function Connect-HomeWifi {
    netsh wlan connect name="Dobra robota wifi"
}
Export-ModuleMember -Function Connect-HomeWifi

function Connect-PhoneWifi {
    netsh wlan connect name="V30_Marcin"
}
Export-ModuleMember -Function Connect-PhoneWifi