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

        stage('Run Flask App') {
            steps {
                sh '''
                pkill -f app.py || true  # Stop any existing Flask app instance
                source venv/bin/activate
                nohup python3 app.py > flask.log 2>&1 &
                '''
            }
        }
    }
}
