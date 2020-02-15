# wise.external.learn.premake

https://github.com/premake/premake-core/wiki/

- 위 내용을 따라간다.
- 샘플 프로젝트를 만들어 테스트 한다. 
- 적절한 시점마다 커밋하면서 진행한다. 



# 읽기 



## what is premake? 

- 스크립트에서 프로젝트 파일을 생성하는 도구
- lua 기반 
- 예제: premake5.lua 파일 

```lua
workspace "MyWorkspace"
   configurations { "Debug", "Release" }

project "MyProject"
   kind "ConsoleApp"
   language "C++"
   files { "**.h", "**.cpp" }

   filter { "configurations:Debug" }
      defines { "DEBUG" }
      symbols "On"

   filter { "configurations:Release" }
      defines { "NDEBUG" }
      optimize "On"
```

- 실행 세션 

```
$ premake5 vs2012
Building configurations...
Running action 'vs2012'...
Generating MyWorkspace.sln...
Generating MyProject.vcxproj...
Generating MyProject.vcxproj.user...
Done.
```



### sample1 

하위 폴더에 작성 

- main.cpp 파일 

```lua
workspace "sample1"
   configurations { "Debug", "Release" }

project "sample1"
   kind "ConsoleApp"
   language "C++"
   files { "**.h", "**.cpp" }

   filter { "configurations:Debug" }
      defines { "DEBUG" }
      symbols "On"

   filter { "configurations:Release" }
      defines { "NDEBUG" }
      optimize "On"
```



```
PS E:\wisemountain\wise.external\learn\premake\sample1> premake5 vs2019
Building configurations...
Running action 'vs2019'...
Generated sample1.sln...
Generated sample1.vcxproj...
Done (46ms).
```



sample1.sln 빌드 후 실행. 부드럽게 진행된다. 





