# libsodium 



https://github.com/jedisct1/libsodium

- 다운로드 설치 
- $(LIBSODIUM) 환경 변수 설정 

- https://github.com/jedisct1/libsodium/releases
  - libsodium prebuilt 라이브러리로 사용 시도 
  - 다운로드 실패가 계속 나오고 내부 구현도 볼 필요가 있어 소스 빌드 


## 소스 빌드 

- visual studio solution 파일이 있다. 
- vs2019라 솔루션 파일 업그레이드 


- batch build configurations 
  - Debug 
  - Release
  - DebugDLL
  - ReleaseDLL 

- platform 
  - win32 
  - x64

### 빌드 

- ReelaseDLL | x64 부터 시작 
  - 빌드하고 테스트 진행 
  - 배워둘만한 내용 

- $(LIBSODIUM)/Build/ReleaseDLL/x64
  - libsodium.dll 
  - libsodium.lib 
  - libsodium.pdb 

다른 폴더도 동일한 구성이다. 

### 선택 

- 위 파일들을 옮겨서 정리할 것인지 그냥 둘 것인지? 

항상 고민되던 부분인데 앞으로는 "그냥" 원작자가 정리한 대로 사용한다. 

옮기거나 이름을 바꾸지 않는다!! 그게 가장 쉽고 깔끔하다. wise.external을 만든 이유이기도 하다. 

use as it is!










