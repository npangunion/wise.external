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



## Skip 

- Getting Premake 
- Using Premake 
- Building Premake



## Getting Help 

- stackoverflow
- google group 

특별한 내용은 없다. 



## Your First Script 

sample1에서 계속 진행한다. 


### What's Going On Here? 

- Premake is Lua 
  - premake script는 루아 프로그램 
  - 각 키워드는 함수 형식을 사용 
    

```lua 
workspace("HelloWorld")
```
위는 "HelloWorld"를 아규먼트로 갖는 workspace 함수이다. 
다른 키워드로 보이는 것들도 모두 함수이다. 


## Workspaces and Projects 

### Workspaces

- solution in 비주얼 스튜디오 
- build 구성과 플래폼을 정의 
- define, include, path 등 정의 


### Projects

- 워크스페이스에 포함 
- 빌드 단위 (타겟을 정의) 

- kind 함수 
  

### Locations 

- 생성 폴더 지정 
- workspace와 project 개별로 지정 


```lua
workspace "MyWorkspace"
  configurations { "Debug", "Release" }
  location "build"

project "MyProject"
  location "build/MyProject"
```


### Scopes and Inheritance

- 세 계층 
  - global 
  - workspace 
  - project 

- defines 함수로 정의 


```lua
-- declare my workspace
workspace "MyWorkspace"
  defines { "WORKSPACE1" }

-- declare a project or two
project "MyProject"
  defines { "PROJECT" }

-- re-select my workspace to add more settings
project "*"
  defines { "WORKSPACE2" }  -- value is now { "WORKSPACE1", "WORKSPACE2" }

-- re-select the global scope
workspace "*"
```

함수 호출로 현재 범위를 선택. 


## Adding Source Files 

- files 함수 

```lua
files {
   "hello.h",  -- you can specify exact names
   "*.c",      -- or use a wildcard...
   "**.cpp"    -- ...and recurse into subdirectories
}
```
- **로 하위 폴더들을 뒤져서 추가한다
  - 강력하고 유용한 기능이다. 


위에서 {} 로 전달되는 내용이 아규먼트 목록이 된다고 하는데 문법이 잘 이해가 안 된다. 
print로 해보면 table로 출력된다. 


### Excluding Files 

- removefiles 함수 

```lua 
files { "**.c" }
removefiles { "tests/*.c" }
```

removefiles 함수도 **를 해석해서 재귀적으로 추가한다. 

## Linking 

- links 함수 

```lua 
links {"png", "zlib"}
```

- 동일 워크스페이스 내 프로젝트 참조 

```lua
workspace "MyWorkspace"

   project "MyLibraryProject"
      -- ...project settings here...

   project "MyExecutableProject"
      -- ...project settings here...
      links { "MyLibraryProject" }
```

- libdirs 함수 
  - proejct 선택 후 지정 
  - Configuration 별로는 어떻게 하지? 
    - 아마도 filter 함수를 사용하는 걸로 보인다. 
    - 그렇다. 

  - configuration과 플래폼을 모두 설정해야 하는 경우도 있다. 
    - 이것도 아마 필터 함수일 듯 싶다. 
    - 나중에 더 복잡한 구성을 만들어서 해본다. 
    - wise.external.libsodium.learn으로 해보자 

환경변수는 그대로 넘어간다. 그냥 문자열로 처리하기 때문에 가능하다. 
빌드 툴별로 다른 문자열을 줄 수 있어야 한다. 

filter와 libdirs는 연습을 통해 정확하게 확인해야 한다. 


## Configurations and Platforms 

### Bulid Configurations 

```lua 
workspace "HelloWorld"
   configurations { "Debug", "Release" }

   filter "configurations:Debug"
      defines { "DEBUG" }
      flags { "Symbols" }

   filter "configurations:Release"
      defines { "NDEBUG" }
      optimize "On"
```

### Platforms 


```lua
configurations { "Debug", "Release" }
platforms { "Win32", "Win64", "Xbox360" }

filter { "platforms:Win32" }
    system "Windows"
    architecture "x32"

filter { "platforms:Win64" }
    system "Windows"
    architecture "x64"

filter { "platforms:Xbox360" }
    system "Xbox360"
```


### Per-Project Configurations 

```lua
workspace "MyWorkspace"
    configurations { "Debug", "Release" }
    platforms { "Windows", "PS3" }

project "MyProject"
    removeplatforms { "PS3" }
```

또는 configurations {"Debug", "Release" } 형태로 지원하는 구성이나 플래폼을 제한할 수 있고, configmap 함수로 바꿀 수도 있다. 


## Filters

```lua
workspace "MyWorkspace"
   configurations { "Debug", "Release" }

   filter "configurations:Debug"
      defines { "DEBUG" }

   filter "configurations:Release"
      defines { "NDEBUG" }
```

- 지정된 필더는 유지된다. 
- 따라서, configurations과 platform을 동시에 필터링 할 수 있다. 
- 원래대로 복구하는 명령은 filter {} 이다. 
  - 빈 목록으로 필터를 비우고, 글로벌 필터를 선택한다. 
  - 따라서, 전체에 적용된다. 

```lua
filter {}
  files { "**.cpp" }  
```

## Build Settings 

https://github.com/premake/premake-core/wiki/Build-Settings

여기는 주기적으로 방문해서 확인할 필요가 있다. 

- pchheaer, pchsource 
- 


## Using Modules 

- 5.0에 추가된 기능 
  - work in progress (WIP)


## Tutorial 

- premake example w/ GLFW and OpenGL 
- wise.external.premake.tutorial/README.md 문서에서 진행 




