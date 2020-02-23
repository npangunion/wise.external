# glew

## 다운로드 

- windows binary download
  - sourceforge
  - x64, w32를 포함 

## 환경변수 설정

- GLEW_HOME 
- glew32s를 사용 

## 링크 

```
/OUT:"..\build\bin\GoRecast\Debug\GoRecast.exe" /MANIFEST /NXCOMPAT /PDB:"..\build\bin\GoRecast\Debug\GoRecast.pdb" /DYNAMICBASE "glfw3.lib" "glew32s.lib" "opengl32.lib" "kernel32.lib" "user32.lib" "gdi32.lib" "winspool.lib" "comdlg32.lib" "advapi32.lib" "shell32.lib" "ole32.lib" "oleaut32.lib" "uuid.lib" "odbc32.lib" "odbccp32.lib" /DEBUG /MACHINE:X64 /INCREMENTAL /PGD:"..\build\bin\GoRecast\Debug\GoRecast.pgd" /SUBSYSTEM:CONSOLE /MANIFESTUAC:"level='asInvoker' uiAccess='false'" /ManifestFile:"..\build\obj\GoRecast\Debug\GoRecast.exe.intermediate.manifest" /ERRORREPORT:PROMPT /NOLOGO /LIBPATH:"..\..\..\wise.external\libs\glfw-3.3.2\lib-vc2019" /LIBPATH:"..\..\..\wise.external\libs\glew-2.1.0\lib\Release\x64" /TLBID:1 
```
위 명령 라인에서 오류가 생긴다. 

- glew32.lib를 링크하고 dll 버전을 사용 
- glewInit()를 opengl 문맥 만들고 호출 

아래는 ImGui 초기화 절차이다. 

```c++
 glfwSetErrorCallback(glfw_error_callback);
    if (!glfwInit())
        return 1;

    // GL 3.0 + GLSL 130
    const char* glsl_version = "#version 130";
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    //glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);            // 3.0+ only

    // Create window with graphics context
    GLFWwindow* window = glfwCreateWindow(1280, 720, "Dear ImGui GLFW+OpenGL3 example", NULL, NULL);
    if (window == NULL)
        return 1;
    glfwMakeContextCurrent(window);
    glfwSwapInterval(1); // Enable vsync

    int err = glewInit();

    if (err)
    {
        fprintf(stderr, "Failed to initialize OpenGL loader!\n");
        return 1;
    }
```






