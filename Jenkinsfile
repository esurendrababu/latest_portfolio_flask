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

        stage('Configure Nginx') {
            steps {
                sh '''
                sudo rm -f /etc/nginx/conf.d/default.conf
                echo "server {
                    listen 80;
                    server_name _;
                    location / {
                        proxy_pass http://127.0.0.1:5000;
                        proxy_set_header Host $host;
                        proxy_set_header X-Real-IP $remote_addr;
                        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                    }
                }" | sudo tee /etc/nginx/conf.d/flaskapp.conf
                sudo systemctl restart nginx
                '''
            }
        }
    }
}
