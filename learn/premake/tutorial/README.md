
# Tutorial 

https://github.com/premake/premake-core/wiki/Tutorial-Premake-example-with-GLFW-and-OpenGL

## Organizing the workspace

내 맘대로 한다. 전체 프로젝트에 일관되게 잘 적용할 수 있는 모델을 사용한다. 

## Getting the required files

- GLFW and Catch 
  - GLFW는 받아 두었다. 
- catch 


## Adding some code

- 복사해서 만들었다. 
- ExApp, ExLib, ExTest로 폴더명 지정
- 라이브러리는 $(GLFW), $(CATCH)로 참조하도록 설정 


## 환경 변수 설정 

- linux는 자유롭다. 
- windows는 쉬운 방법이 필요하다. 


### Setting Environment Variable w/ PowerShell Script 

- wise.scratchpad.LearnPowerShell에서 진행 


## 빌드 

- 개별 컴파일은 잘 됨 
- 링크에서 문제가 발생 

```
3>MSVCRTD.lib(initializers.obj) : warning LNK4098: defaultlib 'msvcrt.lib' conflicts with use of other libs; use /NODEFAULTLIB:library
3>ExTest.obj : error LNK2019: unresolved external symbol "public: __cdecl Catch::StringRef::StringRef(char const *)" (??0StringRef@Catch@@QEAA@PEBD@Z) referenced in function "public: class Catch::BinaryExpr<int const &,int const &> const __cdecl Catch::ExprLhs<int const &>::operator==<int>(int const &)" (??$?8H@?$ExprLhs@AEBH@Catch@@QEAA?BV?$BinaryExpr@AEBHAEBH@1@AEBH@Z)

... 

3>..\Build\Bin\UnitTests\Debug\UnitTests.exe : fatal error LNK1120: 18 unresolved externals
3>Done building project "UnitTests.vcxproj" -- FAILED.
2>MSVCRTD.lib(initializers.obj) : warning LNK4098: defaultlib 'msvcrt.lib' conflicts with use of other libs; use /NODEFAULTLIB:library
2>MSVCRTD.lib(exe_winmain.obj) : error LNK2019: unresolved external symbol WinMain referenced in function "int __cdecl invoke_main(void)" (?invoke_main@@YAHXZ)
2>..\Build\Bin\App\Debug\App.exe : fatal error LNK1120: 1 unresolved externals
```

- msvcrt.lib 관련 에러 

- catch 링크 에러 
  - 헤더 only 가 아니라 발생   
  - single_include로 폴더 변경 
- invoke_main 에러 
  - main()을 사용하면서 kind가 WindowedApp으로 되어 있어 발생 
  - kind를 consoleapp으로 변경 


## 실행 

실행되고 삼각형이 하나 보인다. 

### 환경 변수 이슈 

- [이슈] visual studio에서 F12로 포함 파일을 열 수 없다. 
  - os.getenv()로 확장해서 생성 시도. X
  -  


