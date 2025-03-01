pipeline {
    agent any

    environment {
        VENV_DIR = 'venv'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/esurendrababu/latest_portfolio_flask.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'python3 -m venv $VENV_DIR'
                sh 'source $VENV_DIR/bin/activate && pip install -r requirements.txt'
            }
        }

        stage('Run Tests') {
            steps {
                sh 'source $VENV_DIR/bin/activate && pytest tests/'
            }
        }

        stage('Deploy') {
            steps {
                sh 'nohup python3 app.py &'
            }
        }
    }
}
