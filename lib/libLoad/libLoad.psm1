function AddPathAuto{
  param(
    $args
  )

  (cd PKGs)
  $ExternalPaths=(.\loadPkgBinPaths.ps1)
  cd ..

  foreach($var in $ExternalPaths){
    $env:Path = $var + ";" + $env:Path
  }
  return $env:Path
}

Function AddEnvAuto{

  param(
    $args
  )
  (cd PKGs)
  [Object[]]$ExternalPaths=(.\loadPkgEnv.ps1)
  cd ..
  $ExternalPaths = $ExternalPaths | Where-Object { $_ -ne $null }

  foreach($var in $ExternalPaths){
    
    $name = "Env:" + $var[0]
    $val = ""
    if(Test-Path -Path "$name" -PathType Leaf){
      switch($var[2]){
      1 {$val = $var[1]}
      2 {$val = (Get-Item $name).Value}
      "null" {$val = $var[2]}
      Default {$val = ($var[1] + ";" + (Get-Item $name).Value)}
      }
    }else{
      $val = $var[1]
    }

    if(Test-Path -Path "$name" -PathType Leaf){
      Set-Item -Path $name -Value $val
    }else{
      New-Item -Path $name -Value $val -Force
    }

    
  }
}
