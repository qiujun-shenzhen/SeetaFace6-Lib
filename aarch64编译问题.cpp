
1.OpenRoleZoo
	aarch64-linux-gnu-g++: error: unrecognized command line option ‘-m64’
	src/CMakeFiles/ORZ_STATIC.dir/build.make:374: recipe for target 'src/CMakeFiles/ORZ_STATIC.dir/orz/io/stream/filestream.cpp.o' failed
//解决方法：
	cp ./build.linux.x64.sh ./build.linux.aarch64.sh
	sed -i "s/x64/aarch64/" ./build.linux.aarch64.sh
	
================================================================
2.OpenRoleZoo
//无效命名空间
In file included from /home/qiujun/SeetaFace6Open/OpenRoleZoo/src/orz/mem/pot.cpp:5:0:
/home/qiujun/SeetaFace6Open/OpenRoleZoo/src/../include/orz/mem/pot.h:15:32: error: ‘function’ in namespace ‘std’ does not name a template type
         using allocator = std::function<std::shared_ptr<void>(size_t)>;
//解决方法：添加头文件
SeetaFace6Open/OpenRoleZoo/src/../include/orz/mem/pot.h 
#include <functional>

================================================================
3.TenniS
//SIMD宏配置问题
aarch64-linux-gnu-g++: error: unrecognized command line option ‘-mavx’
aarch64-linux-gnu-g++: error: unrecognized command line option ‘-mavx2’
aarch64-linux-gnu-g++: error: unrecognized command line option ‘-mfma’
CMakeFiles/tennis_LIB.dir/build.make:158: recipe for target 'CMakeFiles/tennis_LIB.dir/src/api/operator_gpu.cpp.o' failed
aarch64-linux-gnu-g++: error: unrecognized command line option ‘-msse2’
----------------------------------------------------------------------
CMake配置如下
----------------------------------------------------------------------
-- == Target: SHARED
-- == Platform: aarch64
-- == Configuration: Release
-- [Important] Use debug API: [OFF]
-- [Optional] Use Winograd: [OFF]
-- [Optional] Use OpenCV: [OFF]
-- [Optional] Use OpenMP: [ON]
-- [Optional] Use CUDA: [OFF]
-- [Optional] Use CUBLAS: [OFF]
-- [Optional] Use CBLAS: [OFF]
-- [Optional] Use SIMD: [ON]
-- [Optional] Use AVX and FMA: [ON]
-- [Info] target:tennis_LIB support avx and fma
-- [Optional] Dynamic support for different instruction sets: [ON]
-- [Info] target:tennis_haswell_LIB support avx and fma
-- [Info] target:tennis_sandy_bridge_LIB support avx
-- [Info] target:tennis_pentium_LIB support sse
-- [Important] Build test: [OFF]
-- [Important] Build tools: [OFF]
-- Configuring done
-- Generating done
-- Build files have been written to: /home/qiujun/SeetaFace6Open/TenniS/craft/build.linux.aarch64
----------------------------------------------------------------------
aarch64不支持这些SIMD指令：avx fma sse;支持neon
//解决方法：
SeetaFace6Open/TenniS/craft/build.linux.aarch64.sh中:
-DTS_ON_HASWELL=ON \
-DTS_DYNAMIC_INSTRUCTION=ON
替换为：
-DTS_USE_NEON=ON

SeetaFace6Open/TenniS/include/kernels/common/simd.h

================================================================
4.QualityAssessor3
//cmake编译环境配置问题
//cmake查找SeetaAuthorize_LIBRARY失败
find_package SeetaAuthorize_LIBRARY

QualityAssessor3/craft
-- The C compiler identification is GNU 7.4.1
-- The CXX compiler identification is GNU 7.4.1
-- Check for working C compiler: /home/qiujun/AllwinnerT5/gcc-linaro-aarch64-linux-gnu/bin/aarch64-linux-gnu-gcc
-- Check for working C compiler: /home/qiujun/AllwinnerT5/gcc-linaro-aarch64-linux-gnu/bin/aarch64-linux-gnu-gcc -- works
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Detecting C compile features
-- Detecting C compile features - done
-- Check for working CXX compiler: /home/qiujun/AllwinnerT5/gcc-linaro-aarch64-linux-gnu/bin/aarch64-linux-gnu-g++
-- Check for working CXX compiler: /home/qiujun/AllwinnerT5/gcc-linaro-aarch64-linux-gnu/bin/aarch64-linux-gnu-g++ -- works
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Detecting CXX compile features
-- Detecting CXX compile features - done
-- Found ORZ in /home/qiujun/SeetaFace6Open/QualityAssessor3/craft/../../build
-- Build with ORZ
-- Seeta Authorize: OFF
-- Seeta Model Encrypt: ON
-- SeetaModelEncrypt: ON
-- Configuration: Release
-- SEETA_AUTHORIZE_HOME: /home/qiujun/SeetaFace6Open/build/cmake/../
-- SeetaAuthorize_LIBRARY : SEETA_AUTHORIZE_LIBRARY_RELEASE-NOTFOUND
CMake Error at /usr/share/cmake-3.5/Modules/FindPackageHandleStandardArgs.cmake:148 (message):
  Could not find seeta authorize!try to set the path to SeetaAuthorize root
  folder in the system variable SeetaAuthorize_ROOT_DIR (missing:
  SeetaAuthorize_LIBRARY)
Call Stack (most recent call first):
  /usr/share/cmake-3.5/Modules/FindPackageHandleStandardArgs.cmake:388 (_FPHSA_FAILURE_MESSAGE)
  /home/qiujun/SeetaFace6Open/build/cmake/FindSeetaAuthorize.cmake:89 (FIND_PACKAGE_HANDLE_STANDARD_ARGS)
  QualityAssessor/CMakeLists.txt:65 (find_package)


-- Configuring incomplete, errors occurred!
See also "/home/qiujun/SeetaFace6Open/QualityAssessor3/craft/build.linux.aarch64/CMakeFiles/CMakeOutput.log".

//解决方法：cmake配置修改
SeetaFace6Open/QualityAssessor3/cmake/LOCAL_ENV.cmake
添加gcc下除x86和x64的其他架构的编译环境配置
//34行起
	else()
		set(ENV_RUNTIME_DIR ${ENV_RUNTIME_DIR}/${PLATFORM})
		set(ENV_LIBRARY_DIR ${ENV_LIBRARY_DIR}/${PLATFORM})
		set(ENV_ARCHIVE_DIR ${ENV_ARCHIVE_DIR}/${PLATFORM})
	endif()

