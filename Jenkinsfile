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
                source $VENV_DIR/bin/activate
                pip install --upgrade pip
                pip install -r $APP_DIR/requirements.txt
                '''
            }
        }

        stage('Run Flask Application') {
            steps {
                sh '''
                nohup python3 $APP_DIR/app.py > flask.log 2>&1 &
                '''
            }
        }

        
        }
    }
}
