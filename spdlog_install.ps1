cd libs\spdlog 

if ( -not (Test-Path -Path 'lib' -PathType Container) ) 
{ 
    md lib
}

copy build\Debug\spdlogd.lib           lib\spdlog_x64_d.lib 
copy build\Release\spdlog.lib          lib\spdlog_x64.lib 
copy build\spdlog.dir\Debug\spdlog.pdb lib\spdlog.pdb

dir lib

cd ..\..

