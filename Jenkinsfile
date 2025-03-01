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
                sh 'source $VENV_DIR/bin/activate && pip install --upgrade pip'
                sh 'source $VENV_DIR/bin/activate && pip install -r requirements.txt'
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    def testDirExists = sh(script: '[ -d tests ] && echo "exists" || echo "not exists"', returnStdout: true).trim()
                    if (testDirExists == "exists") {
                        sh 'source $VENV_DIR/bin/activate && pytest tests/'
                    } else {
                        echo "Skipping tests as no 'tests/' directory exists."
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                pkill -f gunicorn || true  # Stop any running Gunicorn process
                cd project
                source ../venv/bin/activate
                nohup gunicorn --bind 0.0.0.0:80 app:app > ../flask.log 2>&1 &
                '''
            }
        }
    }
}
