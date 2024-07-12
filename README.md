# Sample-Java-Web-Application
## To set up a sample Maven Java web application with the specified DevOps pipeline, you'll need to follow several steps. Here is a high-level overview and a basic setup guide for each component:

1. **Create a Sample Maven Java Web Application**
2. **Set Up GitHub Repository**
3. **Set Up Jenkins for CI/CD**
4. **Integrate SonarQube and Nexus**
5. **Create and Push Docker Image**
6. **Deploy to Kubernetes**
7. **Set Up Prometheus and Grafana for Monitoring**

### 1. Create a Sample Maven Java Web Application

**Directory Structure:**
```
sample-java-webapp/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/
│   │   │       └── example/
│   │   │           └── App.java
│   │   └── webapp/
│   │       └── WEB-INF/
│   │           └── web.xml
│   └── test/
│       └── java/
│           └── com/
│               └── example/
│                   └── AppTest.java
├── pom.xml
└── Dockerfile
```
```
#!/bin/bash

# Define directory structure
BASE_DIR="sample-java-webapp"
SRC_DIR="$BASE_DIR/src"
MAIN_DIR="$SRC_DIR/main"
JAVA_DIR="$MAIN_DIR/java/com/example"
WEBAPP_DIR="$MAIN_DIR/webapp/WEB-INF"
TEST_DIR="$SRC_DIR/test/java/com/example"

# Create directories
mkdir -p $JAVA_DIR
mkdir -p $WEBAPP_DIR
mkdir -p $TEST_DIR

# Create App.java
cat <<EOL > $JAVA_DIR/App.java
package com.example;

import javax.servlet.http.*;
import javax.servlet.*;
import java.io.*;

public class App extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("<h1>Hello, World!</h1>");
    }
}
EOL

# Create web.xml
cat <<EOL > $WEBAPP_DIR/web.xml
<web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-app_3_1.xsd"
         version="3.1">
    <servlet>
        <servlet-name>App</servlet-name>
        <servlet-class>com.example.App</servlet-class>
    </servlet>
    <servlet-mapping>
        <servlet-name>App</servlet-name>
        <url-pattern>/</url-pattern>
    </servlet-mapping>
</web-app>
EOL

# Create AppTest.java
cat <<EOL > $TEST_DIR/AppTest.java
package com.example;

import static org.junit.Assert.assertTrue;
import org.junit.Test;

public class AppTest {
    @Test
    public void shouldAnswerWithTrue() {
        assertTrue(true);
    }
}
EOL

# Create pom.xml
cat <<EOL > $BASE_DIR/pom.xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://www.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <groupId>com.example</groupId>
    <artifactId>sample-java-webapp</artifactId>
    <version>1.0-SNAPSHOT</version>
    <packaging>war</packaging>
    <build>
        <finalName>sample-java-webapp</finalName>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.8.1</version>
                <configuration>
                    <source>1.8</source>
                    <target>1.8</target>
                </configuration>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-war-plugin</artifactId>
                <version>3.3.1</version>
            </plugin>
        </plugins>
    </build>
</project>
EOL

# Create Dockerfile
cat <<EOL > $BASE_DIR/Dockerfile
FROM tomcat:9.0-jdk11-openjdk

COPY target/sample-java-webapp.war /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["catalina.sh", "run"]
EOL

echo "Sample Maven Java web application structure created successfully."
```

**`pom.xml`:**
```xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <groupId>com.example</groupId>
    <artifactId>sample-java-webapp</artifactId>
    <version>1.0-SNAPSHOT</version>
    <packaging>war</packaging>
    <build>
        <finalName>sample-java-webapp</finalName>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.8.1</version>
                <configuration>
                    <source>1.8</source>
                    <target>1.8</target>
                </configuration>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-war-plugin</artifactId>
                <version>3.3.1</version>
            </plugin>
        </plugins>
    </build>
</project>
```

**`src/main/java/com/example/App.java`:**
```java
package com.example;

import javax.servlet.http.*;
import javax.servlet.*;
import java.io.*;

public class App extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("<h1>Hello, World!</h1>");
    }
}
```

**`src/main/webapp/WEB-INF/web.xml`:**
```xml
<web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-app_3_1.xsd"
         version="3.1">
    <servlet>
        <servlet-name>App</servlet-name>
        <servlet-class>com.example.App</servlet-class>
    </servlet>
    <servlet-mapping>
        <servlet-name>App</servlet-name>
        <url-pattern>/</url-pattern>
    </servlet-mapping>
</web-app>
```

