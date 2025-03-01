pipeline {
    agent any

    environment {
        WORKSPACE_DIR = "/var/lib/jenkins/workspace/Flask-CI-CD"
        VENV_DIR = "venv"
        FLASK_LOG = "flask.log"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'master', url: 'https://github.com/esurendrababu/latest_portfolio_flask.git'
            }
        }

        stage('Setup Virtual Environment') {
            steps {
                script {
                    sh """
                    cd ${env.WORKSPACE_DIR}  # Use ${env.WORKSPACE_DIR} instead of ${WORKSPACE_DIR}
                    if [ ! -d "${env.VENV_DIR}" ]; then
                        python3 -m venv ${env.VENV_DIR}
                    fi
                    """
                }
            }
        }

        stage('Install Dependencies') {
            steps {
                sh """
                cd ${env.WORKSPACE_DIR}  # Use ${env.WORKSPACE_DIR} instead of ${WORKSPACE_DIR}
                source ${env.VENV_DIR}/bin/activate
                pip install -r requirements.txt
                """
            }
        }

        stage('Deploy Application') {
            steps {
                sh """
                cd ${env.WORKSPACE_DIR}
                source ${env.VENV_DIR}/bin/activate

                # Kill existing Gunicorn process if running
                pkill -f 'gunicorn' || true

                # Allow Gunicorn to use port 80 (one-time setup)
                sudo setcap 'cap_net_bind_service=+ep' $(which gunicorn)

                # Start Gunicorn on port 80
                nohup gunicorn --bind 0.0.0.0:80 app:app > ${env.FLASK_LOG} 2>&1 &
                """
            }
        }
    }


