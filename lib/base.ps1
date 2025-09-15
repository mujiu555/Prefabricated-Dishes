
$env:PSModulePath     = $PWD.ToString()+"\lib"
#$HOME                = $PWD.ToString()+"\home"
remove-variable -force HOME
$HOME                 = $PWD.ToString()+"\home"

$env:XDG_HOME_DIR     = $HOME
$env:XDG_DATA_HOME    = $env:XDG_HOME_DIR+"\.local\share"
$env:XDG_CONFIG_HOME  = $env:XDG_HOME_DIR+"\.config"
$env:XDG_STATE_HOME   = $env:XDG_HOME_DIR+"\.local\state"
$env:HOME             = $HOME
$env:EDITOR           = 'nvim'
$PROFILE              = $HOME+"\profile.ps1"

Import-Module -Name libLoad -Verbose

if ((get-item $PWD).Name.Equals("lib")) {
  cd ..
  AddPathAuto $args
  AddEnvAuto $args
}

$_ = AddPathAuto $args
$_ = AddEnvAuto $args
