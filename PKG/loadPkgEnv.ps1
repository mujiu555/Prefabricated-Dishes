
function LoadPS{

  param(
    $pkgpath
  )
  $pkgs = (Get-ChildItem (get-item $pkgpath).FullName) | Where-Object {$_.Extension.Equals(".ps1")}
  $EnvInfoList = (New-Object 'object[]' 0)
  $ExternalPath = (New-Object 'object[]' 0)

  Set-Location $pkgpath

  foreach ($var in $pkgs){
    . $var
  }

  Set-Location ..
}

function LoadEnv{
    
  param ( 
    $pkgpath
  )

  $pkgs = (Get-ChildItem (get-item $pkgpath).FullName) | Where-Object {$_.Extension.Equals(".env")}
  [Object[][]]$EnvInfoList = (New-Object 'object[]' 0)
  [Object[][]]$ExternalPath = (New-Object 'object[]' 0)

  #
  Set-Location $pkgpath

  foreach ($var in $pkgs){
    $envinfo = ((type $var.ToString()) -split "\n") | Where-Object Length -GT 0
    foreach ($line in $envinfo){
      $env = ($line -split "=")
      [string]$envname = $env[0]
      [string]$envValue = $env[1] -replace '\$CD', $PWD.ToString()
      
      
      switch($envname[0]){
        ('!')[0] {$EnvInfoList = $EnvInfoList + ,@($envname.subString(1), $envValue, 1)}
        ('@')[0] {$EnvInfoList = $EnvInfoList + ,@($envname.subString(1), $envValue, 2)}
        ('\')[0] {$EnvInfoList = $EnvInfoList + ,@($envname.subString(1), $envValue, 3)}
        Default {$EnvInfoList = $EnvInfoList + ,@($envname, $envValue, 0)}
      }
      # ! override
      # @ using original
      # ' ' append
    }
  }
  
  foreach($var in $EnvInfoList){
    # substitude $* by ...
    while($var[1] -match '%.*%'){
      [string]$SubStitudeVal = $Matches.0
      [string]$SubStitudeName = $SubStitudeVal.Substring(1,$SubStitudeVal.Length-2)
      foreach($val in $EnvInfoList){
        if($val[0].Equals($substitudeName)){
          $var[1] = $var[1] -replace $SubStitudeVal,$val[1]
        }
      }
    }

    $ExternalPath = $ExternalPath + ,$var
  }
  Set-Location ..

  return ,$ExternalPath
}

function main{
  param (
    $args
  )
  [Object[][]]$ExternalPath = (New-Object 'object[]' 0)

  Set-Location $PWD"\Store"
  $PkgModules = (Get-ChildItem $PWD)

  foreach ($var in $PkgModules){
    $tmp = (LoadEnv $var)
    foreach ($path in $tmp){
      $ExternalPath = $ExternalPath + ,$path
    }
  }

  cd ..

  Return ,$ExternalPath
}

if ((get-item $PSScriptRoot).Name.Equals("PKGs")) {
  return (main $args)
}