### 2. Set Up GitHub Repository

1. Create a new repository on GitHub.
2. Clone the repository to your local machine and add the sample Maven Java web application.
3. Push the code to the GitHub repository.

```sh
git init
git add .
git commit -m "Initial commit"
git remote add origin <your-repository-url>
git push -u origin master
```

### 3. Set Up Jenkins for CI/CD

1. **Install Jenkins:**
    ```sh
    sudo apt update
    sudo apt install openjdk-11-jdk
    wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
    sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
    sudo apt update
    sudo apt install jenkins
    sudo systemctl start jenkins
    sudo systemctl enable jenkins
    ```

2. **Configure Jenkins:**
    - Access Jenkins at `http://<your-server-ip>:8080`.
    - Install required plugins (Git, Maven Integration, Docker Pipeline, Kubernetes, SonarQube Scanner, Nexus Artifact Uploader).

3. **Create Jenkins Pipeline:**
    - Create a new pipeline job in Jenkins and configure the pipeline script.

**Pipeline Script (Jenkinsfile):**
```groovy
pipeline {
    agent any

    tools {
        maven 'Maven'
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/<your-repo>/sample-java-webapp.git'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh 'mvn sonar:sonar'
                }
            }
        }
        stage('Nexus Artifact Upload') {
            steps {
                nexusArtifactUploader(
                    nexusVersion: 'nexus3',
                    protocol: 'http',
                    nexusUrl: '<nexus-url>',
                    groupId: 'com.example',
                    version: '1.0-SNAPSHOT',
                    repository: 'maven-releases',
                    credentialsId: 'nexus-credentials',
                    artifacts: [
                        [artifactId: 'sample-java-webapp', classifier: '', file: 'target/sample-java-webapp.war', type: 'war']
                    ]
                )
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("your-dockerhub-username/sample-java-webapp:${env.BUILD_ID}")
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-credentials') {
                        dockerImage.push("${env.BUILD_ID}")
                        dockerImage.push("latest")
                    }
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                kubernetesDeploy(
                    configs: 'k8s/deployment.yaml',
                    kubeconfigId: 'kubeconfig'
                )
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}
```

### 4. Integrate SonarQube and Nexus

- **Install and Configure SonarQube:**
    ```sh
    sudo docker run -d --name sonarqube -p 9000:9000 sonarqube
    ```

- **Install and Configure Nexus:**
    ```sh
    sudo docker run -d -p 8081:8081 --name nexus sonatype/nexus3
    ```

### 5. Create and Push Docker Image

**Dockerfile:**
```dockerfile
FROM tomcat:9.0-jdk11-openjdk

COPY target/sample-java-webapp.war /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["catalina.sh", "run"]
```

### 6. Deploy to Kubernetes

**Kubernetes Deployment YAML (`k8s/deployment.yaml`):**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: sample-java-webapp
spec:
  replicas: 3
  selector:
    matchLabels:
      app: sample-java-webapp
  template:
    metadata:
      labels:
        app: sample-java-webapp
    spec:
      containers:
      - name: sample-java-webapp
        image: your-dockerhub-username/sample-java-webapp:latest
        ports:
        - containerPort: 8080
---
apiVersion: v1
kind: Service
metadata:
  name: sample-java-webapp-service
spec:
  selector:
    app: sample-java-webapp
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8080
  type: LoadBalancer
```

### 7. Set Up Prometheus and Grafana for Monitoring

**Install Prometheus and Grafana:**
```sh
kubectl create namespace monitoring
kubectl apply -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/master/bundle.yaml -n monitoring
kubectl apply -f https://raw.githubusercontent.com/grafana/helm-charts/main/charts/grafana/crds/crds.yaml
```

**Prometheus Configuration:**
```yaml
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: sample-java-webapp
  labels:
    release: prometheus-operator
spec:
  selector:
    matchLabels:
      app: sample-java-webapp
  endpoints:
  - port: web
   

 interval: 30s
```

**Grafana Dashboard Configuration:**
- Access Grafana at `http://<grafana-url>:3000`.
- Add Prometheus as a data source.
- Create dashboards to monitor the application.

This should set up a complete pipeline for your Maven Java web application using the specified tools.
