
$env:PSModulePath     = $PWD.ToString()+"lib"
#$HOME                = $PWD.ToString()+"\home"
remove-variable -force HOME
$HOME                 = $PWD.ToString()+"home"

$env:XDG_HOME_DIR     = $PWD.ToString()+"home"
$env:XDG_DATA_HOME    = $PWD.ToString()+"home\.local\share"
$env:XDG_CONFIG_HOME  = $PWD.ToString()+"home\.config"
$env:XDG_STATE_HOME   = $PWD.ToString()+"home\.local\state"
$env:HOME             = $PWD.ToString()+"home"
$env:EDITOR           = 'nvim'
$PROFILE              = $PWD.ToSTring()+"home\profile.ps1"

$env:RUSTUP_DIST_SERVER = "https://mirrors.ustc.edu.cn/rust-static"
$env:RUSTUP_UPDATE_ROOT = "https://mirrors.ustc.edu.cn/rust-static/rustup"
$env:RUSTUP_HOME        = $PWD.ToString() + "PKGs\Store\PLE\RustUp"
$env:CARGO_HOME        = $PWD.ToString() + "PKGs\Store\PLE\Cargo"


Import-Module -Name libLoad -Verbose

if ((get-item $PWD).Name.Equals("lib")) {
  cd ..
  AddPathAuto $args
  AddEnvAuto $args
}

$_ = AddPathAuto $args
$_ = AddEnvAuto $args
