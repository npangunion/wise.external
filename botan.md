# botan 

sodium을 많이 쓴다고 하지만 botan도 매우 좋은 라이브러리이다.
C#의 기본 암호 기능과 맞춰 사용하면 Unity나 다른 언어와 플래폼에서 사용 가능하다. 
따라서, sodium 대신 이전의 보탄을 계속 사용한다. 
보탄은 작약이다.


## 빌드 

x64, x86 용으로 필요한 파일을 미리 확보한다. 

빌드가 깨진 상태이고 많은 파일이 추가되었다. 이 작업을 하면서 빌드를 다시 살린다. 
다음 bits 동작하게 한다. 그러면 상당히 많이 진전된 것이다. 

https://botan.randombit.net/handbook/building.html


```
$ ./configure.py [--prefix=/some/directory]
$ make
$ make install
```

### configure.py

`--cc`, `--os`, `--cpu`


기능: 
- CRC32
- SHA1
- AES-128 


windows: 
```
$ python configure.py --cc=msvc --os=windows
$ nmake
$ botan-test.exe
$ nmake install
```

### amalgamation build 

이걸 사용했었다. 몇 개 폴더로 나눠서 만들면 되지 않을까? 

--amalgamation 
--single-amalgamation-file 
--minimized-build 

--enable-modules=MODS

configure.py --list-modules 

- aes
- crc32
- sha1 
- 


Run1: 
```
.\configure.py --amalgamation --minimized-build --enable-modules=aes --enable-modules=crc32 --enable-modules=sha1
```

- cl을 못 찾는다는 에러 ==> Vs2019 developer prompt 열기 
- target architecture x86_64인데 컴파일러 아키텍처가 x86_32라는 오류 
    - disable-cc-tests


최종 실행 
```c++
.\configure.py --amalgamation --minimized-build --enable-modules=aes --enable-modules=crc32 --enable-modules=sha1  --disable-cc-tests --cpu=x64 --msvc-runtime=MT --enable-static-library
   
```       

–msvc-runtime=RT

## 사용 프로젝트 

사용하는 곳인 wise.kernel 프로젝트에서 어떻게 처리할 것인가? 
x86, x64, android 등 플래폼 별로 추가? 잠깐 생각을 좀 해본다. 

- premake5에서 구성 
  - 아키텍터별 파일 선택
  - 이것도 괜찮은 선택일 듯

- 아키텍처 define에 따라 파일 포함 선택 
  - 프로젝트 파일에서는 제외하고 포함해서 빌드 
    - 디버깅이 어려워지는 문제 


- dll로 기본 빌드 됨 
  --enable-static-library

define을 사용 
- _ENABLE_EXTENDED_ALIGNED_STORAGE
- botan에서 공식적으로 얘기한 내용. 

std::aligned_storage<>는 무엇인가? 

- https://stackoverflow.com/questions/50271304/for-which-purposes-needs-stdaligned-storage
  - 생성자 호출없이 정렬된 메모리를 할당하고자 할 때 사용 
  - 써보지는 않았다. 

## 흐름 정리 

- configure.py x86, x64 옵션으로 각각 botan_all.h와 botan_all.cpp 생성
- core/botan/arch의 각 폴더에 복사 
- 헤더와 cpp 나눠서 복사
- #include <wise.kernel/core/botan/botan.hpp>를 포함하도록 수정


# 마지막 정리 

다른 방법들은 여러 가지 어려움이 있고, 그냥 빌드하는 것이 가장 좋다. 

wise.external에 prebuilt를 추가했다. 빌드나 구성이 어려운 경우 미리 구성해 둔다. 
보탄은 플래폼별로 빌드와 링크가 필요하다. 

prebuilt/botan/x64와 x86 폴더에 windows 빌드를 구성한다. 

정적 빌드로 wise.kernel에서 사용이 편하도록 한다. 

configure.py의 옵션은 다음과 같다. 
```
configure.py --enable-static-library --os=windows --cc=msvc --cpu=x64
configure.py --enable-static-library --os=windows --cc=msvc --cpu=x86
```

빌드할 때 각각 x64, x86 컴파일러 환경에서 실행해야 한다. 

만들어진 파일들은 손으로 복사했다. 

꽤 오랜 시간 libsodium까지 헤매고 cryptopp로 돌아갈까 생각도 하면서 약 6시간 이상 작업했다. 
끝까지 보는 게 중요하다. 또 조급하지 않는 게 중요하다. 보탄을 만든 사람은 얼마나 오랜 시간 
많은 공을 들여서 그 수준에 이르렀겠는가? 





