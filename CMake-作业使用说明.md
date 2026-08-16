# 用 VS Code 和 CMake 构建 CS106B 作业（便携版）

Assignment 0 到 Assignment 9 都已经拥有独立的 CMake 与 VS Code 配置。请在 VS Code 中直接打开某一个 `Assignment X` 文件夹，而不是打开本文件夹。

每个作业都保留原有 `.pro` 文件和旧 `build/` 目录；新的构建结果只会写入该作业的 `out/` 目录。

## 解压后直接使用

GitHub 版本不包含 `toolchain/`。CMake 会优先扫描 `C:\Qt\<任意版本>\mingw_64` 和 `C:\Qt\Tools\mingw*`；找不到时使用 `CS106B_QT_ROOT`、`CS106B_MINGW_ROOT`、`CS106B_NINJA` 和 `CS106B_ROOT` 环境变量。

接收者需要安装 Qt 6（MinGW 版本）、CMake、Ninja、CS106 库、VS Code，以及微软的 **CMake Tools** 和 **C/C++** 扩展。默认安装在 `C:\Qt` 时会自动探测；自定义安装位置时先设置上述环境变量。然后打开具体的 `Assignment X` 文件夹。

## 常用命令

进入任意作业目录后运行：

```powershell
& '..\toolchain\CMake_64\bin\cmake.exe' --preset debug-ninja
& '..\toolchain\CMake_64\bin\cmake.exe' --build --preset debug-ninja
```

VS Code 中，`Ctrl+Shift+B` 会构建，`F5` 会构建后调试。程序工作目录始终是作业根目录，因此 `res/` 下的样例文件能正常读取。

`compile_commands.json` 会生成在 `Assignment X/out/build/debug-ninja/`；C/C++ 扩展已配置为自动读取它。

项目内的 Ninja 位于 `toolchain\Ninja\ninja.exe`，已与此工具链逐个验证。不要改用 MinGW Makefiles。

不要使用 PATH 中的 MSYS2 `g++`；这些作业必须与 CS106 静态库和 Qt 6 一起使用项目内的 `toolchain\mingw1310_64\bin\g++.exe`。

## 调试

本副本位于纯英文路径 `E:\cs106b-vs`，不需要目录联接。`launch.json` 会通过 CMake Tools 自动定位当前作业的可执行文件，并以当前工作区作为工作目录。

按 F5 后会出现一个独立的终端窗口；请在该窗口完成 CS106 控制台的输入。不要在 VS Code 的“调试控制台”输入，因为已明确关闭其 Windows GDB 重定向，以避免 Qt 的 `QSystemLocale` 访问违规。


