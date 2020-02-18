# spdlog 



- https://github.com/gabime/spdlog
- 헤더 only로 쓸 수 있으나 컴파일도 가능 
  - 전에는 없던 옵션 


## 빌드 

- github에서 받는다. 

```powershell
md build 
cd build 
cmake .. 
```
위 명령어로 생성. 

- [이슈] circula_q.hpp 를 unicode 저장하라는 오류 
  - visual studio code에서 UTF8 BOM으로 변경 저장 OK 

- [이슈] cmake 후 빌드에서 pdb가 흩어지는 등 복잡함 
  - cmake 관련 규약을 만든다. 
  - lib 폴더 만들기 
    - 이름 붙이기? 폴더?
    - boost와 같이 이름 붙이기로 간다. 

CMake 프로젝트의 INSTALL 실행에서 spdlog-1.5.0-win64.zip 파일을 만든다. 여기에 헤더랑 lib 파일이 들어있다. 좋은 시도이긴 하나 pdb가 없으면 디버깅이 어렵다. 

- spdlog_install.ps1 
  - powershell 스크립트 추가 






