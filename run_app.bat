@echo off
REM Quick Launch - Gradio Application
REM Run this after setup is complete

cd /d C:\Users\User\Documents\curso_python\2_deploy_app_with_code_engine
call .venv\Scripts\activate.bat
cd myapp
echo.
echo Starting Gradio app...
echo Access at: http://localhost:7860
echo Press CTRL+C to stop
echo.
python demo.py
