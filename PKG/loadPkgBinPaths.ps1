
function LoadPath{
    
  param ( 
    $pkgpath
  )
  $pkgs = (Get-ChildItem (get-item $pkgpath).FullName) | Where-Object {$_.Extension.Equals(".path")}
  $RelativeBinPath = (New-Object 'object[]' 0)
  $ExternalPath = (New-Object 'object[]' 0)

  #
  Set-Location $pkgpath
  

  foreach ($var in $pkgs){
    $pathinfo = ((type $var.ToString()) -split "\n") # | Where-Object Length -GT 0
    foreach ($path in $pathinfo){
      $RelativeBinPath = @($path -replace "/", "\") + $RelativeBinPath
    }
  }
  foreach($var in $RelativeBinPath){
    $ExternalPath = @((get-item $PWD).FullName + "\" + $var)+$ExternalPath
  }
  Set-Location ..

  return $ExternalPath
}

function main{
  param (
    $args
  )
  $ExternalPath = (New-Object 'object[]' 0)

  Set-Location $PWD"\Store"
  $PkgModules = (Get-ChildItem $PWD)

  foreach ($var in $PkgModules){
    $tmp = (LoadPath $var)
    foreach ($path in $tmp){
      $ExternalPath = @($path)+$ExternalPath
    }
  }

  cd ..

  Return $ExternalPath
}

if ((get-item $PSScriptRoot).Name.Equals("PKGs")) {
  return (main $args)
}
