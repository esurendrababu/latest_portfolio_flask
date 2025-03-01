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
                    cd ${WORKSPACE_DIR}
                    if [ ! -d "${VENV_DIR}" ]; then
                        python3 -m venv ${VENV_DIR}
                    fi
                    """
                }
            }
        }

        stage('Install Dependencies') {
            steps {
                sh """
                cd ${WORKSPACE_DIR}
                source \$VENV_DIR/bin/activate  # <-- Fixed escaping here
                pip install -r requirements.txt
                """
            }
        }

        stage('Deploy Application') {
            steps {
                sh """
                cd ${WORKSPACE_DIR}
                source \$VENV_DIR/bin/activate  # <-- Fixed escaping here

                # Kill existing Gunicorn process if running
                pkill -f 'gunicorn' || true

                # Allow Gunicorn to use port 80 (one-time setup)
                sudo setcap 'cap_net_bind_service=+ep' \$(which gunicorn)  # <-- Escaped $

                # Start Gunicorn on port 80
                nohup gunicorn --bind 0.0.0.0:80 app:app > \$FLASK_LOG 2>&1 &  # <-- Fixed escaping here
                """
            }
        }
    }

    post {
        success {
            echo "✅ Flask application deployed successfully!"
        }
        failure {
            echo "❌ Build failed! Check logs for details."
        }
    }
}
