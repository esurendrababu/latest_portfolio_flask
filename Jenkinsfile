pipeline {
    agent any

    environment {
        APP_DIR = "/home/ec2-user/flaskapp"
        VENV_DIR = "/home/ec2-user/venv"
        GIT_REPO = "https://github.com/esurendrababu/latest_portfolio_flask.git"
    }

    stages {
        stage('Clone Repository') {
            steps {
                sh '''
                rm -rf $APP_DIR
                git clone $GIT_REPO $APP_DIR
                '''
            }
        }

        stage('Setup Virtual Environment') {
            steps {
                sh '''
                python3 -m venv $VENV_DIR
                $VENV_DIR/bin/pip install --upgrade pip
                $VENV_DIR/bin/pip install -r $APP_DIR/requirements.txt
                '''
            }
        }

        stage('Run Flask Application') {
            steps {
                sh '''
                pkill -f app.py || true  # Kill existing Flask process if running
                nohup $VENV_DIR/bin/python $APP_DIR/app.py > $APP_DIR/flask.log 2>&1 &
                '''
            }
        }
    }
}
