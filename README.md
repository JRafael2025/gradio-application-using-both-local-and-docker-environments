# GitHub Auto Post Gradio Application

## Project Overview
The **GitHub Auto Post** project is a Python-based web application built using the Gradio framework. This application allows users to interact with a simple interface where they can input data and receive a response. It provides a convenient way to demonstrate model deployment with Gradio, showcasing both local and Docker deployment methods.

## Project Structure
The project is organized into two main directories: 

```
Github Auto Post/
│
├── myapp/
│   ├── demo.py         # Gradio application script
│   ├── requirements.txt # Python dependencies for the project
│   └── Dockerfile      # Docker configuration for containerized deployment
│
└── setup_gradio_project_FINAL.bat  # Script to set up the Gradio project
```

## Main Features
- **Interactive UI**: A simple user interface for inputting data and displaying responses.
- **Local and Docker Deployment**: The application can be run locally or within a Docker container for easy sharing and deployment.
- **User-Friendly Setup**: A batch script to automate the setup process of the Gradio project.

## Key Files and Their Roles
- **`demo.py`**: The main Gradio application script that defines the interface and functionality of the app.
- **`requirements.txt`**: Contains the necessary dependencies for the Gradio application, including the latest stable version of the Gradio framework.
- **`Dockerfile`**: Configuration file for building a Docker image of the Gradio application.
- **`setup_gradio_project_FINAL.bat`**: A batch script that sets up the project environment and prepares required files for development.
- **`run_app.bat`**: A quick launch script that starts the Gradio application after the initial setup.

## Installation and Setup Instructions

### Prerequisites
- Python 3.6 or higher
- Gradio (admin can install it via requirements.txt during setup)
- Docker Desktop (optional, for Docker deployment)
- Virtual Environment (recommended for local development)

### Setup Instructions
1. **Clone the repository** or download the project files.

2. **Navigate to the project directory** in your command line:
   ```bash
   cd C:\Users\User\Documents\curso_python\2_deploy_app_with_code_engine
   ```

3. **Run the setup script** to create project files and dependencies:
   ```bash
   setup_gradio_project_FINAL.bat
   ```

### Installation of Requirements
After running the setup script, your environment might need to be activated:
```bash
.venv\Scripts\activate  # For Windows
```
Then, install the required dependencies:
```bash
pip install -r myapp/requirements.txt
```

### Running the Application

#### Method 1: Local Development
1. Ensure your virtual environment is activated.
2. Navigate to the `myapp` directory:
   ```bash
   cd myapp
   ```
3. Run the Gradio application:
   ```bash
   python demo.py
   ```
4. Access the application in your web browser at: [http://localhost:7860](http://localhost:7860)

#### Method 2: Docker
1. Ensure Docker Desktop is running.
2. Build the Docker image:
   ```bash
   docker build -t myapp:latest .
   ```
3. Run the Docker container:
   ```bash
   docker run -p 7860:7860 myapp:latest
   ```
4. Access the application in your web browser at: [http://localhost:7860](http://localhost:7860)

## Usage Examples

Once you have the application running, you can interact with it as follows:
- Input your name in the text field.
- Adjust the slider to change the intensity of the greeting.
- Press Enter to see the output!

### Example Interactions
- **Input**: Name — `Alice`, Intensity — `3`
- **Output**: `Hello, Alice!Hello, Alice!Hello, Alice!`

Feel free to customize the inputs or enhance the functionality of the Gradio application as needed!

---

For further development, refer to the [Gradio Documentation](https://gradio.app/docs/). Enjoy building your application!