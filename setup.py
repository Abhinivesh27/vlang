from cx_Freeze import setup, Executable

setup(
    name = "vlang",
    version = "0.1",
    description = '',
    executables = [Executable("vlang.py")]
)