@echo off
REM ============================================================================
REM Local Deployment Script - Gradio Application Setup
REM Replicates "Deploy your app with Code Engine" course flow (local version)
REM Version 1.1 - Improved virtual environment handling
REM ============================================================================

echo.
echo ========================================
echo  Gradio Project Setup Script
echo  (Local Environment)
echo ========================================
echo.

REM --------------------------------------------------------------------------
REM STEP 1: Navigate to base path
REM --------------------------------------------------------------------------
echo [STEP 1/6] Navigating to project directory...
cd /d C:\Users\User\Documents\curso_python\2_deploy_app_with_code_engine
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Could not navigate to base path. Please verify the directory exists.
    pause
    exit /b 1
)
echo OK - Current directory: %CD%
echo.

REM --------------------------------------------------------------------------
REM STEP 2: Verify and activate existing virtual environment
REM --------------------------------------------------------------------------
echo [STEP 2/6] Activating virtual environment (.venv)...

REM Check if .venv exists
if not exist ".venv" (
    echo ERROR: Virtual environment directory .venv not found
    echo.
    echo SOLUTION: Create the virtual environment first:
    echo    cd C:\Users\User\Documents\curso_python\2_deploy_app_with_code_engine
    echo    python -m venv .venv
    echo.
    pause
    exit /b 1
)

REM Check if activate.bat exists
if not exist ".venv\Scripts\activate.bat" (
    echo ERROR: Virtual environment activation script not found at .venv\Scripts\activate.bat
    echo.
    echo SOLUTION: Recreate the virtual environment:
    echo    cd C:\Users\User\Documents\curso_python\2_deploy_app_with_code_engine
    echo    rmdir /s /q .venv
    echo    python -m venv .venv
    echo.
    pause
    exit /b 1
)

call .venv\Scripts\activate.bat
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to activate virtual environment
    pause
    exit /b 1
)

echo OK - Virtual environment activated
echo.

REM --------------------------------------------------------------------------
REM STEP 3: Create project structure (myapp directory)
REM --------------------------------------------------------------------------
echo [STEP 3/6] Creating project structure...
if not exist "myapp" (
    mkdir myapp
    echo OK - Created myapp directory
) else (
    echo OK - myapp directory already exists
)
echo.

REM --------------------------------------------------------------------------
REM STEP 4: Create application files
REM --------------------------------------------------------------------------
echo [STEP 4/6] Creating application files...

REM Create demo.py
echo Creating demo.py...
(
echo import gradio as gr
echo.
echo def greet^(name, intensity^):
echo     return "Hello, " + name + "!" * int^(intensity^)
echo.
echo demo = gr.Interface^(
echo     fn=greet,
echo     inputs=["text", "slider"],
echo     outputs=["text"],
echo ^)
echo.
echo demo.launch^(server_name="0.0.0.0", server_port=7860^)
) > myapp\demo.py
echo OK - demo.py created

REM Create requirements.txt with updated versions
echo Creating requirements.txt...
(
echo # Gradio framework for UI generation
echo # Using latest stable version ^(updated from course's 5.23.2^)
echo gradio^>=5.11.0
) > myapp\requirements.txt
echo OK - requirements.txt created

REM Create Dockerfile with modern Python version
echo Creating Dockerfile...
(
echo # Use latest stable Python 3.12 base image
echo FROM python:3.12-slim
echo.
echo # Set working directory
echo WORKDIR /app
echo.
echo # Copy requirements first for better layer caching
echo COPY requirements.txt requirements.txt
echo.
echo # Install dependencies
echo RUN pip3 install --no-cache-dir -r requirements.txt
echo.
echo # Copy application code
echo COPY . .
echo.
echo # Expose Gradio default port
echo EXPOSE 7860
echo.
echo # Run the application
echo CMD ["python", "demo.py"]
) > myapp\Dockerfile
echo OK - Dockerfile created
echo.

REM --------------------------------------------------------------------------
REM STEP 5: Install dependencies
REM --------------------------------------------------------------------------
echo [STEP 5/6] Installing dependencies...
echo.
echo IMPORTANT: Installing into activated virtual environment
echo Virtual env location: %VIRTUAL_ENV%
echo.

cd myapp
pip install -r requirements.txt
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo WARNING: Some packages may have failed to install.
    echo Check the output above for details.
    echo.
) else (
    echo.
    echo OK - All dependencies installed successfully
)
cd ..
echo.

REM --------------------------------------------------------------------------
REM STEP 6: Summary and next steps
REM --------------------------------------------------------------------------
echo [STEP 6/6] Setup complete!
echo.
echo ========================================
echo  SUMMARY
echo ========================================
echo.
echo Project structure created at:
echo   %CD%\myapp
echo.
echo Files created:
echo   [X] demo.py          - Gradio application
echo   [X] requirements.txt - Python dependencies  
echo   [X] Dockerfile       - Container blueprint
echo.
echo Virtual environment:
echo   [X] .venv activated
echo   [X] Gradio installed
echo.
echo ========================================
echo  NEXT STEPS - TESTING LOCALLY
echo ========================================
echo.
echo 1. Keep this terminal window open
echo 2. Run these commands:
echo.
echo    cd myapp
echo    python demo.py
echo.
echo 3. IMPORTANT: When you see "Running on local URL: http://0.0.0.0:7860"
echo    IGNORE that URL and use this instead:
echo.
echo    Open browser to: http://localhost:7860
echo.
echo 4. Press CTRL+C to stop the app
echo.
echo ========================================
echo  DOCKER WORKFLOW
echo ========================================
echo.
echo BUILD IMAGE (make sure you're in myapp directory):
echo    cd myapp
echo    docker build -t myapp:latest .
echo    ^(Note: Don't forget the dot ^(^.^) at the end!^)
echo.
echo RUN CONTAINER:
echo    docker run -p 7860:7860 myapp:latest
echo.
echo IMPORTANT: Access at http://localhost:7860
echo ^(NOT http://0.0.0.0:7860 - that won't work in browser^)
echo.
echo RUN IN BACKGROUND:
echo    docker run -d -p 7860:7860 --name gradio-app myapp:latest
echo.
echo STOP CONTAINER:
echo    docker stop gradio-app
echo.
echo VIEW LOGS:
echo    docker logs gradio-app
echo.
echo REMOVE CONTAINER:
echo    docker rm gradio-app
echo.
echo ========================================
echo  COMMON ISSUES
echo ========================================
echo.
echo ISSUE: "ModuleNotFoundError: No module named 'gradio'"
echo FIX:   Activate the virtual environment first:
echo        .venv\Scripts\activate
echo.
echo ISSUE: "docker build requires 1 argument"  
echo FIX:   Add the dot at the end:
echo        docker build -t myapp:latest .
echo.
echo ISSUE: Can't access http://0.0.0.0:7860
echo FIX:   Use http://localhost:7860 instead!
echo        ^(0.0.0.0 is server binding, not browser URL^)
echo.
echo ISSUE: Port 7860 already in use
echo FIX:   Use a different port:
echo        docker run -p 8080:7860 myapp:latest
echo        ^(Access at http://localhost:8080^)
echo.
echo ISSUE: Docker "cannot find the file specified"
echo FIX:   Start Docker Desktop application first
echo        Wait for it to fully load, then try again
echo.
echo ========================================
echo.
echo Press any key to exit...
pause >nul
